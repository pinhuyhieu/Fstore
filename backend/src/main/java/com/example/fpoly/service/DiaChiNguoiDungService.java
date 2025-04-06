package com.example.fpoly.service;

import com.example.fpoly.entity.DiaChiNguoiDung;
import com.example.fpoly.entity.User;

import java.util.List;
import java.util.Optional;

public interface DiaChiNguoiDungService {
    List<DiaChiNguoiDung> getAllByUser(User user);
    Optional<DiaChiNguoiDung> getDiaChiMacDinh(User user);
    DiaChiNguoiDung save(DiaChiNguoiDung diaChi);
    void deleteById(Integer id);
}