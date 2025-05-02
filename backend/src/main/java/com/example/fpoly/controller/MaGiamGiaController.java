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
import java.util.HashMap;
import java.util.List;
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
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttributes) {

        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        Optional<MaGiamGiaNguoiDung> opt = maGiamGiaService.findForUser(user, ma.trim());

        if (opt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã không áp dụng cho bạn hoặc không tồn tại.");
            return ResponseEntity.badRequest().body("❌ Mã không áp dụng cho bạn hoặc không tồn tại.");
        }

        MaGiamGia giamGia = opt.get().getMaGiamGia();

        // Các điều kiện kiểm tra khác...
        if (giamGia.getSoLuong() == null || giamGia.getSoLuong() <= 0) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã giảm giá đã hết lượt sử dụng.");
            return ResponseEntity.badRequest().body("❌ Mã giảm giá đã hết lượt sử dụng.");
        }

        if (!giamGia.getKichHoat()) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã chưa được kích hoạt.");
            return ResponseEntity.badRequest().body("❌ Mã chưa được kích hoạt.");
        }

        if (giamGia.getNgayBatDau().isAfter(LocalDate.now())) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã chưa có hiệu lực.");
            return ResponseEntity.badRequest().body("❌ Mã chưa có hiệu lực.");
        }

        if (giamGia.getNgayKetThuc().isBefore(LocalDate.now())) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã đã hết hạn.");
            return ResponseEntity.badRequest().body("❌ Mã đã hết hạn.");
        }

        if (tongTien < giamGia.getGiaTriToiThieu()) {
            redirectAttributes.addFlashAttribute("error", "❌ Đơn hàng chưa đủ giá trị tối thiểu " +
                    String.format("%,.0f", giamGia.getGiaTriToiThieu()) + " ₫ để áp dụng mã này.");
            return ResponseEntity.badRequest().body("❌ Đơn hàng chưa đủ giá trị tối thiểu.");
        }

        // ✅ Tính số tiền giảm
        double soTienGiam = giamGia.getSoTienGiam() != null ? giamGia.getSoTienGiam() : tongTien * giamGia.getPhanTramGiam() / 100;

        // Gửi thông báo thành công
        redirectAttributes.addFlashAttribute("successMessage", "✅ Mã đã được áp dụng!");

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
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy user"));

        Optional<MaGiamGiaNguoiDung> opt = maGiamGiaService.findForUser(user, ma.trim());

        if (opt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "❌ Mã không áp dụng cho bạn hoặc không tồn tại");
            return ResponseEntity.badRequest().body("❌ Mã không áp dụng cho bạn hoặc không tồn tại");
        }

        MaGiamGia giamGia = opt.get().getMaGiamGia();

        // Lưu mã vào session
        session.setAttribute("maGiamGiaNguoiDung", opt.get());
        session.setAttribute("soTienGiam", giamGia.getSoTienGiam() != null ? giamGia.getSoTienGiam() : 0);

        // Thêm thông báo thành công vào RedirectAttributes và chuyển hướng
        redirectAttributes.addFlashAttribute("successMessage", "✅ Mã đã được áp dụng!");

        return ResponseEntity.ok(Map.of(
                "message", "✅ Mã đã được áp dụng!",
                "ma", giamGia.getMa()
        ));
    }


    @GetMapping("/list")
    public ResponseEntity<?> getDanhSachMaGiamGiaKhachApDung(
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy user"));

        List<MaGiamGiaNguoiDung> list = maGiamGiaService.findAllForUser(user);

        List<Map<String, Object>> result = list.stream()
                .map(item -> {
                    MaGiamGia mgg = item.getMaGiamGia();
                    Map<String, Object> map = new HashMap<>();
                    map.put("ma", mgg.getMa());
                    map.put("phanTramGiam", mgg.getPhanTramGiam());
                    map.put("soTienGiam", mgg.getSoTienGiam());
                    map.put("ngayKetThuc", mgg.getNgayKetThuc());
                    map.put("soLuongConLai", mgg.getSoLuong());
                    map.put("giaTriToiThieu", mgg.getGiaTriToiThieu());
                    return map;
                })
                .toList();


        return ResponseEntity.ok(result);
    }


}
