package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.DonHangRepository;
import com.example.fpoly.service.DonHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DonHangServiceImpl implements DonHangService {

    private final DonHangRepository donHangRepository;

    @Override
    public DonHang createOrder(DonHang donHang) {
        return donHangRepository.save(donHang);
    }

    @Override
    public List<DonHang> getOrdersByUser(User user) {
        return donHangRepository.findByUser(user);
    }

    @Override
    public Optional<DonHang> getOrderById(Integer id) {
        return donHangRepository.findById(id);
    }

    @Override
    public void deleteOrder(Integer id) {
        donHangRepository.deleteById(id);
    }
}
