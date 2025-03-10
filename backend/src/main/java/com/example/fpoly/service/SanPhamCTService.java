package com.example.fpoly.service;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.entity.Size;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface SanPhamCTService {
    SanPhamChiTiet getById(Integer id);
    SanPhamChiTiet save(SanPhamChiTiet sanPhamChiTiet);
    SanPhamChiTiet update(Integer id, SanPhamChiTiet sanPhamChiTiet);
    void delete(Integer id);
    List<SanPhamChiTiet> findBySanPhamId(Integer sanPhamId);
    Optional<SanPhamChiTiet> findBySanPhamAndMauSacAndSize(SanPham sanPham, MauSac mauSac, Size size);
    public Integer findIdBySanPhamAndMauSacAndSize(Integer sanPhamId, Integer mauSacId, Integer sizeId);
    public Map<String, Object> getSoLuongTonVaGiaTien(Integer mauSacId, Integer sizeId, Integer sanPhamId);
}
