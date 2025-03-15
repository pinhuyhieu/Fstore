package com.example.fpoly.service;

import com.example.fpoly.entity.ChiTietDonHang;
import com.example.fpoly.entity.DonHang;

import java.util.List;
import java.util.Optional;

public interface ChiTietDonHangService {
    ChiTietDonHang saveOrderDetail(ChiTietDonHang chiTietDonHang);
    List<ChiTietDonHang> getDetailsByOrder(DonHang donHang);
    Optional<ChiTietDonHang> getDetailById(Integer id);
    void deleteOrderDetail(Integer id);
}
