package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.MauSac;
import com.example.fpoly.repository.MauSacRepository;
import com.example.fpoly.service.MauSacService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MauSacServiceImpl implements MauSacService {

    @Autowired
    private MauSacRepository mauSacRepository;

    @Override
    public List<MauSac> getAll() {
        return mauSacRepository.findAll();
    }

    @Override
    public MauSac getById(Integer id) {
        return mauSacRepository.findById(id).orElse(null);
    }

    @Override
    public MauSac save(MauSac mauSac) {
        return mauSacRepository.save(mauSac);
    }

    @Override
    public MauSac update(Integer id, MauSac mauSac) {
        if (mauSacRepository.existsById(id)) {
            mauSac.setId(id);
            return mauSacRepository.save(mauSac);
        }
        return null;
    }

    @Override
    public void delete(Integer id) {
        mauSacRepository.deleteById(id);
    }
    public List<MauSac> getAvailableColorsBySanPhamId(Integer sanPhamId) {
        return mauSacRepository.findAvailableColorsBySanPhamId(sanPhamId);
    }

    // VALIDATE
    @Override
    public boolean existsByTenMauSac(String tenMauSac) {
        return mauSacRepository.findByTenMauSac(tenMauSac) != null;
    }
}
