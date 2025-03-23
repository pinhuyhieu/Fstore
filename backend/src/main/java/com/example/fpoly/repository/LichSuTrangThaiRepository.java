package com.example.fpoly.repository;

import com.example.fpoly.entity.LichSuTrangThaiDonHang;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LichSuTrangThaiRepository extends JpaRepository<LichSuTrangThaiDonHang, Integer> {
    List<LichSuTrangThaiDonHang> findByDonHangIdOrderByThoiGianDesc(Integer donHangId);
}
