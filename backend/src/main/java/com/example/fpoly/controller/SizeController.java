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
        service.save(size);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm màu sắc thành công!");
        return "redirect:/admin/size/list";
    }


    @GetMapping("/delete/{id}")
    public String deleteSize(@PathVariable("id") int id) {
        service.delete(id);
        return "redirect:/admin/size/list";
    }

}
