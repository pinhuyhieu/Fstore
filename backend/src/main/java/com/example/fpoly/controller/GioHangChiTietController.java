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
    @GetMapping
    public String getCartPage(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        // 🔹 Lấy thông tin User từ UserDetails
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        // 🔹 Lấy giỏ hàng của user
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        List<GioHangChiTiet> cartDetails = gioHangChiTietService.getCartDetails(gioHang);

        // 🔹 Tính tổng tiền
        BigDecimal tongTien = cartDetails.stream()
                .map(item -> item.getSanPhamChiTiet().getGia().multiply(BigDecimal.valueOf(item.getSoLuong()))) // ✅ Sửa lỗi
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // 🔹 Truyền dữ liệu sang JSP
        model.addAttribute("gioHangChiTietList", cartDetails);
        model.addAttribute("tongTien", tongTien);

        return "/cart"; // Trả về trang cart.jsp
    }


    // ➕ Thêm sản phẩm vào giỏ hàng
    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestParam Integer sanPhamChiTietId,
                                                         @RequestParam int soLuong,
                                                         @AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        SanPhamChiTiet sanPhamChiTiet = sanPhamCTService.getById(sanPhamChiTietId);
        if (sanPhamChiTiet == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "❌ Không tìm thấy sản phẩm chi tiết!"));
        }

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
                return ResponseEntity.badRequest().body("❌ Số lượng tồn kho không đủ. Hiện chỉ còn " + soLuongTon + " sản phẩm.");
            }

            // Cập nhật số lượng nếu hợp lệ
            gioHangChiTietService.updateQuantity(gioHangChiTietId, soLuong);
            return ResponseEntity.ok("✅ Cập nhật số lượng thành công.");
        } catch (RuntimeException e) {
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
