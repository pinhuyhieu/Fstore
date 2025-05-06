package com.example.fpoly.controller;

import com.example.fpoly.entity.MaGiamGia;
import com.example.fpoly.service.MaGiamGiaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/ma-giam-gia")
@RequiredArgsConstructor
public class MaGiamGiaAdminController {
    private final MaGiamGiaService maGiamGiaService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("dsMaGiamGia", maGiamGiaService.findAll());
        return "admin/list"; // JSP hoặc Thymeleaf
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("maGiamGia", new MaGiamGia()); // chỉ tạo object mới, không lưu
        return "admin/form";
    }


    @PostMapping("/save")
    public String saveMaGiamGia(@ModelAttribute("maGiamGia") MaGiamGia maGiamGia, RedirectAttributes redirectAttributes) {
        try {
            if (maGiamGiaService.isMaGiamGiaExist(maGiamGia.getMa())) {
                redirectAttributes.addFlashAttribute("error", "Mã giảm giá đã tồn tại!");
                return "redirect:/admin/ma-giam-gia/add"; // Quay lại trang thêm mã
            }
            maGiamGiaService.save(maGiamGia);
            redirectAttributes.addFlashAttribute("success", "Đã lưu mã giảm giá thành công!");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
            return "redirect:/admin/ma-giam-gia/add";
        }
        return "redirect:/admin/ma-giam-gia"; // Chuyển hướng đến danh sách mã giảm giá
    }

    @PostMapping("/update/{id}")
    public String updateMaGiamGia(@PathVariable Integer id,
                                  @ModelAttribute("maGiamGia") MaGiamGia maGiamGia,
                                  RedirectAttributes redirectAttributes) {
        try {
            if (maGiamGiaService.isMaGiamGiaExist(maGiamGia.getMa()) &&
                    !maGiamGia.getId().equals(id)) {  // Đảm bảo mã khác ID chính mình
                redirectAttributes.addFlashAttribute("error", "Mã giảm giá đã tồn tại!");
                return "redirect:/admin/ma-giam-gia/edit/" + id;
            }
            maGiamGia.setId(id); // Gán lại ID để chắc chắn đúng
            maGiamGiaService.save(maGiamGia);
            redirectAttributes.addFlashAttribute("success", "Đã cập nhật mã giảm giá thành công!");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
            return "redirect:/admin/ma-giam-gia/edit/" + id;
        }
        return "redirect:/admin/ma-giam-gia";
    }





    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("maGiamGia", maGiamGiaService.findById(id).orElseThrow());
        return "admin/form";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        maGiamGiaService.deleteById(id);
        redirectAttributes.addFlashAttribute("success", "Đã xóa mã!");
        return "redirect:/admin/ma-giam-gia";
    }



}

