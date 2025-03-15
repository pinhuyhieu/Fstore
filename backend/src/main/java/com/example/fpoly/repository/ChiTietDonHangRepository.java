package com.example.fpoly.repository;

import com.example.fpoly.entity.ChiTietDonHang;
import com.example.fpoly.entity.DonHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChiTietDonHangRepository extends JpaRepository<ChiTietDonHang, Integer> {
    List<ChiTietDonHang> findByDonHang(DonHang donHang);
}
