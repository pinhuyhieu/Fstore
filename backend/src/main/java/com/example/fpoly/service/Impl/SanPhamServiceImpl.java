package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.SanPham;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.SanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SanPhamServiceImpl implements SanPhamService {

    @Autowired
    private SanPhamRepository sanPhamRepository;


    @Override
    public List<SanPham> getAll() {
        return sanPhamRepository.findAll();
    }

    @Override
    public Page<SanPham> getAll(Pageable pageable) {
        return sanPhamRepository.findAll(pageable);
    }

    @Override
    public List<SanPham> searchByName(String name) {
        return sanPhamRepository.searchByName(name);
    }

    @Override
    public SanPham getById(Integer id) {
        Optional<SanPham> optionalSanPham = sanPhamRepository.findById(id);
        return optionalSanPham.orElse(null);
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
    // VALIDATE
    @Override
    public boolean existsByTenSanPham(String tenSanPham) {
        return sanPhamRepository.findByTenSanPham(tenSanPham) != null;
    }


    @Override
    public List<SanPham> layDanhSachSanPham(Integer danhMucId) {
        return sanPhamRepository.findAllWithDetails(danhMucId);
    }

    @Override
    public Page<SanPham> convertToPage(List<SanPham> sanPhams, Pageable pageable) {
        int start = (int) pageable.getOffset();
        int end = Math.min(start + pageable.getPageSize(), sanPhams.size());
        List<SanPham> sublist = sanPhams.subList(start, end);
        return new PageImpl<>(sublist, pageable, sanPhams.size());
    }
}
