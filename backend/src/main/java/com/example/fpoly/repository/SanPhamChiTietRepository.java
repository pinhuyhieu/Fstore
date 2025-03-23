package com.example.fpoly.repository;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet,Integer> {
    List<SanPhamChiTiet> findBySanPham(SanPham sanPham);
    Optional<SanPhamChiTiet> findBySanPhamAndMauSacAndSize(SanPham sanPham, MauSac mauSac, Size size);
    @Query("SELECT ct FROM SanPhamChiTiet ct WHERE ct.mauSac.id = :mauSacId AND ct.size.id = :sizeId AND ct.sanPham.id = :sanPhamId")
    Optional<SanPhamChiTiet> findByMauSacAndSizeAndSanPham(
            @Param("mauSacId") Integer mauSacId,
            @Param("sizeId") Integer sizeId,
            @Param("sanPhamId") Integer sanPhamId
    );
    boolean existsBySanPhamIdAndSizeIdAndMauSacId(Integer sanPhamId, Integer sizeId, Integer mauSacId);

}
