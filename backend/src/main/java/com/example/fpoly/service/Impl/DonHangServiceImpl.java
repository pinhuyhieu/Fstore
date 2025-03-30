package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.*;
import com.example.fpoly.enums.TrangThaiDonHang;
import com.example.fpoly.repository.ChiTietDonHangRepository;
import com.example.fpoly.repository.DonHangRepository;
import com.example.fpoly.repository.GioHangRepository;
import com.example.fpoly.service.DonHangService;
import jakarta.servlet.http.HttpSession;
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
    public DonHang tienHanhDatHang(User user, DonHang donHang, HttpSession session) {
        GioHang gioHang = gioHangRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("❌ Giỏ hàng không tồn tại."));

        // Gán thông tin đơn hàng
        donHang.setUser(user);
        donHang.setNgayDatHang(LocalDateTime.now());
        donHang.setTrangThai(TrangThaiDonHang.CHO_XAC_NHAN);

        // Gán lại đơn hàng cho từng chi tiết
        if (donHang.getChiTietDonHangList() != null) {
            for (ChiTietDonHang ct : donHang.getChiTietDonHangList()) {
                ct.setDonHang(donHang);
            }
        }

        // 💥 XỬ LÝ MÃ GIẢM GIÁ
        double tongTien = donHang.getChiTietDonHangList().stream()
                .mapToDouble(item -> item.getGiaBan().doubleValue() * item.getSoLuong())
                .sum();

        MaGiamGiaNguoiDung mggNguoiDung = (MaGiamGiaNguoiDung) session.getAttribute("maGiamGiaNguoiDung");
        double soTienGiam = 0;

        if (mggNguoiDung != null) {
            MaGiamGia ma = mggNguoiDung.getMaGiamGia();
            if (ma.getSoTienGiam() != null) {
                soTienGiam = ma.getSoTienGiam();
            } else if (ma.getPhanTramGiam() != null) {
                soTienGiam = tongTien * ma.getPhanTramGiam() / 100;
            }

            if (tongTien >= ma.getGiaTriToiThieu()) {
                tongTien -= soTienGiam;
                if (tongTien < 0) tongTien = 0;
                donHang.setMaGiamGia(ma); // Gán mã vào đơn hàng
            }
        }

        // 💾 Gán tổng tiền sau khi giảm
        donHang.setTongTien(tongTien + donHang.getPhiShip());

        DonHang savedOrder = donHangRepository.save(donHang);

        // ✅ Xóa giỏ hàng
        gioHangRepository.deleteById(gioHang.getId());

        // ✅ Dọn mã khỏi session
        session.removeAttribute("maGiamGiaNguoiDung");
        session.removeAttribute("soTienGiam");

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
