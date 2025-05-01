package com.example.fpoly.controller;

import com.example.fpoly.entity.DiaChiNguoiDung;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.DiaChiNguoiDungService;
import com.example.fpoly.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.regex.Pattern;

@Controller
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final DiaChiNguoiDungService diaChiNguoiDungService;


    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout,
                            @RequestParam(value = "registerSuccess", required = false) String registerSuccess,
                            @RequestParam(value = "clientError", required = false) String clientError,
                            Model model) {
        if (error != null) {
            model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
        }
        if (logout != null) {
            model.addAttribute("message", "Đăng xuất thành công!");
        }
        if (registerSuccess != null) {
            model.addAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
        }
        if ("empty".equals(clientError)) {
            model.addAttribute("clientError", "Tên đăng nhập và mật khẩu không được bỏ trống!");
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
    public String registerPage(Model model, @ModelAttribute("successMessage") String successMessage) {
        model.addAttribute("user", new User());
        if (successMessage != null && !successMessage.isEmpty()) {
            model.addAttribute("successMessage", successMessage);
        }
        return "register";
    }

    @PostMapping("/doRegister")
    public String register(@ModelAttribute User user,HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        String soDienThoai = request.getParameter("soDienThoai").replaceAll("\\D", ""); // Loại bỏ ký tự không phải số
        String tenTinhThanh = request.getParameter("tenTinhThanh");
        String tenQuanHuyen = request.getParameter("tenQuanHuyen");
        String tenPhuongXa = request.getParameter("tenPhuongXa");
        String diaChiChiTiet = request.getParameter("diaChiChiTiet");

        if (userService.findByUsername(user.getTenDangNhap()).isPresent()) {
            model.addAttribute("error", "Tên đăng nhập đã tồn tại!");
            return "register";
        }
        if (userService.findByEmail(user.getEmail()).isPresent()) {
            model.addAttribute("error", "Email đã được sử dụng!");
            return "register";
        }

        if (user.getHoTen() == null || user.getHoTen().trim().isEmpty()
                || user.getTenDangNhap() == null || user.getTenDangNhap().trim().isEmpty()
                || user.getEmail() == null || user.getEmail().trim().isEmpty()
                || user.getMatKhau() == null || user.getMatKhau().trim().isEmpty()
                || request.getParameter("soDienThoai") == null || request.getParameter("soDienThoai").trim().isEmpty()
                || request.getParameter("tenTinhThanh") == null || request.getParameter("tenTinhThanh").trim().isEmpty()
                || request.getParameter("tenQuanHuyen") == null || request.getParameter("tenQuanHuyen").trim().isEmpty()
                || request.getParameter("tenPhuongXa") == null || request.getParameter("tenPhuongXa").trim().isEmpty()
                || request.getParameter("diaChiChiTiet") == null || request.getParameter("diaChiChiTiet").trim().isEmpty()) {

            model.addAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            return "register";
        }

        // ✅ Validate định dạng email
        Pattern emailPattern = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
        if (!emailPattern.matcher(user.getEmail()).matches()) {
            model.addAttribute("error", "Email không hợp lệ! Vui lòng nhập đúng định dạng.");
            return "register";
        }

        // ✅ Validate định dạng số điện thoại: 10 hoặc 11 chữ số
        Pattern phonePattern = Pattern.compile("^\\d{10,11}$");
        if (!phonePattern.matcher(soDienThoai).matches()) {
            model.addAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.");
            return "register";
        }


        // Nếu không có lỗi, lưu thông tin người dùng
        user.setNgayTao(LocalDateTime.now());
        userService.saveUser(user);


        // Tạo đối tượng địa chỉ người dùng
        DiaChiNguoiDung diaChi = new DiaChiNguoiDung();
        diaChi.setUser(user);
        diaChi.setSoDienThoai(soDienThoai);
        diaChi.setTenTinhThanh(tenTinhThanh);
        diaChi.setTenQuanHuyen(tenQuanHuyen);
        diaChi.setTenPhuongXa(tenPhuongXa);
        diaChi.setDiaChiChiTiet(diaChiChiTiet);
        diaChi.setMacDinh(true); // ✅ Đánh dấu là địa chỉ mặc định

        // Lưu địa chỉ
        diaChiNguoiDungService.save(diaChi);
        return "redirect:/login?registerSuccess=true";
    }
    @GetMapping("/auth/access-denied")
    public String accessDeniedPage(Model model) {
        model.addAttribute("error", "Bạn không có quyền truy cập trang này!");
        return "access-denied"; // Trả về trang access-denied.jsp hoặc access-denied.html
    }
}


