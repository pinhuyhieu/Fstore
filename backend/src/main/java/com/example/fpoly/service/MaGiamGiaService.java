package com.example.fpoly.service;

import com.example.fpoly.entity.MaGiamGia;
import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;

import java.util.List;
import java.util.Optional;

public interface MaGiamGiaService {
    Optional<MaGiamGiaNguoiDung> findForUser(User user, String ma);
    void danhDauDaSuDung(MaGiamGiaNguoiDung item);
    List<MaGiamGia> findAll();

    Optional<MaGiamGia> findById(Integer id);

    MaGiamGia save(MaGiamGia maGiamGia);

    void deleteById(Integer id);
}
