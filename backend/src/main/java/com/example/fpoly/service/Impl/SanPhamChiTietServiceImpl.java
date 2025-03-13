package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.entity.Size;
import com.example.fpoly.repository.SanPhamChiTietRepository;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.SanPhamCTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class SanPhamChiTietServiceImpl implements SanPhamCTService{
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Override
    public List<SanPhamChiTiet> findBySanPhamId(Integer sanPhamId) {
        SanPham sanPham = sanPhamRepository.findById(sanPhamId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID: " + sanPhamId));
        return sanPhamChiTietRepository.findBySanPham(sanPham);
    }



    @Override
    public SanPhamChiTiet getById(Integer id) {
        Optional<SanPhamChiTiet> spct = sanPhamChiTietRepository.findById(id);
        if (spct.isEmpty()) {
            System.out.println("❌ Không tìm thấy sản phẩm trong database với ID: " + id);
        } else {
            System.out.println("✅ Tìm thấy sản phẩm: " + spct.get().getSanPham());
        }
        return spct.orElse(null);
    }
    @Override
    public SanPhamChiTiet save(SanPhamChiTiet sanPhamChiTiet) {
        return sanPhamChiTietRepository.save(sanPhamChiTiet);
    }

    @Override
    public SanPhamChiTiet update(Integer id, SanPhamChiTiet sanPhamChiTiet) {
        if (sanPhamChiTietRepository.existsById(id)) {
            sanPhamChiTiet.setId(id);
            return sanPhamChiTietRepository.save(sanPhamChiTiet);
        }
        return null;
    }

    @Override
    public void delete(Integer id) {
        sanPhamChiTietRepository.deleteById(id);
    }

    public Optional<SanPhamChiTiet> findBySanPhamAndMauSacAndSize(SanPham sanPham, MauSac mauSac, Size size) {
        return sanPhamChiTietRepository.findBySanPhamAndMauSacAndSize(sanPham, mauSac, size);
    }

    public Map<String, Object> getSoLuongTonVaGiaTien(Integer mauSacId, Integer sizeId, Integer sanPhamId) {
        Optional<SanPhamChiTiet> sanPhamChiTiet = sanPhamChiTietRepository.findByMauSacAndSizeAndSanPham(mauSacId, sizeId, sanPhamId);
        if (sanPhamChiTiet.isPresent()) {
            return Map.of(
                    "soLuongTon", sanPhamChiTiet.get().getSoLuongTon(),
                    "giaTien", sanPhamChiTiet.get().getGia()
            );
        } else {
            return Map.of(
                    "soLuongTon", 0,
                    "giaTien", BigDecimal.ZERO
            );
        }
    }
    @Override
    public Integer findIdBySanPhamAndMauSacAndSize(Integer sanPhamId, Integer mauSacId, Integer sizeId) {
        Optional<SanPhamChiTiet> sanPhamChiTiet = sanPhamChiTietRepository.findByMauSacAndSizeAndSanPham(mauSacId, sizeId, sanPhamId);
        return sanPhamChiTiet.map(SanPhamChiTiet::getId).orElse(null);
    }

}
