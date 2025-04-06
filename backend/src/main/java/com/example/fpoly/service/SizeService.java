package com.example.fpoly.service;

import com.example.fpoly.entity.Size;
import com.example.fpoly.repository.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface SizeService {
    List<Size> getAll();
    Size getById(Integer id);
    Size save(Size size);
    Size update(Integer id, Size size);
    void delete(Integer id);
    public List<Size> getAvailableSizesBySanPhamId(Integer sanPhamId);

    // VALIDATE
    boolean existsByTenSize(String tenSize);

}
