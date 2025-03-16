package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.*;
import com.example.fpoly.repository.ChiTietDonHangRepository;
import com.example.fpoly.repository.DonHangRepository;
import com.example.fpoly.repository.GioHangRepository;
import com.example.fpoly.service.DonHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DonHangServiceImpl implements DonHangService {

    private final DonHangRepository donHangRepository;
    private final GioHangRepository gioHangRepository;
    private final ChiTietDonHangRepository chiTietDonHangRepository;


    @Override
    public DonHang createOrder(DonHang donHang) {
        return donHangRepository.save(donHang);
    }

    @Override
    public List<DonHang> getOrdersByUser(User user) {
        return donHangRepository.findByUser(user);
    }

    @Override
    public Optional<DonHang> getOrderById(Integer id) {
        return donHangRepository.findById(id);
    }

    @Override
    public void deleteOrder(Integer id) {
        donHangRepository.deleteById(id);
    }


    // 🆕 Tiến hành đặt hàng
    @Override
    public DonHang tienHanhDatHang(User user, DonHang donHang) {
        GioHang gioHang = gioHangRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("❌ Giỏ hàng không tồn tại."));

        // Tính tổng tiền
        double tongTien = gioHang.getGioHangChiTietList().stream()
                .mapToDouble(item -> item.getGiaTaiThoiDiemThem().doubleValue() * item.getSoLuong())
                .sum();

        // Thiết lập thông tin đơn hàng
        donHang.setUser(user);
        donHang.setNgayDatHang(LocalDateTime.now());
        donHang.setTongTien(tongTien);
        donHang.setTrangThai("Mới");

        // Lưu đơn hàng
        DonHang savedOrder = donHangRepository.save(donHang);

        // Lưu chi tiết đơn hàng
        for (GioHangChiTiet item : gioHang.getGioHangChiTietList()) {
            ChiTietDonHang chiTiet = new ChiTietDonHang();
            chiTiet.setDonHang(savedOrder);
            chiTiet.setSanPhamChiTiet(item.getSanPhamChiTiet());
            chiTiet.setSoLuong(item.getSoLuong());
            chiTiet.setGiaBan(item.getGiaTaiThoiDiemThem());
            chiTietDonHangRepository.save(chiTiet);
        }

        // Xóa giỏ hàng sau khi đặt hàng thành công
        gioHangRepository.deleteById(gioHang.getId());

        return savedOrder;
    }

}
