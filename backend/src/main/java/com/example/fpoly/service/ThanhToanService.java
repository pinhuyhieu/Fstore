package com.example.fpoly.service;

import com.example.fpoly.entity.ThanhToan;

import java.util.Optional;

public interface ThanhToanService {
    ThanhToan save(ThanhToan thanhToan);
    Optional<ThanhToan> findByMaGiaoDich(String maGiaoDich);
    Optional<ThanhToan> findByDonHangId(Integer donHangId);

}
