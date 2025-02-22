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

import java.util.List;
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
        return sanPhamChiTietRepository.findById(id).orElse(null);
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

}
