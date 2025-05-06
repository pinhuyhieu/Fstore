package com.example.fpoly.controller;

import com.example.fpoly.entity.*;
import com.example.fpoly.repository.DanhMucRepository;
import com.example.fpoly.repository.SanPhamChiTietRepository;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
    @Autowired
    private SanPhamCTService sanPhamCTService;
    @Autowired
    private MauSacService mauSacService;
    @Autowired
    private SizeService sizeService;
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;

    @GetMapping("/index")
    public String index(Model model) {
        List<SanPham> dssp = sanPhamRepository.findAll();
        model.addAttribute("dsSanPham", dssp);
        return "/sanpham/index"; // Trả về trang index.jsp
    }

    @GetMapping("/introduce")
    public String introduce() {
        return "sanpham/introduce";
    }

    @GetMapping("/contact")
    public String contactPage() {
        return "sanpham/contact";
    }


    @GetMapping("/list/search")
    public String timKiemSanPham(@RequestParam(value = "name", required = false) String name,
                                 @RequestParam(value = "minPrice", required = false) BigDecimal minPrice,
                                 @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
                                 Model model) {
        List<SanPham> dsSanPham;

        if (name != null && !name.isEmpty()) {
            dsSanPham = sanPhamService.searchByName(name);
        } else if (minPrice != null && maxPrice != null) {
            List<SanPhamChiTiet> chiTietList = sanPhamChiTietRepository.findByGiaBetween(minPrice, maxPrice);
            dsSanPham = chiTietList.stream().map(SanPhamChiTiet::getSanPham).distinct().toList();
        } else {
            dsSanPham = sanPhamService.getAll();
        }

        List<DanhMuc> dsdm = danhMucRepository.findAll();
        model.addAttribute("danhmuc", dsdm);

        Map<Integer, String> giaSanPhamMap = new HashMap<>();
        NumberFormat formatVND = NumberFormat.getInstance(new Locale("vi", "VN"));

        for (SanPham sp : dsSanPham) {
            List<HinhAnhSanPham> hinhAnhs = hinhAnhSanPhamService.getImagesBySanPhamId(sp.getId());
            sp.setHinhAnhs(hinhAnhs);

            List<SanPhamChiTiet> chiTiets = sanPhamCTService.findBySanPhamId(sp.getId());
            BigDecimal minGia = chiTiets.stream().map(SanPhamChiTiet::getGia).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
            BigDecimal maxGia = chiTiets.stream().map(SanPhamChiTiet::getGia).max(BigDecimal::compareTo).orElse(BigDecimal.ZERO);

            String giaMinStr = formatVND.format(minGia);
            String giaMaxStr = formatVND.format(maxGia);

            String giaHienThi = minGia.equals(maxGia) ? "Giá: " + giaMinStr + "₫" : "Giá: " + giaMinStr + "₫ – " + giaMaxStr + "₫";
            giaSanPhamMap.put(sp.getId(), giaHienThi);
        }

        model.addAttribute("dsSanPham", dsSanPham);
        model.addAttribute("giaMap", giaSanPhamMap);

        return "sanpham/list";
    }

    @GetMapping("/list")
    public String listSanPham(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "danhMucID", required = false) Integer danhMucID,
            Model model) {

        int pageSize = 9;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        Page<SanPham> pageSanPham;

        if (danhMucID != null) {
            pageSanPham = sanPhamService.findByDanhMucId(danhMucID, pageable);
            model.addAttribute("danhMucID", danhMucID); // để giữ lại trạng thái chọn danh mục
        } else {
            pageSanPham = sanPhamService.getAll(pageable);
        }

        List<DanhMuc> dsdm = danhMucRepository.findAll();
        Map<Integer, String> giaSanPhamMap = new HashMap<>();
        NumberFormat formatVND = NumberFormat.getInstance(new Locale("vi", "VN"));

        for (SanPham sp : pageSanPham.getContent()) {
            List<HinhAnhSanPham> hinhAnhs = hinhAnhSanPhamService.getImagesBySanPhamId(sp.getId());
            sp.setHinhAnhs(hinhAnhs);

            List<SanPhamChiTiet> chiTiets = sanPhamCTService.findBySanPhamId(sp.getId());
            BigDecimal minGia = chiTiets.stream().map(SanPhamChiTiet::getGia).min(BigDecimal::compareTo).orElse(BigDecimal.ZERO);
            BigDecimal maxGia = chiTiets.stream().map(SanPhamChiTiet::getGia).max(BigDecimal::compareTo).orElse(BigDecimal.ZERO);

            String giaMinStr = formatVND.format(minGia);
            String giaMaxStr = formatVND.format(maxGia);
            String giaHienThi = minGia.equals(maxGia) ? "Giá: " + giaMinStr + "₫" : "Giá: " + giaMinStr + "₫ – " + giaMaxStr + "₫";

            giaSanPhamMap.put(sp.getId(), giaHienThi);
        }

        model.addAttribute("dsSanPham", pageSanPham.getContent());
        model.addAttribute("danhmuc", dsdm);
        model.addAttribute("giaMap", giaSanPhamMap);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pageSanPham.getTotalPages());

        return "/sanpham/list";
    }



    @GetMapping("/detail/{id}")
    public String detailSanPham(@PathVariable("id") Integer id, Model model) {
        // Lấy thông tin sản phẩm
        SanPham sanPham = sanPhamService.getById(id);
        if (sanPham == null) {
            return "redirect:/sanpham/list"; // Nếu không tìm thấy, quay lại danh sách
        }

        // Lấy danh sách hình ảnh sản phẩm
        List<HinhAnhSanPham> hinhAnhs = hinhAnhSanPhamService.getImagesBySanPhamId(id);
        sanPham.setHinhAnhs(hinhAnhs);

        // Lấy danh sách sản phẩm chi tiết (bao gồm size, màu sắc, số lượng tồn)
        List<SanPhamChiTiet> chiTietList = sanPhamCTService.findBySanPhamId(id);

        // Lấy danh sách màu sắc và kích thước có sẵn
        List<MauSac> mauSacList = mauSacService.getAvailableColorsBySanPhamId(id);
        List<Size> sizeList = sizeService.getAvailableSizesBySanPhamId(id);

        // Truyền dữ liệu đến JSP
        model.addAttribute("sanPham", sanPham);
        model.addAttribute("chiTietList", chiTietList);
        model.addAttribute("mauSacList", mauSacList); // Danh sách màu sắc có sẵn
        model.addAttribute("sizeList", sizeList);     // Danh sách kích thước có sẵn
        return "sanpham/detail"; // Trả về trang JSP hiển thị chi tiết sản phẩm
    }
    @GetMapping("/soLuongTonVaGiaTien")
    @ResponseBody
    public Map<String, Object> getSoLuongTonVaGiaTien(
            @RequestParam(value = "mauSacId", required = false) Integer mauSacId,
            @RequestParam(value = "sizeId", required = false) Integer sizeId,
            @RequestParam(value = "sanPhamId", required = false) Integer sanPhamId) {

        System.out.println("Nhận được mauSacId: " + mauSacId);
        System.out.println("Nhận được sizeId: " + sizeId);
        System.out.println("Nhận được sanPhamId: " + sanPhamId);

        if (mauSacId == null || sizeId == null || sanPhamId == null) {
            return Map.of(
                    "soLuongTon", 0,
                    "giaTien", BigDecimal.ZERO
            );
        }

        Map<String, Object> result = sanPhamCTService.getSoLuongTonVaGiaTien(mauSacId, sizeId, sanPhamId);

        if (result == null || !result.containsKey("soLuongTon") || !result.containsKey("giaTien")) {
            return Map.of(
                    "soLuongTon", 0,
                    "giaTien", BigDecimal.ZERO
            );
        }

        return result;
    }




    // =================== ADMIN: CRUD ===================== //




    @PostMapping("/admin/add")
    public String addSanPham(@ModelAttribute SanPham sanPham, RedirectAttributes redirectAttributes){
        boolean isUpdate = sanPham.getId() != null; // Kiểm tra xem có ID hay không

        // Kiểm tra độ dài
        if (sanPham.getTenSanPham().length() < 2 || sanPham.getTenSanPham().length() > 50) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên sản phẩm phải từ 2 đến 50 ký tự.");
            return "redirect:/sanpham/admin/add";
        }

        // Kiểm tra ký tự đặc biệt
        if (!sanPham.getTenSanPham().matches("^[a-zA-Z0-9\\sÀ-ỹ]+$")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên sản phẩm không được chứa ký tự đặc biệt.");
            return "redirect:/sanpham/admin/add";
        }

        // Kiểm tra trùng lặp tên sản phẩm (trừ trường hợp cập nhật)
        if (sanPham.getId() == null && sanPhamService.existsByTenSanPham(sanPham.getTenSanPham())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên sản phẩm đã tồn tại, vui lòng chọn tên khác.");
            return "redirect:/sanpham/admin/add";
        }

        sanPhamService.save(sanPham);

        if (isUpdate) {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm sản phẩm thành công!");
        }
        return "redirect:/sanpham/admin/add";
    }

    @GetMapping("/admin/add")
    public String showAddForm(Model model){
//        model.addAttribute("dsSanPham",sanPhamRepository.findAll());
        model.addAttribute("listDanhMuc",danhMucRepository.findAll());
        return "/admin/sanpham-form";
    }

    @GetMapping("/admin/list")
    public String showList(@RequestParam(value = "page", defaultValue = "0") int page,
                           @RequestParam(value = "size", defaultValue = "10") int size,
                           @RequestParam(value = "keyword", required = false) String search,
                           Model model) {

        Pageable pageable = PageRequest.of(page, size);

        Page<SanPham> sanPhamPage;
        if (search != null && !search.isEmpty()) {
            // Tìm kiếm sản phẩm theo tên
            sanPhamPage = sanPhamRepository.findByTenSanPhamContainingIgnoreCase(search, pageable);
        } else {
            // Nếu không có từ khóa tìm kiếm, lấy tất cả sản phẩm
            sanPhamPage = sanPhamRepository.findAll(pageable);
        }

        model.addAttribute("dsSanPham", sanPhamPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", sanPhamPage.getTotalPages());  // Total pages
        model.addAttribute("totalItems", sanPhamPage.getTotalElements());
        model.addAttribute("size", size);
        model.addAttribute("keyword", search);  // Đảm bảo keyword được trả về model

        return "/admin/sanpham-list";
    }




    @GetMapping("/admin/delete")
    public String deleteSanPham(@RequestParam("id") Integer id){
        sanPhamService.delete(id);
        return "redirect:/sanpham/admin/list";
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
    @GetMapping("/sanPhamChiTietId") // 💡 Đổi lại đúng tên API trong frontend
    public ResponseEntity<Integer> getSanPhamChiTietId(
            @RequestParam("sanPhamId") Integer sanPhamId,
            @RequestParam("mauSacId") Integer mauSacId,
            @RequestParam("sizeId") Integer sizeId) {

        Integer sanPhamChiTietId = sanPhamCTService.findIdBySanPhamAndMauSacAndSize(sanPhamId, mauSacId, sizeId);
        if (sanPhamChiTietId == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(sanPhamChiTietId);
    }
}
