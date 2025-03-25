package com.example.fpoly.controller;

import com.example.fpoly.config.VNPayConfig;
import com.example.fpoly.entity.*;

import com.example.fpoly.enums.PhuongThucCode;
import com.example.fpoly.enums.TrangThaiDonHang;
import com.example.fpoly.enums.TrangThaiThanhToan;
import com.example.fpoly.service.*;
import com.example.fpoly.util.TrangThaiValidator;
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
    private final GioHangService gioHangService;
    private final GioHangChiTietService gioHangChiTietService;
    @Autowired
    private LichSuTrangThaiService lichSuTrangThaiService;
    @Autowired
    private VNPayConfig vnPayConfig;

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
    @Autowired
    private ThanhToanService thanhToanService;
    // ➕ Tạo đơn hàng mới
    @PostMapping("/dat-hang")
    public String datHang(@AuthenticationPrincipal UserDetails userDetails,
                          @RequestParam Integer phuongThucThanhToanId,
                          @ModelAttribute DonHang donHang,
                          RedirectAttributes redirectAttributes) {

        // 🔐 Lấy thông tin user
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy user"));

        // 💳 Lấy phương thức thanh toán
        PhuongThucThanhToan phuongThucThanhToan = phuongThucThanhToanService.findById(phuongThucThanhToanId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phương thức thanh toán"));

        // 🛒 Lấy giỏ hàng của user
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        List<GioHangChiTiet> gioHangChiTiets = gioHangChiTietService.getCartDetails(gioHang);

        if (gioHangChiTiets == null || gioHangChiTiets.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "❌ Giỏ hàng của bạn đang trống!");
            return "redirect:/sanpham/list";
        }

        // 🔁 Map sang chi tiết đơn hàng
        List<ChiTietDonHang> chiTietList = gioHangChiTiets.stream().map(item -> {
            ChiTietDonHang ct = new ChiTietDonHang();
            ct.setSanPhamChiTiet(item.getSanPhamChiTiet());
            ct.setSoLuong(item.getSoLuong());
            ct.setGiaBan(item.getGiaTaiThoiDiemThem());
            return ct;
        }).toList();

        // Gán đơn hàng cho từng chi tiết (liên kết 2 chiều)
        chiTietList.forEach(ct -> ct.setDonHang(donHang));
        donHang.setChiTietDonHangList(chiTietList);

        // 💰 Tính tổng tiền
        double tongTien = chiTietList.stream()
                .mapToDouble(ct -> ct.getGiaBan().doubleValue() * ct.getSoLuong())
                .sum();

        // 🚚 Tính phí ship
        int tongSoLuong = chiTietList.stream().mapToInt(ChiTietDonHang::getSoLuong).sum();
        int toDistrictId;
        try {
            toDistrictId = Integer.parseInt(donHang.getQuanHuyen());
        } catch (NumberFormatException e) {
            redirectAttributes.addFlashAttribute("error", "❌ Quận/Huyện không hợp lệ!");
            return "redirect:/sanpham/list";
        }

        int phiShip = ghnService.tinhTienShipTheoSoLuong(tongSoLuong, toDistrictId, donHang.getPhuongXa(), (int) tongTien);

        // 📝 Gán thêm thông tin cho đơn hàng
        donHang.setUser(user);
        donHang.setPhuongThucThanhToan(phuongThucThanhToan);
        donHang.setTrangThai(TrangThaiDonHang.CHO_XAC_NHAN);
        donHang.setTongTien(tongTien);
        donHang.setPhiShip(phiShip);

        // 💾 Lưu đơn hàng + chi tiết
        DonHang newOrder = donHangService.tienHanhDatHang(user, donHang);
        lichSuTrangThaiService.ghiLichSu(newOrder, TrangThaiDonHang.CHO_XAC_NHAN, "Khởi tạo đơn hàng");

        // 💳 Tạo thanh toán
        ThanhToan thanhToan = new ThanhToan();
        thanhToan.setDonHang(newOrder);
        thanhToan.setPhuongThucThanhToan(phuongThucThanhToan);
        thanhToan.setSoTien(newOrder.getTongTien());
        thanhToan.setTrangThaiThanhToan(TrangThaiThanhToan.CHUA_THANH_TOAN);
        thanhToanService.save(thanhToan);

        // 🌐 Thanh toán VNPAY
        if (phuongThucThanhToan.getPhuongThucCode() == PhuongThucCode.VNPAY) {
            try {
                String url = vnPayConfig.createPaymentUrl(
                        (long) (newOrder.getTongTien() * 100),
                        "Thanh toán đơn hàng #" + newOrder.getId(),
                        newOrder.getId().toString()
                );
                return "redirect:" + url;
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "❌ Lỗi tạo link thanh toán VNPay: " + e.getMessage());
                return "redirect:/sanpham/list";
            }
        }

        // 📧 Gửi email + thông báo
        emailService.sendOrderConfirmationEmail(user.getEmail(), newOrder.getId().toString());
        redirectAttributes.addFlashAttribute("successMessage", "✅ Đặt hàng thành công!");
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
    public String danhSachDonHang(
            Model model,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "") String keyword
    ) {
        User user = userService.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        List<DonHang> donHangs = donHangService.getOrdersByUser(user);

        // 🔍 Tìm kiếm theo mã đơn hàng
        if (!keyword.isEmpty()) {
            donHangs = donHangs.stream()
                    .filter(dh -> String.valueOf(dh.getId()).contains(keyword))
                    .toList();
        }

        // 🔢 Phân trang
        int pageSize = 10;
        int totalItems = donHangs.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalItems);
        List<DonHang> paginated = donHangs.subList(fromIndex, toIndex);

        // 🔄 Gán thông tin thanh toán
        for (DonHang dh : paginated) {
            thanhToanService.findByDonHangId(dh.getId()).ifPresent(dh::setThanhToan);
        }

        // 📦 Gửi về view
        model.addAttribute("donHangs", paginated);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);

        return "danh-sach-don-hang";
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
        List<LichSuTrangThaiDonHang> lichSu = lichSuTrangThaiService.findByDonHangId(id);
// 🔹 Lấy thông tin thanh toán và gán vào đơn hàng
        thanhToanService.findByDonHangId(donHang.getId()).ifPresent(donHang::setThanhToan);

        // 🟢 Truyền vào view
        model.addAttribute("donHang", donHang);
        model.addAttribute("lichSuTrangThai", lichSu);
        return "chi-tiet-don-hang"; // Trả về trang JSP
    }

    @GetMapping("/admin/list")
    public String listOrders(Model model,
                             @RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "") String keyword) {

        List<DonHang> donHangs = donHangService.getAllOrders();

        if (!keyword.isEmpty()) {
            donHangs = donHangs.stream()
                    .filter(dh ->
                            String.valueOf(dh.getId()).contains(keyword)
                                    || (dh.getUser() != null && dh.getUser().getHoTen() != null &&
                                    dh.getUser().getHoTen().toLowerCase().contains(keyword.toLowerCase()))
                                    || (dh.getSoDienThoaiNguoiNhan() != null && dh.getSoDienThoaiNguoiNhan().contains(keyword))
                    ).toList();
        }

        // Phân trang
        int pageSize = 10;
        int totalItems = donHangs.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalItems);
        List<DonHang> paginated = donHangs.subList(fromIndex, toIndex);

        // Gán thanh toán cho bản ghi đang hiển thị
        for (DonHang dh : paginated) {
            thanhToanService.findByDonHangId(dh.getId()).ifPresent(dh::setThanhToan);
        }

        // Truyền về view
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("donHangs", paginated);
        model.addAttribute("dsTrangThai", TrangThaiDonHang.values());

        return "admin/order-list";
    }

    @PostMapping("/admin/update-status/{id}")
    public String updateOrderStatus(@PathVariable Integer id,
                                    @RequestParam String trangThai,
                                    RedirectAttributes redirectAttributes) {

        DonHang donHang = donHangService.getOrderById(id)
                .orElseThrow(() -> new RuntimeException("❌ Đơn hàng không tồn tại."));

        try {
            TrangThaiDonHang trangThaiMoi = TrangThaiDonHang.valueOf(trangThai);

            // ⚠️ Nếu đơn hàng đã hoàn tất hoặc hủy thì không cho cập nhật
            if (donHang.getTrangThai() == TrangThaiDonHang.HOAN_TAT ||
                    donHang.getTrangThai() == TrangThaiDonHang.DA_HUY) {

                redirectAttributes.addFlashAttribute("successMessage",
                        "⚠️ Đơn hàng đã " + donHang.getTrangThai().getHienThi() + ". Không thể thay đổi trạng thái.");
                return "redirect:/api/donhang/admin/list";
            }

            // ❌ Nếu trạng thái mới không hợp lệ theo quy tắc chuyển đổi
            if (!TrangThaiValidator.isHopLe(donHang.getTrangThai(), trangThaiMoi)) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "❌ Không thể chuyển từ trạng thái " + donHang.getTrangThai().getHienThi()
                                + " sang " + trangThaiMoi.getHienThi());
                return "redirect:/api/donhang/admin/list";
            }

            // ⚠️ Nếu không có thay đổi
            if (donHang.getTrangThai() == trangThaiMoi) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "⚠️ Trạng thái đã là " + trangThaiMoi.getHienThi());
                return "redirect:/api/donhang/admin/list";
            }

            // ✅ Cập nhật trạng thái đơn hàng
            donHang.setTrangThai(trangThaiMoi);
            donHangService.updateOrder(donHang);

            // ✅ Ghi lại lịch sử thay đổi
            lichSuTrangThaiService.ghiLichSu(donHang, trangThaiMoi, "Admin cập nhật trạng thái");

            // ✅ Gửi email cho người dùng
            emailService.sendOrderStatusUpdateEmail(
                    donHang.getUser().getEmail(),
                    id.toString(),
                    trangThaiMoi.getHienThi()
            );

            // ✅ Nếu là COD và đơn hàng hoàn tất → cập nhật trạng thái thanh toán
            if (trangThaiMoi == TrangThaiDonHang.HOAN_TAT &&
                    PhuongThucCode.COD.equals(donHang.getPhuongThucThanhToan().getPhuongThucCode())) {

                ThanhToan thanhToan = thanhToanService.findByDonHangId(donHang.getId())
                        .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy bản ghi thanh toán."));

                if (thanhToan.getTrangThaiThanhToan() == TrangThaiThanhToan.CHUA_THANH_TOAN) {
                    thanhToan.setTrangThaiThanhToan(TrangThaiThanhToan.DA_THANH_TOAN);
                    thanhToan.setNgayThanhToan(LocalDateTime.now());
                    thanhToanService.save(thanhToan);
                }
            }

            redirectAttributes.addFlashAttribute("successMessage", "✅ Cập nhật trạng thái thành công!");

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("successMessage", "❌ Trạng thái không hợp lệ!");
        }

        return "redirect:/api/donhang/admin/list";
    }


}
