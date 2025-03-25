package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.*;
import com.example.fpoly.enums.TrangThaiDonHang;
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
        return donHangRepository.findByUserOrderByNgayDatHangDesc(user);
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

        // 👉 Nếu bạn đã tính tổng tiền ở Controller thì đoạn này có thể bỏ:
        double tongTien = donHang.getChiTietDonHangList().stream()
                .mapToDouble(item -> item.getGiaBan().doubleValue() * item.getSoLuong())
                .sum();
        donHang.setTongTien(tongTien); // Optional

        // Thiết lập thông tin đơn hàng
        donHang.setUser(user);
        donHang.setNgayDatHang(LocalDateTime.now());
        donHang.setTrangThai(TrangThaiDonHang.CHO_XAC_NHAN);

        // 🔗 Gán lại đơn hàng cho từng chi tiết để đảm bảo liên kết hai chiều
        if (donHang.getChiTietDonHangList() != null) {
            for (ChiTietDonHang ct : donHang.getChiTietDonHangList()) {
                ct.setDonHang(donHang);
            }
        }

        // 💾 Lưu đơn hàng → sẽ cascade luôn chi tiết đơn hàng
        DonHang savedOrder = donHangRepository.save(donHang);

        // ✅ Xoá giỏ hàng
        gioHangRepository.deleteById(gioHang.getId());

        return savedOrder;
    }

    @Override
    public List<DonHang> getAllOrders() {
        return donHangRepository.findAllByOrderByNgayDatHangDesc();
    }
    @Override
    public DonHang updateOrder(DonHang donHang) {
        return donHangRepository.save(donHang);
    }


}
