package com.example.fpoly.service;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.entity.SanPhamChiTiet;
import java.util.List;

public interface GioHangService {
    List<GioHang> getGioHangByUser(User user);
    void addToCart(User user, SanPhamChiTiet sanPhamChiTiet, int soLuong);
    void removeFromCart(Integer id);
    public void themSanPhamVaoGio(User user, Integer sanPhamChiTietId, int soLuong);
}
