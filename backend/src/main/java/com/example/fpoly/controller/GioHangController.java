package com.example.fpoly.controller;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.service.GioHangService;
import com.example.fpoly.service.SanPhamCTService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class GioHangController {
    @Autowired
    private GioHangService gioHangService;

    @Autowired
    private SanPhamCTService sanPhamCTService;

    // 🛒 Hiển thị giỏ hàng
    @GetMapping
    public ModelAndView showCart(HttpSession session) {
        User user = (User) session.getAttribute("user"); // Lấy user từ session
        if (user == null) {
            return new ModelAndView("redirect:/login");
        }

        List<GioHang> gioHangList = gioHangService.getGioHangByUser(user);
        ModelAndView modelAndView = new ModelAndView("cart");
        modelAndView.addObject("gioHangList", gioHangList);
        return modelAndView;
    }

    // 🛒 Thêm sản phẩm vào giỏ hàng
    @PostMapping("/add")
    public ResponseEntity<?> addToCart(
            @RequestParam("sanPhamChiTietId") Integer sanPhamChiTietId,
            @RequestParam("soLuong") int soLuong,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập");
        }

        SanPhamChiTiet sanPhamChiTiet = sanPhamCTService.getById(sanPhamChiTietId);
        if (sanPhamChiTiet == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Sản phẩm không tồn tại");
        }

        gioHangService.addToCart(user, sanPhamChiTiet, soLuong);
        return ResponseEntity.ok("Thêm vào giỏ hàng thành công");
    }

    // ❌ Xóa sản phẩm khỏi giỏ hàng
    @GetMapping("/remove/{id}")
    public String removeFromCart(@PathVariable("id") Integer id) {
        gioHangService.removeFromCart(id);
        return "redirect:/cart";
    }



}