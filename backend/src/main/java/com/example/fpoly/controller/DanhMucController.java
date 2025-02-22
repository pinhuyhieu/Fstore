package com.example.fpoly.controller;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.service.DanhMucService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/danhmuc")
public class DanhMucController {

    @Autowired
    private DanhMucService danhMucService;

    @GetMapping("/list")
    public String hienThi(Model model) {
        model.addAttribute("danhmucs", danhMucService.getAll());
        return "admin/danhmuc";
    }

    @PostMapping("/save")
    public String saveDanhMuc(@ModelAttribute DanhMuc danhMuc) {
        danhMucService.save(danhMuc);
        return "redirect:/danhmuc/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteDanhMuc(@PathVariable("id") Integer id) {
        danhMucService.delete(id);
        return "redirect:/danhmuc/list";
    }

    @GetMapping("/edit/{id}")
    public String editDanhMuc(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("danhmuc", danhMucService.getById(id));
        model.addAttribute("danhmucs", danhMucService.getAll());
        return "admin/danhmuc";
    }
}
