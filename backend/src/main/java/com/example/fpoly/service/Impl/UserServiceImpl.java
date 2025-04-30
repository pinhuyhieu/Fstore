package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.Role;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.RoleRepository;
import com.example.fpoly.repository.UserRepository;
import com.example.fpoly.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public User saveUser(User user) {
        user.setMatKhau(passwordEncoder.encode(user.getMatKhau())); // Mã hóa mật khẩu

        // ✅ Nếu user chưa có vai trò, gán mặc định là "USER"
        if (user.getRoles() == null || user.getRoles().isEmpty()) {
            Role defaultRole = roleRepository.findBytenVaiTro("USER")
                    .orElseThrow(() -> new RuntimeException("Vai trò mặc định USER không tồn tại!"));
            user.getRoles().add(defaultRole);
        }

        return userRepository.save(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userRepository.findByTenDangNhap(username);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    @Override
    public User loadUserByTenDangNhap(String tenDangNhap) {
        return userRepository.findByTenDangNhap(tenDangNhap)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng: " + tenDangNhap));
    }
    @Override
    public Optional<User> findById(Integer userId) {
        return userRepository.findById(userId);
    }
    @Override
    public Integer getUserIdByUsername(String username) {
        return userRepository.findByTenDangNhap(username)
                .map(User::getId)
                .orElse(null);
    }
    @Override
    public void updateUserRoles(Integer userId, Integer roleId) {
        // Tìm người dùng theo userId
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User không tồn tại"));

        // Tìm vai trò theo roleId
        Role role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Vai trò không tồn tại"));

        // Cập nhật vai trò cho người dùng
        Set<Role> roles = new HashSet<>();
        roles.add(role); // Thêm vai trò mới cho người dùng
        user.setRoles(roles);

        userRepository.save(user); // Lưu người dùng với vai trò mới
    }

}
