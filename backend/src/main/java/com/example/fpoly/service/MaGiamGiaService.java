package com.example.fpoly.service;

import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;

import java.util.Optional;

public interface MaGiamGiaService {
    Optional<MaGiamGiaNguoiDung> findForUser(User user, String ma);
    void danhDauDaSuDung(MaGiamGiaNguoiDung item);
}
