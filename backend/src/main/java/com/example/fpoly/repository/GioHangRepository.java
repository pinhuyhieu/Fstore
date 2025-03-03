package com.example.fpoly.repository;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface GioHangRepository extends JpaRepository<GioHang, Integer> {
    List<GioHang> findByUser(User user); // Đổi từ nguoiDung -> user
    Optional<GioHang> findByUserAndSanPhamChiTiet(User user, SanPhamChiTiet sanPhamChiTiet);
}
