package com.example.fpoly.controller;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.DonHangService;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangService donHangService;
    private final UserService userService;

    // 🔹 Lấy danh sách đơn hàng của user
    @GetMapping
    public ResponseEntity<List<DonHang>> getOrdersByUser(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        List<DonHang> donHangs = donHangService.getOrdersByUser(user);
        return ResponseEntity.ok(donHangs);
    }

    // 🔹 Lấy chi tiết đơn hàng theo ID
    @GetMapping("/{id}")
    public ResponseEntity<DonHang> getOrderById(@PathVariable Integer id) {
        Optional<DonHang> donHang = donHangService.getOrderById(id);
        return donHang.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // ➕ Tạo đơn hàng mới
    @PostMapping("/create")
    public ResponseEntity<DonHang> createOrder(@AuthenticationPrincipal UserDetails userDetails, @RequestBody DonHang donHang) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        donHang.setUser(user);
        DonHang newOrder = donHangService.createOrder(donHang);
        return ResponseEntity.ok(newOrder);
    }

    // 🗑 Xóa đơn hàng
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOrder(@PathVariable Integer id) {
        donHangService.deleteOrder(id);
        return ResponseEntity.ok("✅ Đã xóa đơn hàng thành công.");
    }
}
