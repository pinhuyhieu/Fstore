package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.SanPham;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SanPhamServiceImpl implements SanPhamService {

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Override
    public List<SanPham> getAll() {
        return sanPhamRepository.findAll();
    }

    @Override
    public SanPham getById(Integer id) {
        return sanPhamRepository.findById(id).orElse(null);
    }

    @Override
    public SanPham save(SanPham sanPham) {
        return sanPhamRepository.save(sanPham);
    }

    @Override
    public SanPham update(Integer id, SanPham sanPham) {
        if (sanPhamRepository.existsById(id)) {
            sanPham.setId(id);
            return sanPhamRepository.save(sanPham);
        }
        return null;
    }

    @Override
    public void delete(Integer id) {
        sanPhamRepository.deleteById(id);
    }
}

