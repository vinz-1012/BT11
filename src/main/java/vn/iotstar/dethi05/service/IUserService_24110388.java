package vn.iotstar.dethi05.service;

import vn.iotstar.dethi05.entity.Users_24110388;

public interface IUserService_24110388 {
    Users_24110388 login(String username, String password);
    boolean register(String username, String password, String email, String fullname, String phone, String otpCode);
    boolean register(String username, String password, String email, String fullname, String phone, String images, String otpCode);
    boolean verifyOtp(String email, String otpCode);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    Users_24110388 findByUsername(String username);
    Users_24110388 findByEmail(String email);
    void update(Users_24110388 user);
}
