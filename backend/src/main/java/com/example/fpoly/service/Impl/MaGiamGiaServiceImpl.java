package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.MaGiamGia;
import com.example.fpoly.entity.MaGiamGiaNguoiDung;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.MaGiamGiaNguoiDungRepository;
import com.example.fpoly.repository.MaGiamGiaRepository;
import com.example.fpoly.service.MaGiamGiaService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional

public class MaGiamGiaServiceImpl implements MaGiamGiaService {
    private final MaGiamGiaNguoiDungRepository nguoiDungRepo;
    private final MaGiamGiaRepository maGiamGiaRepository;

    @Override
    public Optional<MaGiamGiaNguoiDung> findForUser(User user, String ma) {
        return nguoiDungRepo.findByUserAndMaGiamGia_Ma(user, ma)
                .filter(item -> item.getKichHoat() != null && item.getKichHoat())
                .filter(item -> item.getMaGiamGia().getKichHoat() != null && item.getMaGiamGia().getKichHoat())
                .filter(item -> LocalDate.now().isAfter(item.getMaGiamGia().getNgayBatDau()))
                .filter(item -> LocalDate.now().isBefore(item.getMaGiamGia().getNgayKetThuc()));
    }

    @Override
    public void danhDauDaSuDung(MaGiamGiaNguoiDung item) {
        System.out.println("📌 Đang gọi danhDauDaSuDung cho user: " + item.getUser().getHoTen());

        // 1. Đánh dấu mã đã sử dụng cho người dùng
        item.setKichHoat(true); // Nếu bạn có field `daSuDung`, nên dùng tên này thay vì `kichHoat`

        // 2. Trừ số lượng của mã chính
        MaGiamGia ma = item.getMaGiamGia();
        if (ma.getSoLuong() != null && ma.getSoLuong() > 0) {
            ma.setSoLuong(ma.getSoLuong() - 1);
        }

        // 3. Lưu cả 2 thay đổi
        maGiamGiaRepository.save(ma);
        nguoiDungRepo.save(item); // Đặt đúng tên repo của MaGiamGiaNguoiDung
    }

    @Override
    public List<MaGiamGia> findAll() {
        return maGiamGiaRepository.findAll();
    }

    @Override
    public Optional<MaGiamGia> findById(Integer id) {
        return maGiamGiaRepository.findById(id);
    }

    @Override
    public MaGiamGia save(MaGiamGia maGiamGia) {
        // Kiểm tra nếu mã giảm giá đã tồn tại trong cơ sở dữ liệu
        if (maGiamGiaRepository.existsByMa(maGiamGia.getMa())) {
            throw new IllegalArgumentException("Mã giảm giá này đã tồn tại!");
        }

        // Nếu không có lỗi, thực hiện lưu mã giảm giá
        return maGiamGiaRepository.save(maGiamGia);
    }

    @Override
    public void deleteById(Integer id) {
        maGiamGiaRepository.deleteById(id);
    }
    public List<MaGiamGiaNguoiDung> findAllForUser(User user) {
        return nguoiDungRepo.findByUser(user).stream()
                .filter(mggnd -> mggnd.getKichHoat() != null && mggnd.getKichHoat())
                .filter(mggnd -> {
                    MaGiamGia mgg = mggnd.getMaGiamGia();
                    return mgg.getKichHoat() != null && mgg.getKichHoat()
                            && (mgg.getSoLuong() == null || mgg.getSoLuong() > 0)
                            && (mgg.getNgayKetThuc() == null || !mgg.getNgayKetThuc().isBefore(LocalDate.now()));
                })
                .toList();
    }

}
