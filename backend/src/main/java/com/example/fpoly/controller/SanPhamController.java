package com.example.fpoly.controller;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.repository.DanhMucRepository;
import com.example.fpoly.repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/sanpham")
public class SanPhamController {
    @Autowired
    private SanPhamRepository sanPhamRepository;
    @Autowired
    private DanhMucRepository danhMucRepository;
    @GetMapping("/list")
    public String listSanPham(Model model){
        List<SanPham> dssp = sanPhamRepository.findAll();
        List<DanhMuc> dsdm = danhMucRepository.findAll();
        model.addAttribute("dsSanPham" ,dssp);
        model.addAttribute("danhmuc",dsdm);
        return "sanpham-list";
    }
    @ModelAttribute("danhmuc")
    public List<DanhMuc> getDanhMuc() {
        return danhMucRepository.findAll();
    }
    @PostMapping("/add")
    public String addSanPham(SanPham sanPham){
        sanPhamRepository.save(sanPham);
        return "redirect:/sanpham-add";
    }
    @GetMapping("/add")
    public String showAddForm(){
        return "sanpham-add";
    }

}
