package com.example.fpoly.service;

import com.example.fpoly.entity.DanhMuc;
import com.example.fpoly.repository.DanhMucRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DanhMucService {
    @Autowired
    DanhMucRepository danhMucRepository;
    public void deleteDanhMuc(Integer id) {
        danhMucRepository.deleteById(id);
    }
}
