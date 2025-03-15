package com.example.fpoly.service;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.GioHangChiTiet;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.entity.User;

import java.util.List;
import java.util.Optional;

public interface GioHangChiTietService {
    List<GioHangChiTiet> getCartDetails(GioHang gioHang);
    void addToCart(User user, SanPhamChiTiet sanPhamChiTiet, int soLuong);
    void updateQuantity(Integer gioHangChiTietId, int soLuong);
    void removeById(Integer gioHangChiTietId);
    Optional<GioHangChiTiet> findById(Integer id);
}
