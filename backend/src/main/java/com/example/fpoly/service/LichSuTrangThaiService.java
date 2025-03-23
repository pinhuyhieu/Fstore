package com.example.fpoly.service;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.LichSuTrangThaiDonHang;
import com.example.fpoly.enums.TrangThaiDonHang;

import java.util.List;

public interface LichSuTrangThaiService {
    void ghiLichSu(DonHang donHang, TrangThaiDonHang trangThaiMoi, String ghiChu);
    List<LichSuTrangThaiDonHang> findByDonHangId(Integer donHangId);
}
