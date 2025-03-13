package com.example.fpoly.service;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;

public interface GioHangService {
    GioHang getGioHangByUser(User user);
    void clearCart(User user);
    void save(GioHang gioHang);
}
