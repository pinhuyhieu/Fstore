package com.example.fpoly.repository;

import com.example.fpoly.entity.ThanhToan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ThanhToanRepository extends JpaRepository<ThanhToan, Integer> {
    Optional<ThanhToan> findByMaGiaoDich(String maGiaoDich);
    Optional<ThanhToan> findByDonHang_Id(Integer donHangId);

}
