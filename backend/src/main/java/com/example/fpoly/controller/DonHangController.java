package com.example.fpoly.controller;

import com.example.fpoly.config.VNPayConfig;
import com.example.fpoly.entity.*;

import com.example.fpoly.enums.PhuongThucCode;
import com.example.fpoly.enums.TrangThaiDonHang;
import com.example.fpoly.enums.TrangThaiThanhToan;
import com.example.fpoly.service.*;
import com.example.fpoly.util.TrangThaiValidator;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
    @Autowired
    private SanPhamCTService sanPhamCTService;
    @Autowired
    private DiaChiNguoiDungService diaChiNguoiDungService;
    @Autowired
    private MaGiamGiaService maGiamGiaService;


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
                          HttpSession session,
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

        chiTietList.forEach(ct -> ct.setDonHang(donHang));
        donHang.setChiTietDonHangList(chiTietList);

        // 💰 Tính tổng tiền hàng
        double tongTien = chiTietList.stream()
                .mapToDouble(ct -> ct.getGiaBan().doubleValue() * ct.getSoLuong())
                .sum();
        // 🔻 Tính số tiền giảm nếu có mã
        Float soTienGiam = 0f;

        MaGiamGia maGiamGia = donHang.getMaGiamGia();
        System.out.println("🔍 DonHang gửi lên có maGiamGia: " + donHang.getMaGiamGia());
        System.out.println("🔍 maGiamGia ID: " + (donHang.getMaGiamGia() != null ? donHang.getMaGiamGia().getId() : "null"));
        if (maGiamGia != null) {
            // Truy vấn lại từ DB để đảm bảo thông tin cập nhật
            maGiamGia = maGiamGiaService.findById(maGiamGia.getId()).orElse(null);


            if (maGiamGia != null) {
                boolean hopLe = (Boolean.TRUE.equals(maGiamGia.getKichHoat())) &&
                        (maGiamGia.getNgayBatDau().isBefore(LocalDate.now())) &&
                        (maGiamGia.getNgayKetThuc().isAfter(LocalDate.now())) &&
                        (maGiamGia.getSoLuong() == null || maGiamGia.getSoLuong() > 0) &&
                        (maGiamGia.getGiaTriToiThieu() == null || tongTien >= maGiamGia.getGiaTriToiThieu());

                if (hopLe) {
                    if (maGiamGia.getSoTienGiam() != null) {
                        soTienGiam = maGiamGia.getSoTienGiam();
                    } else if (maGiamGia.getPhanTramGiam() != null) {
                        soTienGiam = (float) (tongTien * maGiamGia.getPhanTramGiam() / 100.0);
                    }
                }
            }
        }

// 📝 Gán vào đơn hàng
        donHang.setSoTienGiam(soTienGiam);


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

        // 📝 Gán thông tin đơn hàng
        donHang.setUser(user);
        donHang.setPhuongThucThanhToan(phuongThucThanhToan);
        donHang.setTrangThai(TrangThaiDonHang.CHO_XAC_NHAN);
        donHang.setPhiShip(phiShip);
        donHang.setSoTienGiam(soTienGiam); // ⚠️ GỌI LẠI ở đây — để đảm bảo chắc chắn


        // 💾 Lưu đơn hàng và chi tiết
        DonHang newOrder = donHangService.tienHanhDatHang(user, donHang, session);
        lichSuTrangThaiService.ghiLichSu(newOrder, TrangThaiDonHang.CHO_XAC_NHAN, "Khởi tạo đơn hàng");

        // 💳 Tạo thanh toán
        ThanhToan thanhToan = new ThanhToan();
        thanhToan.setDonHang(newOrder);
        thanhToan.setPhuongThucThanhToan(phuongThucThanhToan);
        thanhToan.setSoTien(newOrder.getTongTien());
        thanhToan.setTrangThaiThanhToan(TrangThaiThanhToan.CHUA_THANH_TOAN);
        System.out.println("🎯 Đã set mã giảm giá: " + donHang.getMaGiamGia());
        System.out.println("🎯 ID mã giảm giá: " +
                (donHang.getMaGiamGia() != null ? donHang.getMaGiamGia().getId() : "null"));
        thanhToanService.save(thanhToan);

        // 🌐 Nếu chọn VNPay thì chuyển hướng
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
        System.out.println("🧾 Tổng tiền hàng: " + tongTien);
        System.out.println("🎁 Giảm giá: " + soTienGiam);
        System.out.println("🚚 Phí ship: " + phiShip);
        System.out.println("💵 DonHang.soTienGiam = " + donHang.getSoTienGiam());




        // ✅ Xoá mã giảm giá khỏi session sau khi đặt hàng
        session.removeAttribute("maGiamGiaNguoiDung");
        session.removeAttribute("soTienGiam");

        // 📧 Gửi thông báo
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
    public String chiTietDonHang(@PathVariable Integer id, Model model, HttpServletRequest request) {
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
        model.addAttribute("backUrl", request.isUserInRole("ADMIN") ? "/api/donhang/admin/list" : "/api/donhang/danh-sach");

        return "chi-tiet-don-hang"; // Trả về trang JSP
    }

    @GetMapping("/admin/list")
    public String listOrders(Model model,
                             @RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "") String keyword,
                             @RequestParam(required = false) String trangThai,
                             @RequestParam(required = false) String tuNgay,
                             @RequestParam(required = false) String denNgay,
                             @RequestParam(required = false) Double minGia,
                             @RequestParam(required = false) Double maxGia,
                             @RequestParam(required = false) String trangThaiThanhToan
    ) {

        List<DonHang> donHangs = donHangService.getAllOrders();

        // 🔍 Tìm kiếm theo keyword
        if (!keyword.isEmpty()) {
            donHangs = donHangs.stream()
                    .filter(dh ->
                            String.valueOf(dh.getId()).contains(keyword)
                                    || (dh.getUser() != null && dh.getUser().getHoTen() != null &&
                                    dh.getUser().getHoTen().toLowerCase().contains(keyword.toLowerCase()))
                                    || (dh.getSoDienThoaiNguoiNhan() != null && dh.getSoDienThoaiNguoiNhan().contains(keyword))
                    ).toList();
        }

        // 🔎 Lọc theo trạng thái
        if (trangThai != null && !trangThai.isEmpty()) {
            donHangs = donHangs.stream()
                    .filter(dh -> dh.getTrangThai().name().equalsIgnoreCase(trangThai))
                    .toList();
        }

        // 📅 Lọc theo ngày tạo
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (tuNgay != null && !tuNgay.trim().isEmpty()) {
            LocalDateTime fromDate = LocalDate.parse(tuNgay.trim(), formatter).atStartOfDay();
            donHangs = donHangs.stream()
                    .filter(dh -> dh.getNgayDatHang().isAfter(fromDate) || dh.getNgayDatHang().isEqual(fromDate))
                    .toList();
        }

        if (denNgay != null && !denNgay.trim().isEmpty()) {
            LocalDateTime toDate = LocalDate.parse(denNgay.trim(), formatter).atTime(23, 59, 59);
            donHangs = donHangs.stream()
                    .filter(dh -> dh.getNgayDatHang().isBefore(toDate) || dh.getNgayDatHang().isEqual(toDate))
                    .toList();
        }


        // 💰 Lọc theo khoảng giá
        if (minGia != null) {
            donHangs = donHangs.stream()
                    .filter(dh -> dh.getTongTien() >= minGia)
                    .toList();
        }

        if (maxGia != null) {
            donHangs = donHangs.stream()
                    .filter(dh -> dh.getTongTien() <= maxGia)
                    .toList();
        }
        if (trangThaiThanhToan != null && !trangThaiThanhToan.isEmpty()) {
            donHangs = donHangs.stream()
                    .filter(dh -> {
                        if (dh.getThanhToan() == null) return false;
                        return dh.getThanhToan().getTrangThaiThanhToan().name().equalsIgnoreCase(trangThaiThanhToan);
                    }).toList();
        }


        // 📄 Phân trang
        int pageSize = 10;
        int totalItems = donHangs.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalItems);
        List<DonHang> paginated = donHangs.subList(fromIndex, toIndex);

        // Gán thanh toán
        for (DonHang dh : paginated) {
            thanhToanService.findByDonHangId(dh.getId()).ifPresent(dh::setThanhToan);
        }

        // 🧾 Gửi dữ liệu về view
        model.addAttribute("donHangs", paginated);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("trangThai", trangThai);
        model.addAttribute("tuNgay", tuNgay);
        model.addAttribute("denNgay", denNgay);
        model.addAttribute("minGia", minGia);
        model.addAttribute("maxGia", maxGia);
        model.addAttribute("dsTrangThai", TrangThaiDonHang.values());
        model.addAttribute("trangThaiThanhToan", trangThaiThanhToan);


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
            // Nếu trạng thái mới là ĐÃ_HUY → hoàn lại số lượng tồn cho sản phẩm chi tiết
            if (trangThaiMoi == TrangThaiDonHang.DA_HUY) {
                List<ChiTietDonHang> chiTietList = donHang.getChiTietDonHangList();
                for (ChiTietDonHang chiTiet : chiTietList) {
                    SanPhamChiTiet spct = chiTiet.getSanPhamChiTiet();
                    spct.setSoLuongTon(spct.getSoLuongTon() + chiTiet.getSoLuong());
                    // Lưu lại sản phẩm chi tiết (nhớ inject SanPhamCTService vào)
                    sanPhamCTService.save(spct);
                }
            }


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
