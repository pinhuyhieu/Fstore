package com.example.fpoly.service;

import com.example.fpoly.entity.SanPham;
import com.example.fpoly.entity.SanPhamChiTiet;

import java.util.List;

public interface SanPhamCTService {
    SanPhamChiTiet getById(Integer id);
    SanPhamChiTiet save(SanPhamChiTiet sanPhamChiTiet);
    SanPhamChiTiet update(Integer id, SanPhamChiTiet sanPhamChiTiet);
    void delete(Integer id);
    List<SanPhamChiTiet> findBySanPhamId(Integer sanPhamId);
}
