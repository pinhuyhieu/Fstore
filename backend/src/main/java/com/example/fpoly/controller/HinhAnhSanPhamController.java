package com.example.fpoly.controller;

import com.example.fpoly.service.HinhAnhSanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/hinhanh")
public class HinhAnhSanPhamController {

    @Autowired
    private HinhAnhSanPhamService hinhAnhSanPhamService;

    @PostMapping("/upload")
    public String uploadImage(@RequestParam("file") MultipartFile file,
                              @RequestParam("sanPhamId") Integer sanPhamId) {
        hinhAnhSanPhamService.uploadImage(file, sanPhamId);
        return "redirect:/sanpham/admin/add";
    }

    @GetMapping("/delete/{id}")
    public String deleteImage(@PathVariable("id") Integer id,
                              @RequestParam("sanPhamId") Integer sanPhamId) {
        hinhAnhSanPhamService.deleteImage(id);
        return "redirect:/sanpham/edit/" + sanPhamId;
    }
}

