package com.example.fpoly.repository;

import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByTenDangNhap(String tenDangNhap);
    Optional<User> findByEmail(String email);
}