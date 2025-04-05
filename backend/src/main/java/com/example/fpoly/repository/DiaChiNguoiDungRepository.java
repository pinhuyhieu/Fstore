package com.example.fpoly.repository;

import com.example.fpoly.entity.DiaChiNguoiDung;
import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface DiaChiNguoiDungRepository extends JpaRepository<DiaChiNguoiDung, Integer> {
    List<DiaChiNguoiDung> findByUser(User user);
    Optional<DiaChiNguoiDung> findByUserAndMacDinhTrue(User user);
}

