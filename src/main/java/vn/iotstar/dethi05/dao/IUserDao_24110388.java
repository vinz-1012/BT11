package vn.iotstar.dethi05.dao;

import vn.iotstar.dethi05.entity.Users_24110388;
import java.util.List;

public interface IUserDao_24110388 {
    Users_24110388 findByUsername(String username);
    Users_24110388 findByEmail(String email);
    Users_24110388 findById(int id);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
    void insert(Users_24110388 user);
    void update(Users_24110388 user);
    Users_24110388 login(String username, String password);
    boolean verifyOtp(String email, String otpCode);
    List<Users_24110388> findAll();
}
