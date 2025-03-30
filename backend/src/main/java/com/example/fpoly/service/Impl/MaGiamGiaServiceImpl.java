package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.MaGiamGia;
import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.MaGiamGiaNguoiDungRepository;
import com.example.fpoly.service.MaGiamGiaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MaGiamGiaServiceImpl implements MaGiamGiaService {
    private final MaGiamGiaNguoiDungRepository nguoiDungRepo;

    @Override
    public Optional<MaGiamGiaNguoiDung> findForUser(User user, String ma) {
        return nguoiDungRepo.findByUserAndMaGiamGia_Ma(user, ma)
                .filter(item -> item.getKichHoat() != null && item.getKichHoat())
                .filter(item -> item.getMaGiamGia().getKichHoat() != null && item.getMaGiamGia().getKichHoat())
                .filter(item -> LocalDateTime.now().isAfter(item.getMaGiamGia().getNgayBatDau()))
                .filter(item -> LocalDateTime.now().isBefore(item.getMaGiamGia().getNgayKetThuc()));
    }

    @Override
    public void danhDauDaSuDung(MaGiamGiaNguoiDung item) {
        item.setKichHoat(false);
        MaGiamGia ma = item.getMaGiamGia();
        ma.setSoLuong(ma.getSoLuong() - 1);
        nguoiDungRepo.save(item);
    }
}
