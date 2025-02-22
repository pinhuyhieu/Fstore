package com.example.fpoly.service;

import com.example.fpoly.entity.HinhAnhSanPham;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface HinhAnhSanPhamService {
    void uploadImage(MultipartFile file, Integer sanPhamId);
    void deleteImage(Integer id);
    List<HinhAnhSanPham> getImagesBySanPhamId(Integer sanPhamId);
}
