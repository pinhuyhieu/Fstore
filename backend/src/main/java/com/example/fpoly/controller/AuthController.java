package com.example.fpoly.controller;

import com.example.fpoly.entity.User;
import com.example.fpoly.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            Model model) {
        if (error != null) {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        }
        if (logout != null) {
            model.addAttribute("message", "Đăng xuất thành công!");
        }
        return "login";
    }
    @PostMapping("/doLogin")
    public String login(@RequestParam String username, @RequestParam String password, Model model) {
        Optional<User> userOptional = userService.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            System.out.println("Mật khẩu nhập vào: " + password);
            System.out.println("Mật khẩu đã mã hóa: " + user.getMatKhau());
            System.out.println("Kết quả so sánh: " + passwordEncoder.matches(password, user.getMatKhau()));
        }
        return "redirect:/sanpham/list";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/doRegister")
    public String register(@ModelAttribute User user, Model model) {
        if (userService.findByUsername(user.getTenDangNhap()).isPresent()) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "register";
        }
        if (userService.findByEmail(user.getEmail()).isPresent()) {
            model.addAttribute("error", "Email đã được sử dụng!");
            return "register";
        }


        user.setNgayTao(LocalDateTime.now());
        userService.saveUser(user);

        return "redirect:/login?registerSuccess=true";
    }
    @GetMapping("/auth/access-denied")
    public String accessDeniedPage(Model model) {
        model.addAttribute("error", "Bạn không có quyền truy cập trang này!");
        return "access-denied"; // Trả về trang access-denied.jsp hoặc access-denied.html
    }
}


