package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.dethi05.service.IUserService_24110388;
import vn.iotstar.dethi05.service.impl.UserService_24110388;
import vn.iotstar.dethi05.util.EmailUtil_24110388;
import vn.iotstar.dethi05.util.UploadUtil_24110388;

import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet(urlPatterns = {"/register"})
public class RegisterController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24110388 userService = new UserService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        String images = null;
        try {
            Part filePart = req.getPart("imageFile");
            String uploadedFileName = UploadUtil_24110388.saveUploadFile(filePart, getServletContext());
            if (uploadedFileName != null) {
                images = req.getContextPath() + "/uploads/" + uploadedFileName;
            }
        } catch (Exception e) {
            System.err.println(">> Lỗi nhận file avatar đăng ký: " + e.getMessage());
        }

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc!");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
            return;
        }

        username = username.trim();
        email = email.trim();

        if (userService.checkExistUsername(username)) {
            req.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại trên hệ thống!");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistEmail(email)) {
            req.setAttribute("error", "Địa chỉ email '" + email + "' đã được sử dụng!");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
            return;
        }

        String otpCode = EmailUtil_24110388.generateOtp();

        boolean success = userService.register(username, password, email, fullname, phone, images, otpCode);

        if (success) {
            req.setAttribute("email", email);
            req.setAttribute("message", "Đăng ký thành công! Mã OTP đã được gửi đến email " + email + ". Vui lòng nhập mã để kích hoạt.");
            req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
        }
    }
}
