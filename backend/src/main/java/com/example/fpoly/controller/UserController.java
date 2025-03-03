package com.example.fpoly.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @GetMapping("/info")

    public ResponseEntity<?> getUserInfo(Authentication authentication) {
        logger.info("🔍 User {} đang truy cập thông tin cá nhân", authentication.getName());
        return ResponseEntity.ok("Hello " + authentication.getName() + ", this is your user info!");
    }

    // Thêm các endpoint khác nếu cần
    @GetMapping("/update")

    public ResponseEntity<?> updateUserInfo(Authentication authentication) {
        logger.info("🔍 User {} đang cập nhật thông tin cá nhân", authentication.getName());
        return ResponseEntity.ok("User " + authentication.getName() + " updated their info!");
    }
}