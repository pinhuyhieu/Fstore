package com.example.fpoly.service;
import com.example.fpoly.entity.User;

import java.util.Optional;

public interface UserService {
    User saveUser(User user);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    User loadUserByTenDangNhap(String tenDangNhap);
    Optional<User> findById(Integer userId);
    Integer getUserIdByUsername(String username);



}
