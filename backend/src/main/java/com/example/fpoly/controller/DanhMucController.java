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

        // VALIDATE
        // Kiểm tra rỗng
        if (danhMuc.getTenDanhMuc() == null || danhMuc.getTenDanhMuc().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục không được để trống.");
            return "redirect:/admin/danhmuc/list";
        }

        // Kiểm tra độ dài
        if (danhMuc.getTenDanhMuc().length() < 2 || danhMuc.getTenDanhMuc().length() > 30) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục phải từ 2 - 30 ký tự.");
            return "redirect:/admin/danhmuc/list";
        }

        // Kiểm tra ký tự đặc biệt (chỉ cho phép chữ, số, khoảng trắng, dấu tiếng Việt)
        if (!danhMuc.getTenDanhMuc().matches("^[a-zA-ZÀ-ỹ0-9 ]+$")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục không được chứa ký tự đặc biệt.");
            return "redirect:/admin/danhmuc/list";
        }

        // Kiểm tra trùng lặp nếu đang tạo mới
        if (!isUpdate && danhMucService.existsByTenDanhMuc(danhMuc.getTenDanhMuc())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục đã tồn tại.");
            return "redirect:/admin/danhmuc/list";
        }



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
