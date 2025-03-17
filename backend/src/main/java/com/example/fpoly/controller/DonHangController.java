package com.example.fpoly.controller;

import com.example.fpoly.entity.DonHang;

import com.example.fpoly.entity.PhuongThucThanhToan;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.DonHangService;
import com.example.fpoly.service.PhuongThucThanhToanService;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangService donHangService;
    private final UserService userService;
    private final PhuongThucThanhToanService phuongThucThanhToanService;

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
//    @PostMapping("/create")
//    public ResponseEntity<DonHang> createOrder(@AuthenticationPrincipal UserDetails userDetails, @RequestBody DonHang donHang) {
//        User user = userService.findByUsername(userDetails.getUsername())
//                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));
//
//        donHang.setUser(user);
//        DonHang newOrder = donHangService.createOrder(donHang);
//        return ResponseEntity.ok(newOrder);
//    }

    // ➕ Tạo đơn hàng mới
    @PostMapping("/dat-hang")
    public ResponseEntity<DonHang> tienHanhDatHang(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam Integer phuongThucThanhToanId,
            @ModelAttribute DonHang donHang) {

        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        // Tìm phương thức thanh toán
        PhuongThucThanhToan phuongThucThanhToan = phuongThucThanhToanService.findById(phuongThucThanhToanId)
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy phương thức thanh toán"));

        // Thiết lập thông tin đơn hàng
        donHang.setUser(user);
        donHang.setPhuongThucThanhToan(phuongThucThanhToan);

        DonHang newOrder = donHangService.tienHanhDatHang(user, donHang);
        return ResponseEntity.ok(newOrder);
    }

    @GetMapping("/xac-nhan")
    public String showConfirmation(Model model, @RequestParam Integer orderId) {
        DonHang donHang = donHangService.getOrderById(orderId)
                .orElseThrow(() -> new RuntimeException("❌ Đơn hàng không tồn tại."));
        model.addAttribute("donHang", donHang);
        return "xac-nhan-dat-hang";
    }


    // 🗑 Xóa đơn hàng
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOrder(@PathVariable Integer id) {
        donHangService.deleteOrder(id);
        return ResponseEntity.ok("✅ Đã xóa đơn hàng thành công.");
    }
    @GetMapping("/danh-sach")
    public String danhSachDonHang(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        List<DonHang> donHangs = donHangService.getOrdersByUser(user);
        model.addAttribute("donHangs", donHangs);

        return "danh-sach-don-hang"; // Trả về trang JSP
    }
    @GetMapping("/chi-tiet/{id}")
    public String chiTietDonHang(@PathVariable Integer id, Model model) {
        DonHang donHang = donHangService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("❌ Đơn hàng không tồn tại."));

        model.addAttribute("donHang", donHang);
        return "chi-tiet-don-hang";
    }
    @GetMapping("/admin/list")
    public String listOrders(Model model) {
        List<DonHang> donHangs = donHangService.getAllOrders(); // Lấy tất cả đơn hàng
        model.addAttribute("donHangs", donHangs);
        return "admin/order-list"; // Trả về trang JSP hiển thị danh sách đơn hàng
    }
    @PostMapping("/admin/update-status/{id}")
    public String updateOrderStatus(@PathVariable Integer id,
                                    @RequestParam String trangThai,
                                    RedirectAttributes redirectAttributes) {
        DonHang donHang = donHangService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("Đơn hàng không tồn tại."));
        donHang.setTrangThai(trangThai);
        donHangService.updateOrder(donHang);

        // 🟢 Thêm thông báo vào session
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái thành công!");

        return "redirect:/api/donhang/admin/list"; // Chuyển hướng về danh sách đơn hàng
    }


}
