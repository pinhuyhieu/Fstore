package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.ChiTietDonHang;
import com.example.fpoly.entity.DonHang;
import com.example.fpoly.repository.ChiTietDonHangRepository;
import com.example.fpoly.service.ChiTietDonHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ChiTietDonHangServiceImpl implements ChiTietDonHangService {

    private final ChiTietDonHangRepository chiTietDonHangRepository;

    @Override
    public ChiTietDonHang saveOrderDetail(ChiTietDonHang chiTietDonHang) {
        return chiTietDonHangRepository.save(chiTietDonHang);
    }

    @Override
    public List<ChiTietDonHang> getDetailsByOrder(DonHang donHang) {
        return chiTietDonHangRepository.findByDonHang(donHang);
    }

    @Override
    public Optional<ChiTietDonHang> getDetailById(Integer id) {
        return chiTietDonHangRepository.findById(id);
    }

    @Override
    public void deleteOrderDetail(Integer id) {
        chiTietDonHangRepository.deleteById(id);
    }
}
