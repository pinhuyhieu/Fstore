package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.DonHang;
import com.example.fpoly.entity.LichSuTrangThaiDonHang;
import com.example.fpoly.enums.TrangThaiDonHang;
import com.example.fpoly.repository.LichSuTrangThaiRepository;
import com.example.fpoly.service.LichSuTrangThaiService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LichSuTrangThaiServiceImpl implements LichSuTrangThaiService {

    private final LichSuTrangThaiRepository lichSuRepo;

    public LichSuTrangThaiServiceImpl(LichSuTrangThaiRepository lichSuRepo) {
        this.lichSuRepo = lichSuRepo;
    }

    @Override
    public void ghiLichSu(DonHang donHang, TrangThaiDonHang trangThaiMoi, String ghiChu) {
        LichSuTrangThaiDonHang log = new LichSuTrangThaiDonHang();
        log.setDonHang(donHang);
        log.setTrangThaiMoi(trangThaiMoi);
        log.setGhiChu(ghiChu);
        lichSuRepo.save(log);
    }

    @Override
    public List<LichSuTrangThaiDonHang> findByDonHangId(Integer donHangId) {
        return lichSuRepo.findByDonHangIdOrderByThoiGianDesc(donHangId);
    }
}
