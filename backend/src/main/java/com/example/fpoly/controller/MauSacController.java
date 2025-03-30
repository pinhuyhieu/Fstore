package com.example.fpoly.controller;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.service.Impl.MauSacServiceImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/mausac")
public class MauSacController {
    private final MauSacServiceImpl service;

    public MauSacController(MauSacServiceImpl service) { this.service = service; }

    @GetMapping("/list")
    public String listSizes(Model model) {
        model.addAttribute("mausacs", service.getAll());
        return "admin/MauSacJSP"; // Thêm "admin/"
    }

    @GetMapping("/form")
    public String formMS(@RequestParam(value = "id", required = false) Integer id, Model model) {
        MauSac mausac = id == null ? new MauSac() : service.getById(id);
        model.addAttribute("mausac", mausac);
        return "admin/mausac-form"; // Thêm "admin/"
    }

    @GetMapping("/edit/{id}")
    public String editMS(@PathVariable("id") Integer id, Model model) {
        MauSac mausac = service.getById(id);
        model.addAttribute("mausac", mausac);
        model.addAttribute("mausacs", service.getAll()); // Để hiện danh sách
        return "admin/MauSacJSP"; // Trả về trang form
    }

    @PostMapping("/save")
    public String saveMS(@ModelAttribute MauSac mausac, RedirectAttributes redirectAttributes) {
        boolean isUpdate = mausac.getId() != null; // Kiểm tra xem có ID hay không

        // VALIDATE
        // Kiểm tra rỗng
        if (mausac.getTenMauSac() == null || mausac.getTenMauSac().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc không được để trống.");
            return "redirect:/admin/mausac/list";
        }

        // Kiểm tra độ dài
        if (mausac.getTenMauSac().length() < 2 || mausac.getTenMauSac().length() > 30) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc phải từ 2 - 30 ký tự.");
            return "redirect:/admin/mausac/list";
        }

        // Kiểm tra ký tự đặc biệt (chỉ cho phép chữ, số, khoảng trắng, dấu tiếng Việt)
        if (!mausac.getTenMauSac().matches("^[a-zA-ZÀ-ỹ0-9 ]+$")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc không được chứa ký tự đặc biệt.");
            return "redirect:/admin/mausac/list";
        }

        // Kiểm tra trùng lặp nếu đang tạo mới
        if (!isUpdate && service.existsByTenMauSac(mausac.getTenMauSac())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc đã tồn tại.");
            return "redirect:/admin/mausac/list";
        }


        service.save(mausac);

        if (isUpdate) {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật màu sắc thành công!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm màu sắc thành công!");
        }
        return "redirect:/admin/mausac/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteMS(@PathVariable("id") int id) {
        service.delete(id);
        return "redirect:/admin/mausac/list";
    }

}
