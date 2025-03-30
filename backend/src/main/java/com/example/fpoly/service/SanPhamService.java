package com.example.fpoly.service;
import com.example.fpoly.entity.SanPham;
import java.util.List;

public interface SanPhamService {
    List<SanPham> getAll();
    SanPham getById(Integer id);
    SanPham save(SanPham sanPham);
    SanPham update(Integer id, SanPham sanPham);
    void delete(Integer id);

    // VALIDATE
    boolean existsByTenSanPham(String tenSanPham);
}
