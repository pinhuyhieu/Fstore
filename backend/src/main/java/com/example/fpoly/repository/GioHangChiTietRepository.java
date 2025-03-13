package com.example.fpoly.repository;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.GioHangChiTiet;
import com.example.fpoly.entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, Integer> {
    List<GioHangChiTiet> findByGioHang(GioHang gioHang);
    Optional<GioHangChiTiet> findByGioHangAndSanPhamChiTiet(GioHang gioHang, SanPhamChiTiet sanPhamChiTiet);
}
