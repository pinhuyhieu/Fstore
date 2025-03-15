package com.example.fpoly.controller;

import com.example.fpoly.entity.ChiTietDonHang;
import com.example.fpoly.entity.DonHang;
import com.example.fpoly.service.ChiTietDonHangService;
import com.example.fpoly.service.DonHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/chitietdonhang")
@RequiredArgsConstructor
public class ChiTietDonHangController {

    private final ChiTietDonHangService chiTietDonHangService;
    private final DonHangService donHangService;

    // 🔹 Lấy danh sách chi tiết đơn hàng theo đơn hàng ID
    @GetMapping("/donhang/{donHangId}")
    public ResponseEntity<List<ChiTietDonHang>> getDetailsByOrder(@PathVariable Integer donHangId) {
        Optional<DonHang> donHang = donHangService.getOrderById(donHangId);
        if (donHang.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        List<ChiTietDonHang> details = chiTietDonHangService.getDetailsByOrder(donHang.get());
        return ResponseEntity.ok(details);
    }

    // ➕ Thêm chi tiết đơn hàng mới
    @PostMapping("/add")
    public ResponseEntity<ChiTietDonHang> addOrderDetail(@RequestBody ChiTietDonHang chiTietDonHang) {
        ChiTietDonHang savedDetail = chiTietDonHangService.saveOrderDetail(chiTietDonHang);
        return ResponseEntity.ok(savedDetail);
    }

    // 🔍 Lấy thông tin chi tiết đơn hàng theo ID
    @GetMapping("/{id}")
    public ResponseEntity<ChiTietDonHang> getDetailById(@PathVariable Integer id) {
        Optional<ChiTietDonHang> detail = chiTietDonHangService.getDetailById(id);
        return detail.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 🗑 Xóa chi tiết đơn hàng
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOrderDetail(@PathVariable Integer id) {
        chiTietDonHangService.deleteOrderDetail(id);
        return ResponseEntity.ok("✅ Chi tiết đơn hàng đã được xóa.");
    }
}
