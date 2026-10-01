package vn.iotstar.dethi05;

import org.junit.jupiter.api.Test;
import vn.iotstar.dethi05.util.Constant_24110388;
import vn.iotstar.dethi05.util.EmailUtil_24110388;

import static org.junit.jupiter.api.Assertions.*;

public class EmailTest_24110388 {

    @Test
    void testSendOtpEmail() {
        System.out.println("Testing email sending from: " + Constant_24110388.EMAIL_USERNAME);
        String testOtp = EmailUtil_24110388.generateOtp();
        assertNotNull(testOtp);
        assertEquals(6, testOtp.length());

        boolean success = EmailUtil_24110388.sendOtpEmail("tanvinh101206@gmail.com", testOtp);
        System.out.println("Send OTP result: " + success);
        assertTrue(success, "Gửi email OTP phải thành công!");
    }
}
