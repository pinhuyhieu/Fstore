package com.example.fpoly.repository;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DonHangRepository extends JpaRepository<DonHang, Integer> {
    List<DonHang> findByUser(User user);
}
