package com.example.fpoly.controller;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.entity.HinhAnhSanPham;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.repository.DanhMucRepository;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.DanhMucService;
import com.example.fpoly.service.HinhAnhSanPhamService;
import com.example.fpoly.service.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/sanpham")
public class SanPhamController {
    @Autowired
    private SanPhamRepository sanPhamRepository;
    @Autowired
    private DanhMucRepository danhMucRepository;
    @Autowired
    private SanPhamService sanPhamService;
    @Autowired
    private HinhAnhSanPhamService hinhAnhSanPhamService;
    @Autowired
    private DanhMucService danhMucService;
    @GetMapping("/list")
    public String listSanPham(Model model){
        List<SanPham> dssp = sanPhamRepository.findAll();
        List<DanhMuc> dsdm = danhMucRepository.findAll();

        for (SanPham sp : dssp) {
            List<HinhAnhSanPham> hinhAnhs = hinhAnhSanPhamService.getImagesBySanPhamId(sp.getId());
            sp.setHinhAnhs(hinhAnhs);
        }
        model.addAttribute("dsSanPham" ,dssp);
        model.addAttribute("danhmuc",dsdm);
        return "/sanpham/list";
    }
    @ModelAttribute("danhmuc")
    public List<DanhMuc> getDanhMuc() {
        return danhMucRepository.findAll();
    }



    // =================== ADMIN: CRUD ===================== //




    @PostMapping("/admin/add")
    public String addSanPham(SanPham sanPham){
        sanPhamRepository.save(sanPham);
        return "redirect:/sanpham/admin/add";
    }

    @GetMapping("/admin/add")
    public String showAddForm(Model model){
        model.addAttribute("dsSanPham",sanPhamRepository.findAll());
        model.addAttribute("listDanhMuc",danhMucRepository.findAll());
        return "/admin/sanpham-form";
    }
    @GetMapping("/admin/delete")
    public String deleteSanPham(@RequestParam("id") Integer id){
        sanPhamService.delete(id);
        return "redirect:/sanpham/admin/add";
    }
    @GetMapping("/admin/edit/{id}")
    public String suaSanPham(@PathVariable("id") Integer id, Model model) {
        SanPham sanPham = sanPhamService.getById(id);
        if (sanPham == null) {
            return "redirect:/sanpham/admin";
        }
        model.addAttribute("sanPham", sanPham);
        model.addAttribute("dsSanPham", sanPhamService.getAll());
        model.addAttribute("listDanhMuc", danhMucService.getAll());
        return "/admin/sanpham-form"; // Trả về trang JSP đã có form chỉnh sửa
    }



}
