package vn.iotstar.dethi05.util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;
import java.util.Random;

public class EmailUtil_24110388 {

    public static String generateOtp() {
        Random rnd = new Random();
        int number = rnd.nextInt(900000) + 100000;
        return String.valueOf(number);
    }

    public static boolean sendOtpEmail(String toEmail, String otpCode) {

        System.out.println("==================================================");
        System.out.println("[OTP NOTIFICATION] Gửi mã OTP đến email: " + toEmail);
        System.out.println("[OTP CODE]: " + otpCode);
        System.out.println("==================================================");

        Properties props = new Properties();
        props.put("mail.smtp.host", Constant_24110388.EMAIL_HOST);
        props.put("mail.smtp.port", Constant_24110388.EMAIL_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            Constant_24110388.EMAIL_USERNAME,
                            Constant_24110388.EMAIL_PASSWORD
                    );
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Constant_24110388.EMAIL_USERNAME, "He Thong Web DeThi05"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực tài khoản OTP - Đề 05");

            String content = "<h3>Xin chào!</h3>"
                    + "<p>Mã xác thực đăng ký tài khoản của bạn là: <strong style='font-size: 20px; color: #0d6efd;'>"
                    + otpCode + "</strong></p>"
                    + "<p>Mã này có hiệu lực trong 5 phút. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>";

            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println(">> Đã gửi email OTP thành công đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println(">> Gửi mail thất bại (vui lòng kiểm tra tài khoản Gmail trong Constant_24110388.java): " + e.getMessage());

            return false;
        }
    }
}
