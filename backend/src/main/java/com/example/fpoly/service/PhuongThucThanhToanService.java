package com.example.fpoly.service;

import com.example.fpoly.entity.PhuongThucThanhToan;

import java.util.List;
import java.util.Optional;

public interface PhuongThucThanhToanService {
    List<PhuongThucThanhToan> getAllPaymentMethods();
    Optional<PhuongThucThanhToan> findById(Integer id);
}
