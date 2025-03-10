package com.example.fpoly.controller;

import com.example.fpoly.entity.User;
import com.example.fpoly.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    // 🟢 Hiển thị trang đăng nhập
    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error, Model model) {
        if (error != null) {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        }
        return "login"; // Load file login.jsp
    }

    // 🟢 Hiển thị trang đăng ký
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register"; // Load file register.jsp
    }

    // 🟢 Xử lý đăng ký
    @PostMapping("/doRegister")
    public String register(@ModelAttribute User user, Model model) {
        // Kiểm tra nếu username đã tồn tại
        if (userService.findByUsername(user.getTenDangNhap()).isPresent()) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "register";
        }

        // Mã hóa mật khẩu và lưu user
        user.setMatKhau(passwordEncoder.encode(user.getMatKhau()));
        userService.saveUser(user);
        model.addAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
        return "login"; // Chuyển hướng về trang login.jsp
    }

    // 🔴 Xử lý đăng xuất
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Xóa session
        }
        return "redirect:/login?logout=true"; // Chuyển hướng về trang đăng nhập
    }
    @PostMapping("/doLogin")
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {
        Optional<User> userOptional = userService.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (passwordEncoder.matches(password, user.getMatKhau())) {
                session.setAttribute("user", user); // ✅ Lưu user vào session
                System.out.println("DEBUG: User đã được lưu vào session -> " + user.getTenDangNhap());
                return "redirect:/sanpham/list"; // Chuyển hướng đến trang sản phẩm
            }
        }
        model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        return "login";
    }


}
