package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.ThanhToan;
import com.example.fpoly.repository.ThanhToanRepository;
import com.example.fpoly.service.ThanhToanService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ThanhToanServiceImpl implements ThanhToanService {

    private final ThanhToanRepository thanhToanRepository;

    @Override
    public ThanhToan save(ThanhToan thanhToan) {
        return thanhToanRepository.save(thanhToan);
    }

    @Override
    public Optional<ThanhToan> findByMaGiaoDich(String maGiaoDich) {
        return thanhToanRepository.findByMaGiaoDich(maGiaoDich);
    }
    @Override
    public Optional<ThanhToan> findByDonHangId(Integer donHangId) {
        return thanhToanRepository.findByDonHang_Id(donHangId);
    }
}
