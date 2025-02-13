package com.example.fpoly.controller;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.repository.DanhMucRepository;
import com.example.fpoly.service.DanhMucService;
import jdk.jfr.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/danh-muc")
public class DanhMucController {
    @Autowired
    DanhMucRepository danhMucRepository;
    @Autowired
    DanhMucService danhMucService;
    @GetMapping("/list")
    public String hienThi(Model model){
        model.addAttribute("listDanhMuc",danhMucRepository.findAll());
        return "danhmuc";
    }
    @PostMapping("/add")
    public String addDanhMuc(DanhMuc danhMuc){
        danhMucRepository.save(danhMuc);
        return "redirect:/danh-muc/list";
    }
    @GetMapping("/delete")
    public String deleteDanhMuc(@RequestParam("id") Integer id){
        danhMucService.deleteDanhMuc(id);
        return "redirect:/danh-muc/list";
    }
}
