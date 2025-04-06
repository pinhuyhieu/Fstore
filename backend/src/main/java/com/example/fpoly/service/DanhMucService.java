package com.example.fpoly.service;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.repository.DanhMucRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
public interface DanhMucService {
    List<DanhMuc> getAll();
    DanhMuc getById(Integer id);
    DanhMuc save(DanhMuc danhMuc);
    DanhMuc update(Integer id, DanhMuc danhMuc);
    void delete(Integer id);

    // VALIDATE
    boolean existsByTenDanhMuc(String tenDanhMuc);
}
