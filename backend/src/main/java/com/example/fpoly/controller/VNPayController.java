package com.example.fpoly.controller;

import com.example.fpoly.config.VNPayConfig;
import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.ThanhToan;
import com.example.fpoly.enums.TrangThaiDonHang;
import com.example.fpoly.enums.TrangThaiThanhToan;
import com.example.fpoly.service.DonHangService;
import com.example.fpoly.service.ThanhToanService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/api/payment")
@RequiredArgsConstructor
public class VNPayController {

    private final VNPayConfig vnPayConfig;
    private final DonHangService donHangService;
    private final ThanhToanService thanhToanService;

    @RequestMapping(value = "/vnpay-return", method = {RequestMethod.GET, RequestMethod.POST})
    public String handleVNPayReturn(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        System.out.println("🟢 [VNPay] Callback received!");



        Map<String, String> vnpParams = new HashMap<>();
        for (Enumeration<String> en = request.getParameterNames(); en.hasMoreElements(); ) {
            String param = en.nextElement();
            vnpParams.put(param, request.getParameter(param));
        }

        String responseCode = vnpParams.get("vnp_ResponseCode");
        String orderId = vnpParams.get("vnp_TxnRef");
        String transactionNo = vnpParams.get("vnp_TransactionNo");

        boolean isValid = vnPayConfig.isValidSignature(vnpParams);

        if ("00".equals(responseCode) ) {
            System.out.println("📥 VNPay Callback received");
            System.out.println("🧾 Order ID: " + orderId);
            System.out.println("✅ Response Code: " + responseCode);
            System.out.println("🔐 Signature Valid: " + isValid);

            DonHang donHang = donHangService.getOrderById(Integer.parseInt(orderId))
                    .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy đơn hàng #" + orderId));

            ThanhToan thanhToan = thanhToanService.findByDonHangId(donHang.getId())
                    .orElse(null);

            if (thanhToan == null) {
                thanhToan = new ThanhToan();
                thanhToan.setDonHang(donHang);
                thanhToan.setPhuongThucThanhToan(donHang.getPhuongThucThanhToan());
                thanhToan.setSoTien(donHang.getTongTien());
            }

            thanhToan.setTrangThaiThanhToan(TrangThaiThanhToan.DA_THANH_TOAN);
            thanhToan.setNgayThanhToan(LocalDateTime.now());
            thanhToan.setMaGiaoDich(transactionNo);
            thanhToanService.save(thanhToan);
            System.out.println("🔍 Before Save: " + thanhToan.getNgayThanhToan() + " | " + thanhToan.getMaGiaoDich());


            // Cập nhật lại trạng thái đơn hàng
            donHang.setTrangThai(TrangThaiDonHang.CHO_XAC_NHAN);
            donHangService.updateOrder(donHang);


            redirectAttributes.addFlashAttribute("successMessage", "✅ Thanh toán VNPay thành công!");
        } else {
            redirectAttributes.addFlashAttribute("error", "❌ Thanh toán thất bại hoặc bị hủy.");
        }

        return "redirect:/api/donhang/chi-tiet/" + orderId;
    }
}
