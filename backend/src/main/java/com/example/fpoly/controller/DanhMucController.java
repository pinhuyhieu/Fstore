package com.example.fpoly.controller;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.service.DanhMucService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/danhmuc")
public class DanhMucController {

    @Autowired
    private DanhMucService danhMucService;

    @GetMapping("/list")
    public String hienThi(Model model) {
        model.addAttribute("danhmucs", danhMucService.getAll());
        return "admin/danhmuc";
    }

    @PostMapping("/save")
    public String saveDanhMuc(@ModelAttribute DanhMuc danhMuc, RedirectAttributes redirectAttributes) {
        boolean isUpdate = danhMuc.getId() != null; // Kiểm tra xem có ID hay không
        danhMucService.save(danhMuc);

        if (isUpdate) {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật danh mục thành công!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm danh mục thành công!");
        }
        return "redirect:/admin/danhmuc/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteDanhMuc(@PathVariable("id") Integer id) {
        danhMucService.delete(id);
        return "redirect:/admin/danhmuc/list";
    }

    @GetMapping("/edit/{id}")
    public String editDanhMuc(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("danhmuc", danhMucService.getById(id));
        model.addAttribute("danhmucs", danhMucService.getAll());
        return "admin/danhmuc";
    }
}
