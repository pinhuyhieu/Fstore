package com.example.fpoly.repository;

import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MaGiamGiaNguoiDungRepository extends JpaRepository<MaGiamGiaNguoiDung, Integer> {
    Optional<MaGiamGiaNguoiDung> findByUserAndMaGiamGia_Ma(User user, String ma);
}
