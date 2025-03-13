package com.example.fpoly.service.impl;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.GioHangRepository;
import com.example.fpoly.service.GioHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GioHangServiceImpl implements GioHangService {
    private final GioHangRepository gioHangRepository;

    @Override
    public GioHang getGioHangByUser(User user) {
        return gioHangRepository.findByUser(user).orElseGet(() -> {
            GioHang newCart = new GioHang();
            newCart.setUser(user);
            return gioHangRepository.save(newCart);
        });
    }

    @Override
    public void clearCart(User user) {
        gioHangRepository.deleteByUser(user);
    }

    @Override
    public void save(GioHang gioHang) {
        gioHangRepository.save(gioHang);
    }
}
