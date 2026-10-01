package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.dethi05.entity.Users_24110388;
import vn.iotstar.dethi05.service.IUserService_24110388;
import vn.iotstar.dethi05.service.impl.UserService_24110388;
import vn.iotstar.dethi05.util.Constant_24110388;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24110388 userService = new UserService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
            return;
        }

        Users_24110388 user = userService.login(username.trim(), password.trim());

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute(Constant_24110388.SESSION_USER, user);

            if (user.getRole() != null && user.getRole().getRoleId() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else if (user.getSeller() != null) {
                resp.sendRedirect(req.getContextPath() + "/seller/shop");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {

            Users_24110388 existUser = userService.findByUsername(username.trim());
            if (existUser != null && (existUser.getStatus() == null || existUser.getStatus() == 0)) {
                req.setAttribute("error", "Tài khoản của bạn chưa được kích hoạt mã OTP. Vui lòng xác thực mã OTP trước khi đăng nhập!");
                req.setAttribute("unverifiedEmail", existUser.getEmail());
            } else {
                req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            }
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
        }
    }
}
