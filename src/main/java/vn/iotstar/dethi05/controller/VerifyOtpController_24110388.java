package vn.iotstar.dethi05.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.dethi05.service.IUserService_24110388;
import vn.iotstar.dethi05.service.impl.UserService_24110388;

import java.io.IOException;

@WebServlet(urlPatterns = {"/verify-otp"})
public class VerifyOtpController_24110388 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUserService_24110388 userService = new UserService_24110388();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otpCode = req.getParameter("otp");

        if (email == null || email.trim().isEmpty() || otpCode == null || otpCode.trim().isEmpty()) {
            req.setAttribute("email", email);
            req.setAttribute("error", "Vui lòng nhập đầy đủ email và mã OTP!");
            req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
            return;
        }

        email = email.trim();
        otpCode = otpCode.trim();

        boolean isVerified = userService.verifyOtp(email, otpCode);

        if (isVerified) {
            req.setAttribute("message", "Tài khoản của bạn đã được kích hoạt thành công! Mời bạn đăng nhập.");
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("email", email);
            req.setAttribute("error", "Mã xác thực OTP không chính xác hoặc email không tồn tại!");
            req.getRequestDispatcher("/views/web/verify-otp.jsp").forward(req, resp);
        }
    }
}
