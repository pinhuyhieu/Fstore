package com.example.fpoly.repository;

import com.example.fpoly.entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SizeRepository extends JpaRepository<Size,Integer> {
    @Query("SELECT DISTINCT ct.size FROM SanPhamChiTiet ct WHERE ct.sanPham.id = :sanPhamId")
    List<Size> findAvailableSizesBySanPhamId(@Param("sanPhamId") Integer sanPhamId);
}
