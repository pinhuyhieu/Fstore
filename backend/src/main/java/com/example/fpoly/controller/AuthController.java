package com.example.fpoly.controller;



import com.example.fpoly.dto.request.AuthRequest;
import com.example.fpoly.dto.request.AuthResponse;
import com.example.fpoly.entity.User;
import com.example.fpoly.security.JwtUtil;
import com.example.fpoly.security.UserDetailsServiceImpl;
import com.example.fpoly.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final UserService userService;
    private final JwtUtil jwtUtil;
    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    // API Đăng ký tài khoản
    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody User user) {
        if (user.getMatKhau() == null || user.getMatKhau().isEmpty()) {
            return ResponseEntity.badRequest().body("Mật khẩu không được để trống!");
        }

        userService.saveUser(user);
        return ResponseEntity.ok("Đăng ký tài khoản thành công!");
    }

    // API Đăng nhập & Trả về JWT
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody AuthRequest authRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(authRequest.getTenDangNhap(), authRequest.getMatKhau())
        );

        UserDetails userDetails = userDetailsService.loadUserByUsername(authRequest.getTenDangNhap());
        String token = jwtUtil.generateToken(userDetails);

        return ResponseEntity.ok(new AuthResponse(token));
    }

}
