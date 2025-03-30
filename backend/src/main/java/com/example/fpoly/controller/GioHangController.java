package com.example.fpoly.controller;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.GioHangChiTiet;
import com.example.fpoly.entity.PhuongThucThanhToan;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.GioHangChiTietService;
import com.example.fpoly.service.GioHangService;
import com.example.fpoly.service.PhuongThucThanhToanService;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class GioHangController {
    private final GioHangService gioHangService;
    private final UserService userService;
    private final GioHangChiTietService gioHangChiTietService;
    private final PhuongThucThanhToanService phuongThucThanhToanService;

    // 🛒 Lấy giỏ hàng theo user

    @GetMapping
    public String showCart(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        // ✅ Kiểm tra chưa đăng nhập
        if (userDetails == null) {
            return "redirect:/login?requireLogin=true";
        }

        // ✅ Tìm user trong hệ thống
        Optional<User> userOpt = userService.findByUsername(userDetails.getUsername());
        if (userOpt.isEmpty()) {
            return "redirect:/login?error=userNotFound";
        }

        User user = userOpt.get();

        // ✅ Lấy giỏ hàng
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        if (gioHang == null || gioHang.getGioHangChiTietList().isEmpty()) {
            model.addAttribute("gioHang", new GioHang()); // Giỏ rỗng
        } else {
            model.addAttribute("gioHang", gioHang);
        }
        double tongTien = gioHang.getGioHangChiTietList().stream()
                .mapToDouble(ct -> ct.getGiaTaiThoiDiemThem().doubleValue() * ct.getSoLuong())
                .sum();
        int phiShip = 30000; // hoặc dùng ghnService.tinhTienShipTheoSoLuong(...)
        model.addAttribute("phiShip", phiShip);

        double tongThanhToan = tongTien + phiShip;
        model.addAttribute("tongThanhToan", tongThanhToan);

        model.addAttribute("tongTien", tongTien);
        List<PhuongThucThanhToan> list = phuongThucThanhToanService.getAllPaymentMethods();
        model.addAttribute("dsPhuongThuc", list);

        return "cart"; // Trả về JSP hiển thị giỏ hàng
    }



    // 🗑 Xóa toàn bộ giỏ hàng
    @DeleteMapping("/clear")
    public ResponseEntity<String> clearCart(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        gioHangService.clearCart(user);
        return ResponseEntity.ok("✅ Đã xóa toàn bộ giỏ hàng.");
    }
    @GetMapping("/user")
    public ResponseEntity<List<GioHangChiTiet>> getUser(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        GioHang gioHang = gioHangService.getGioHangByUser(user);
        List<GioHangChiTiet> chiTietGioHang = gioHangChiTietService.getCartDetails(gioHang);

        return ResponseEntity.ok(chiTietGioHang);
    }
}
