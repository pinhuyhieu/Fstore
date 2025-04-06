package com.example.fpoly.service;

import com.example.fpoly.entity.SanPham;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface SanPhamService {
    List<SanPham> getAll();
    Page<SanPham> getAll(Pageable pageable);
    List<SanPham> searchByName(String name);
    SanPham getById(Integer id);
    SanPham save(SanPham sanPham);
    SanPham update(Integer id, SanPham sanPham);
    void delete(Integer id);

    List<SanPham> layDanhSachSanPham(Integer danhMucId);
    Page<SanPham> convertToPage(List<SanPham> sanPhams, Pageable pageable); // Thêm convertToPage
    // VALIDATE
    boolean existsByTenSanPham(String tenSanPham);
}
