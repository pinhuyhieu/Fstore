package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.Size;
import com.example.fpoly.repository.SizeRepository;
import com.example.fpoly.service.SizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeServiceImpl implements SizeService {

    @Autowired
    private SizeRepository sizeRepository;

    @Override
    public List<Size> getAll() {
        return sizeRepository.findAll();
    }

    @Override
    public Size getById(Integer id) {
        return sizeRepository.findById(id).orElse(null);
    }

    @Override
    public Size save(Size size) {
        return sizeRepository.save(size);
    }

    @Override
    public Size update(Integer id, Size size) {
        if (sizeRepository.existsById(id)) {
            size.setId(id);
            return sizeRepository.save(size);
        }
        return null;
    }

    @Override
    public void delete(Integer id) {
        sizeRepository.deleteById(id);
    }
}
