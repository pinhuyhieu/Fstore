package com.example.fpoly.controller;

import com.example.fpoly.entity.Size;
import com.example.fpoly.service.Impl.SizeServiceImpl;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/size")
public class SizeController {
    private final SizeServiceImpl service;

    public SizeController(SizeServiceImpl service) { this.service = service; }

    @GetMapping("/list")
    public String listSizes(Model model) {
        model.addAttribute("sizes", service.getAll());
        return "admin/SizeJSP"; // Thêm "admin/"
    }

    @GetMapping("/form")
    public String formSize(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Size size = id == null ? new Size() : service.getById(id);
        model.addAttribute("size", size);
        return "admin/size-form"; // Thêm "admin/"
    }

    @GetMapping("/edit/{id}")
    public String editSize(@PathVariable("id") Integer id, Model model) {
        Size size = service.getById(id);
        model.addAttribute("size", size);
        model.addAttribute("sizes", service.getAll()); // Để hiện danh sách
        return "admin/SizeJSP"; // Trả về trang form
    }


    @PostMapping ("/save")
    public String saveSize(@ModelAttribute Size size, RedirectAttributes redirectAttributes) {
        boolean isUpdate = size.getId() != null; // Kiểm tra xem có ID hay không

        // VALIDATE
        // Kiểm tra rỗng
        if (size.getTenSize() == null || size.getTenSize().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên size không được để trống.");
            return "redirect:/admin/size/list";
        }

        // Kiểm tra độ dài
        if (size.getTenSize().length() < 1 || size.getTenSize().length() > 5) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên size phải từ 1 - 5 ký tự.");
            return "redirect:/admin/size/list";
        }

        // Kiểm tra ký tự đặc biệt (chỉ cho phép chữ, khoảng trắng, dấu tiếng Việt)
        if (!size.getTenSize().matches("^[a-zA-ZÀ-ỹ ]+$")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục không được chứa ký tự đặc biệt.");
            return "redirect:/admin/size/list";
        }

        // Kiểm tra trùng lặp nếu đang tạo mới
        if (!isUpdate && service.existsByTenSize(size.getTenSize())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên size đã tồn tại.");
            return "redirect:/admin/size/list";
        }
        service.save(size);

        if (isUpdate) {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật size thành công!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm size thành công!");
        }
        return "redirect:/admin/size/list";
    }


    @GetMapping("/delete/{id}")
    public String deleteSize(@PathVariable("id") int id) {
        service.delete(id);
        return "redirect:/admin/size/list";
    }

}
