package com.example.fpoly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {


    @GetMapping("/admin/home")
    public String adminHome() {
        return "admin/admin-home"; // Trả về trang admin-home.jsp
    }

}
