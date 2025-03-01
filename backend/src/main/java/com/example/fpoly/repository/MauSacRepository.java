package com.example.fpoly.repository;

import com.example.fpoly.entity.MauSac;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MauSacRepository extends JpaRepository<MauSac,Integer> {
    @Query("SELECT DISTINCT ct.mauSac FROM SanPhamChiTiet ct WHERE ct.sanPham.id = :sanPhamId")
    List<MauSac> findAvailableColorsBySanPhamId(@Param("sanPhamId") Integer sanPhamId);
}
