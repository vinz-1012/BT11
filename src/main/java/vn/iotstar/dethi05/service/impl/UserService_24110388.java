package vn.iotstar.dethi05.service.impl;

import vn.iotstar.dethi05.dao.IUserDao_24110388;
import vn.iotstar.dethi05.dao.impl.UserDao_24110388;
import vn.iotstar.dethi05.entity.UserRoles_24110388;
import vn.iotstar.dethi05.entity.Users_24110388;
import vn.iotstar.dethi05.service.IUserService_24110388;
import vn.iotstar.dethi05.util.EmailUtil_24110388;

public class UserService_24110388 implements IUserService_24110388 {

    private final IUserDao_24110388 userDao = new UserDao_24110388();

    @Override
    public Users_24110388 login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone, String otpCode) {
        return register(username, password, email, fullname, phone, null, otpCode);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone, String images, String otpCode) {
        if (checkExistUsername(username) || checkExistEmail(email)) {
            return false;
        }
        Users_24110388 user = new Users_24110388();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setImages(images);
        user.setStatus(0);
        user.setCode(otpCode);

        UserRoles_24110388 defaultRole = new UserRoles_24110388();
        defaultRole.setRoleId(2);
        user.setRole(defaultRole);

        userDao.insert(user);

        EmailUtil_24110388.sendOtpEmail(email, otpCode);

        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otpCode) {
        return userDao.verifyOtp(email, otpCode);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public Users_24110388 findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public Users_24110388 findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void update(Users_24110388 user) {
        userDao.update(user);
    }
}
