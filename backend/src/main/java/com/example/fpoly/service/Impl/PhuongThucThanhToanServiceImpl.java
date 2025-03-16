package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.PhuongThucThanhToan;
import com.example.fpoly.repository.PhuongThucThanhToanRepository;
import com.example.fpoly.service.PhuongThucThanhToanService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PhuongThucThanhToanServiceImpl implements PhuongThucThanhToanService {
    private final PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @Override
    public List<PhuongThucThanhToan> getAllPaymentMethods() {
        return phuongThucThanhToanRepository.findAll();
    }

    @Override
    public Optional<PhuongThucThanhToan> findById(Integer id) {
        return phuongThucThanhToanRepository.findById(id);
    }
}
