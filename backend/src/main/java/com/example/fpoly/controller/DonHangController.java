package com.example.fpoly.controller;

import com.example.fpoly.entity.DonHang;

import com.example.fpoly.entity.PhuongThucThanhToan;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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
    @Autowired
    private EmailService emailService;
    // ➕ Tạo đơn hàng mới
    @PostMapping("/dat-hang")
    public String tienHanhDatHang(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam Integer phuongThucThanhToanId,
            @ModelAttribute DonHang donHang,
            RedirectAttributes redirectAttributes) {

        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        // Tìm phương thức thanh toán
        PhuongThucThanhToan phuongThucThanhToan = phuongThucThanhToanService.findById(phuongThucThanhToanId)
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy phương thức thanh toán"));

        // Thiết lập thông tin đơn hàng
        donHang.setUser(user);
        donHang.setPhuongThucThanhToan(phuongThucThanhToan);

        DonHang newOrder = donHangService.tienHanhDatHang(user, donHang);
        redirectAttributes.addFlashAttribute("successMessage", "🎉 Đơn hàng của bạn đã được đặt thành công!");
        emailService.sendOrderConfirmationEmail(user.getEmail(), newOrder.getId().toString());

        // Chuyển hướng đến trang xác nhận đơn hàng
        return "redirect:/api/donhang/xac-nhan?id=" + newOrder.getId();
    }

    @GetMapping("/xac-nhan")
    public String showConfirmation(Model model, @RequestParam Integer id) {
        DonHang donHang = donHangService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("❌ Đơn hàng không tồn tại."));
        model.addAttribute("donHang", donHang);
        return "xac-nhan";
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

    @Autowired
    private GHNService ghnService;

    @GetMapping("/chi-tiet/{id}")
    public String chiTietDonHang(@PathVariable Integer id, Model model) {
        // 🔹 Tìm đơn hàng theo ID từ database
        DonHang donHang = donHangService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("❌ Đơn hàng không tồn tại."));

        // 🔹 Lấy tên địa chỉ từ GHN API dựa trên mã đã lưu
        String provinceName = ghnService.getProvinceName(donHang.getTinhThanh());
        String districtName = ghnService.getDistrictName(
                String.valueOf(donHang.getTinhThanh()), // Truyền provinceId
                String.valueOf(donHang.getQuanHuyen())  // Truyền districtId
        );

        String wardName = ghnService.getWardName(
                String.valueOf(donHang.getQuanHuyen()), // Truyền districtId
                String.valueOf(donHang.getPhuongXa())   // Truyền wardCode
        );

        // 🔹 Gán vào đối tượng đơn hàng
        donHang.setTinhThanh(provinceName);
        donHang.setQuanHuyen(districtName);
        donHang.setPhuongXa(wardName);

        // 🔹 Truyền dữ liệu đến JSP
        model.addAttribute("donHang", donHang);
        return "chi-tiet-don-hang"; // Trả về trang JSP
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

        // 🟢 Gửi email thông báo cập nhật trạng thái đơn hàng
        emailService.sendOrderStatusUpdateEmail(donHang.getUser().getEmail(), id.toString(), trangThai);

        return "redirect:/api/donhang/admin/list"; // Chuyển hướng về danh sách đơn hàng
    }



}
