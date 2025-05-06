package com.example.fpoly.controller;

import com.example.fpoly.entity.*;
import com.example.fpoly.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/cart/details")
@RequiredArgsConstructor
public class GioHangChiTietController {
    private final GioHangChiTietService gioHangChiTietService;
    private final GioHangService gioHangService;
    private final SanPhamCTService sanPhamCTService;
    private final UserService userService;

    // 🛒 Hiển thị danh sách sản phẩm trong giỏ hàng trên JSP



    // ➕ Thêm sản phẩm vào giỏ hàng
    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestParam Integer sanPhamChiTietId,
                                                         @RequestParam int soLuong,
                                                         @AuthenticationPrincipal UserDetails userDetails) {
        // Lấy thông tin người dùng
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        // Lấy thông tin sản phẩm chi tiết
        SanPhamChiTiet sanPhamChiTiet = sanPhamCTService.getById(sanPhamChiTietId);
        if (sanPhamChiTiet == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "❌ Không tìm thấy sản phẩm chi tiết!"));
        }

        // Lấy số lượng tồn kho của sản phẩm
        int soLuongTon = sanPhamChiTiet.getSoLuongTon();

        // Kiểm tra số lượng sản phẩm trong giỏ hiện tại
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        Optional<GioHangChiTiet> existingItem = gioHang.getGioHangChiTietList().stream()
                .filter(item -> item.getSanPhamChiTiet().getId().equals(sanPhamChiTietId))
                .findFirst();

        // Nếu sản phẩm đã có trong giỏ, cộng thêm số lượng hiện tại
        if (existingItem.isPresent()) {
            int currentQuantity = existingItem.get().getSoLuong();
            if (currentQuantity + soLuong > soLuongTon) {
                return ResponseEntity.badRequest().body(Map.of("success", false, "message", "❌ Số lượng sản phẩm trong giỏ vượt quá tồn kho!"));
            }
        } else {
            // Nếu sản phẩm chưa có trong giỏ, kiểm tra số lượng yêu cầu có vượt quá tồn kho không
            if (soLuong > soLuongTon) {
                return ResponseEntity.badRequest().body(Map.of("success", false, "message", "❌ Số lượng sản phẩm vượt quá tồn kho!"));
            }
        }

        // Nếu không có vấn đề gì, thêm sản phẩm vào giỏ
        gioHangChiTietService.addToCart(user, sanPhamChiTiet, soLuong);
        return ResponseEntity.ok(Map.of("success", true, "message", "✅ Sản phẩm đã được thêm vào giỏ hàng!"));
    }



    // ✏️ Cập nhật số lượng sản phẩm trong giỏ hàng
    @PutMapping("/update/{gioHangChiTietId}")
    public ResponseEntity<String> updateQuantity(@PathVariable Integer gioHangChiTietId, @RequestParam int soLuong) {
        try {
            // Lấy số lượng tồn kho của sản phẩm
            int soLuongTon = gioHangChiTietService.getSoLuongTon(gioHangChiTietId);

            // Kiểm tra số lượng yêu cầu có vượt quá tồn kho không
            if (soLuong > soLuongTon) {
                // Nếu số lượng yêu cầu vượt quá tồn kho, trả về thông báo lỗi
                return ResponseEntity.badRequest().body("❌ Số lượng tồn kho không đủ. Hiện chỉ còn " + soLuongTon + " sản phẩm.");
            }

            // Nếu số lượng hợp lệ, cập nhật số lượng trong giỏ hàng
            gioHangChiTietService.updateQuantity(gioHangChiTietId, soLuong);

            // Trả về thông báo thành công
            return ResponseEntity.ok("✅ Cập nhật số lượng thành công.");
        } catch (RuntimeException e) {
            // Xử lý lỗi nếu có vấn đề với việc cập nhật
            return ResponseEntity.badRequest().body("❌ " + e.getMessage());
        }
    }



    // 🗑 Xóa sản phẩm khỏi giỏ hàng
    @DeleteMapping("/remove/{gioHangChiTietId}")
    public ResponseEntity<String> removeFromCart(@PathVariable Integer gioHangChiTietId) {
        gioHangChiTietService.removeById(gioHangChiTietId);
        return ResponseEntity.ok("✅ Sản phẩm đã được xóa khỏi giỏ hàng.");
    }
}
