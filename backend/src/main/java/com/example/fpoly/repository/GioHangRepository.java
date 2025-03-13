package com.example.fpoly.repository;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface GioHangRepository extends JpaRepository<GioHang, Integer> {
    Optional<GioHang> findByUser(User user);
    void deleteByUser(User user);
}
