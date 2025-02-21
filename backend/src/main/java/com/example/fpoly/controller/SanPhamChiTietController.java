package com.example.fpoly.controller;

import com.example.fpoly.entity.SanPham;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.repository.MauSacRepository;
import com.example.fpoly.repository.SizeRepository;
import com.example.fpoly.service.Impl.SanPhamChiTietServiceImpl;
import com.example.fpoly.service.SanPhamCTService;
import com.example.fpoly.service.SanPhamService;
import com.example.fpoly.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/sanphamchitiet")
public class SanPhamChiTietController {

    @Autowired
    private SanPhamCTService sanPhamChiTietService;
    @Autowired
    private SizeRepository sizeRepository;
    @Autowired
    private MauSacRepository mauSacRepository;
    @Autowired
    private SanPhamService sanPhamService;
    @GetMapping("/add/{sanPhamId}")
    public String listChiTiet(@PathVariable Integer sanPhamId, Model model) {
        List<SanPhamChiTiet> chiTietList = sanPhamChiTietService.findBySanPhamId(sanPhamId);
        model.addAttribute("chiTietList", chiTietList);
        model.addAttribute("sizeList", sizeRepository.findAll()); // Truyền danh sách size
        model.addAttribute("mauSacList", mauSacRepository.findAll());
        return "admin/listSPCT";
    }
    @PostMapping("/add/{sanPhamId}")
    public String addSanPhamChiTiet(@PathVariable("sanPhamId") Integer sanPhamId,
                                    @ModelAttribute SanPhamChiTiet sanPhamChiTiet) {
        // Lấy sản phẩm từ ID
        SanPham sanPham = sanPhamService.getById(sanPhamId);
        if (sanPham == null) {
            throw new RuntimeException("Không tìm thấy sản phẩm với ID: " + sanPhamId);
        }

        // Gán sản phẩm vào sản phẩm chi tiết
        sanPhamChiTiet.setSanPham(sanPham);

        // Lưu sản phẩm chi tiết
        sanPhamChiTietService.save(sanPhamChiTiet);

        // Chuyển hướng về danh sách sản phẩm chi tiết
        return "redirect:/sanphamchitiet/add/" + sanPhamId;
    }
}

