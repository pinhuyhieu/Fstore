package com.example.fpoly.repository;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.entity.SanPham;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham, Integer> {
        @Query("SELECT sp FROM SanPham sp WHERE LOWER(sp.tenSanPham) LIKE LOWER(CONCAT('%', :name, '%'))")
        List<SanPham> searchByName(@Param("name") String name);

        @Query("SELECT DISTINCT sp FROM SanPham sp " +
                "LEFT JOIN FETCH sp.hinhAnhs " +
                "LEFT JOIN FETCH sp.sanPhamChiTiets " +
                "WHERE (:danhMucId IS NULL OR sp.danhMuc.id = :danhMucId)")
        List<SanPham> findAllWithDetails(@Param("danhMucId") Integer danhMucId);

        @Query("SELECT CASE WHEN COUNT(sp) > 0 THEN true ELSE false END FROM SanPham sp WHERE LOWER(sp.tenSanPham) LIKE LOWER(CONCAT('%', :name, '%'))")
        boolean existsByTenSanPham(@Param("name") String tenSanPham);

        Page<SanPham> findByDanhMuc_Id(Integer danhMucId, Pageable pageable);
        Page<SanPham> findByTenSanPhamContainingIgnoreCase(String tenSanPham, Pageable pageable);


}


