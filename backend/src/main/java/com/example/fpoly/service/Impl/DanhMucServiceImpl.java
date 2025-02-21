package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.repository.DanhMucRepository;
import com.example.fpoly.service.DanhMucService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DanhMucServiceImpl implements DanhMucService {

    @Autowired
    private DanhMucRepository danhMucRepository;

    @Override
    public List<DanhMuc> getAll() {
        return danhMucRepository.findAll();
    }

    @Override
    public DanhMuc getById(Integer id) {
        return danhMucRepository.findById(id).orElse(null);
    }

    @Override
    public DanhMuc save(DanhMuc danhMuc) {
        return danhMucRepository.save(danhMuc);
    }

    @Override
    public DanhMuc update(Integer id, DanhMuc danhMuc) {
        if (danhMucRepository.existsById(id)) {
            danhMuc.setId(id);
            return danhMucRepository.save(danhMuc);
        }
        return null;
    }

    @Override
    public void delete(Integer id) {
        danhMucRepository.deleteById(id);
    }
}
