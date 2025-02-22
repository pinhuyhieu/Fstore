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
    @GetMapping("/list/{sanPhamId}")
    public String listChiTiet(@PathVariable Integer sanPhamId, Model model) {

        List<SanPhamChiTiet> chiTietList = sanPhamChiTietService.findBySanPhamId(sanPhamId);
        model.addAttribute("chiTietList", chiTietList);
        model.addAttribute("sizeList", sizeRepository.findAll()); // Truyền danh sách size
        model.addAttribute("mauSacList", mauSacRepository.findAll());
        return "admin/listSPCT";
    }
    @GetMapping("/edit/{id}")
    public String editChiTiet(@PathVariable("id") Integer id, Model model) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietService.getById(id);
        if (sanPhamChiTiet == null) {
            return "redirect:/sanphamchitiet/list/" + sanPhamChiTiet.getSanPham().getId();
        }
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("chiTietList", sanPhamChiTietService.findBySanPhamId(sanPhamChiTiet.getSanPham().getId()));
        model.addAttribute("sizeList", sizeRepository.findAll());
        model.addAttribute("mauSacList", mauSacRepository.findAll());
        model.addAttribute("sanPham", sanPhamChiTiet.getSanPham());
        return "admin/listSPCT";
    }
    @PostMapping("/save")
    public String saveSanPhamChiTiet(@RequestParam(value = "id", required = false) Integer id,
                                     @RequestParam(value = "sanPhamId", required = false) Integer sanPhamId,
                                     @ModelAttribute SanPhamChiTiet sanPhamChiTiet) {

        System.out.println("DEBUG: sanPhamId = " + sanPhamId);
        System.out.println("DEBUG: id = " + id);

        if (id != null) {
            // Nếu có ID → Cập nhật sản phẩm chi tiết
            SanPhamChiTiet existingChiTiet = sanPhamChiTietService.getById(id);
            if (existingChiTiet != null) {
                existingChiTiet.setSize(sanPhamChiTiet.getSize());
                existingChiTiet.setMauSac(sanPhamChiTiet.getMauSac());
                existingChiTiet.setGia(sanPhamChiTiet.getGia());
                existingChiTiet.setSoLuongTon(sanPhamChiTiet.getSoLuongTon());
                sanPhamChiTietService.save(existingChiTiet);
            }
            return "redirect:/sanphamchitiet/list/" + existingChiTiet.getSanPham().getId();
        }

        // Nếu không có ID → Thêm mới
        if (sanPhamId == null) {
            throw new RuntimeException("sanPhamId không được null khi thêm mới!");
        }
        SanPham sanPham = sanPhamService.getById(sanPhamId);
        if (sanPham == null) {
            throw new RuntimeException("Không tìm thấy sản phẩm với ID: " + sanPhamId);
        }

        sanPhamChiTiet.setSanPham(sanPham);
        sanPhamChiTietService.save(sanPhamChiTiet);

        return "redirect:/sanphamchitiet/list/" + sanPhamId;
    }
    @GetMapping("/delete/{id}")
    public String deleteChiTiet(@PathVariable("id") Integer id) {
        SanPhamChiTiet chiTiet = sanPhamChiTietService.getById(id);
        if (chiTiet != null) {
            Integer sanPhamId = chiTiet.getSanPham().getId();
            sanPhamChiTietService.delete(id);
            return "redirect:/sanphamchitiet/list/" + sanPhamId;
        }
        return "redirect:/sanpham/list";
    }
}

