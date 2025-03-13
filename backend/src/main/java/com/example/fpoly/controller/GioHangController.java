package com.example.fpoly.controller;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.GioHangChiTiet;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.GioHangChiTietService;
import com.example.fpoly.service.GioHangService;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class GioHangController {
    private final GioHangService gioHangService;
    private final UserService userService;
    private final GioHangChiTietService gioHangChiTietService;

    // 🛒 Lấy giỏ hàng theo user
    @GetMapping
    public ResponseEntity<GioHang> getCartByUser(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        GioHang gioHang = gioHangService.getGioHangByUser(user);
        return ResponseEntity.ok(gioHang);
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
