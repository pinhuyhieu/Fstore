package com.example.fpoly.controller;

import com.example.fpoly.entity.MaGiamGia;
import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.MaGiamGiaService;
import com.example.fpoly.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/ma-giam-gia")
@RequiredArgsConstructor
public class MaGiamGiaController {

    private final MaGiamGiaService maGiamGiaService;
    private final UserService userService;

    @GetMapping("/check")
    public ResponseEntity<?> checkMa(
            @RequestParam String ma,
            @RequestParam double tongTien,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        Optional<MaGiamGiaNguoiDung> opt = maGiamGiaService.findForUser(user, ma.trim());

        if (opt.isEmpty()) {
            return ResponseEntity.badRequest().body("❌ Mã không áp dụng cho bạn hoặc không tồn tại.");
        }

        MaGiamGia giamGia = opt.get().getMaGiamGia();

        // ❌ Hết số lượng
        if (giamGia.getSoLuong() == null || giamGia.getSoLuong() <= 0) {
            return ResponseEntity.badRequest().body("❌ Mã giảm giá đã hết lượt sử dụng.");
        }

        // ❌ Không kích hoạt
        if (giamGia.getKichHoat() == null || !giamGia.getKichHoat()) {
            return ResponseEntity.badRequest().body("❌ Mã chưa được kích hoạt.");
        }

        // ❌ Chưa đến ngày
        if (giamGia.getNgayBatDau() != null && giamGia.getNgayBatDau().isAfter(LocalDate.now())) {
            return ResponseEntity.badRequest().body("❌ Mã chưa có hiệu lực.");
        }

        // ❌ Đã hết hạn
        if (giamGia.getNgayKetThuc() != null && giamGia.getNgayKetThuc().isBefore(LocalDate.now())) {
            return ResponseEntity.badRequest().body("❌ Mã đã hết hạn.");
        }

        // ❌ Không đạt giá trị tối thiểu
        if (tongTien < giamGia.getGiaTriToiThieu()) {
            return ResponseEntity.badRequest().body("❌ Đơn hàng chưa đủ giá trị tối thiểu " +
                    "(" + String.format("%,.0f", giamGia.getGiaTriToiThieu()) + " ₫) để áp dụng mã này.");
        }

        // ✅ Tính số tiền giảm
        double soTienGiam = 0;
        if (giamGia.getSoTienGiam() != null) {
            soTienGiam = giamGia.getSoTienGiam();
        } else if (giamGia.getPhanTramGiam() != null) {
            soTienGiam = tongTien * giamGia.getPhanTramGiam() / 100;
        }

        return ResponseEntity.ok(Map.of("soTienGiam", (int) soTienGiam));
    }

    @GetMapping("/cancel")
    public String cancelDiscount(HttpSession session, RedirectAttributes redirectAttributes) {
        session.removeAttribute("maGiamGiaNguoiDung");
        session.removeAttribute("soTienGiam");
        redirectAttributes.addFlashAttribute("successMessage", "❌ Mã giảm giá đã được hủy!");
        return "redirect:/api/cart";
    }
    @PostMapping("/apply")
    public ResponseEntity<?> applyMaGiamGia(@RequestParam String ma,
                                            @AuthenticationPrincipal UserDetails userDetails,
                                            HttpSession session) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy user"));

        Optional<MaGiamGiaNguoiDung> opt = maGiamGiaService.findForUser(user, ma.trim());

        if (opt.isEmpty()) {
            return ResponseEntity.badRequest().body("❌ Mã không áp dụng cho bạn hoặc không tồn tại");
        }

        MaGiamGia giamGia = opt.get().getMaGiamGia();

        // ✅ Kiểm tra trạng thái mã
        if (!giamGia.getKichHoat()) {
            return ResponseEntity.badRequest().body("❌ Mã chưa được kích hoạt.");
        }

        if (giamGia.getNgayBatDau().isAfter(LocalDate.now())) {
            return ResponseEntity.badRequest().body("❌ Mã chưa có hiệu lực.");
        }

        if (giamGia.getNgayKetThuc().isBefore(LocalDate.now())) {
            return ResponseEntity.badRequest().body("❌ Mã đã hết hạn.");
        }

        if (giamGia.getSoLuong() == null || giamGia.getSoLuong() <= 0) {
            return ResponseEntity.badRequest().body("❌ Mã giảm giá đã hết lượt sử dụng.");
        }
        System.out.println("Session ID: " + session.getId());

        // ✅ Lưu mã vào session
        session.setAttribute("maGiamGiaNguoiDung", opt.get());
        System.out.println("✅ SET SESSION: " + session.getId() + " | " + session.getAttribute("maGiamGiaNguoiDung"));

        return ResponseEntity.ok(Map.of(
                "message", "✅ Mã đã được áp dụng!",
                "ma", giamGia.getMa()
        ));
    }


}
