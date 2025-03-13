package com.example.fpoly.controller;


import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.GioHangService;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartViewController {
    private final GioHangService gioHangService;
    private final UserService userService;
    @GetMapping
    public String viewCart(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        // 🟢 Lấy username từ UserDetails
        String username = userDetails.getUsername();

        // 🔹 Tìm User từ database
        User user = userService.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy user"));

        // 🛒 Lấy giỏ hàng của user
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        model.addAttribute("gioHang", gioHang);

        return "cart"; // Trả về trang JSP cart.jsp
    }


}

