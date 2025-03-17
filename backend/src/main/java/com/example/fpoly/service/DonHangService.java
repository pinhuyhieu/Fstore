package com.example.fpoly.service;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.User;

import java.util.List;
import java.util.Optional;

public interface DonHangService {
    DonHang createOrder(DonHang donHang);
    List<DonHang> getOrdersByUser(User user);
    Optional<DonHang> getOrderById(Integer id);
    void deleteOrder(Integer id);

    public List<DonHang> getAllOrders();
    public DonHang updateOrder(DonHang donHang) ;

    // 🆕 Tiến hành đặt hàng
    DonHang tienHanhDatHang(User user, DonHang donHang);
}
