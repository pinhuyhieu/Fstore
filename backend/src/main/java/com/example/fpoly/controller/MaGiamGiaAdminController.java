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
    public String save(@ModelAttribute MaGiamGia maGiamGia, RedirectAttributes redirectAttributes) {
        if (maGiamGia.getKichHoat() == null) {
            maGiamGia.setKichHoat(false); // Gán mặc định nếu không tích
        }

        maGiamGiaService.save(maGiamGia);
        redirectAttributes.addFlashAttribute("success", "Đã lưu mã thành công!");
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

