package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.GioHang;
import com.example.fpoly.entity.User;
import com.example.fpoly.entity.SanPhamChiTiet;
import com.example.fpoly.repository.GioHangRepository;
import com.example.fpoly.repository.SanPhamChiTietRepository;
import com.example.fpoly.service.GioHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GioHangServiceImpl implements GioHangService {
    @Autowired
    private GioHangRepository gioHangRepository;

    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository; // Thêm repository này

    @Override
    public List<GioHang> getGioHangByUser(User user) {
        return gioHangRepository.findByUser(user);
    }

    @Override
    public void addToCart(User user, SanPhamChiTiet sanPhamChiTiet, int soLuong) {
        Optional<GioHang> existingItem = gioHangRepository.findByUser(user)
                .stream()
                .filter(item -> item.getSanPhamChiTiet().getId().equals(sanPhamChiTiet.getId()))
                .findFirst();

        if (existingItem.isPresent()) {
            GioHang gioHang = existingItem.get();
            gioHang.setSoLuong(gioHang.getSoLuong() + soLuong);
            gioHangRepository.save(gioHang);
        } else {
            GioHang gioHang = new GioHang();
            gioHang.setUser(user);
            gioHang.setSanPhamChiTiet(sanPhamChiTiet);
            gioHang.setSoLuong(soLuong);
            gioHangRepository.save(gioHang);
        }
    }

    @Override
    public void removeFromCart(Integer id) {
        gioHangRepository.deleteById(id);
    }

    // Sửa phương thức này để đảm bảo truyền đúng đối tượng SanPhamChiTiet
    public void themSanPhamVaoGio(User user, Integer sanPhamChiTietId, int soLuong) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamChiTietId)
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));

        Optional<GioHang> existingGioHang = gioHangRepository.findByUserAndSanPhamChiTiet(user, sanPhamChiTiet);

        GioHang gioHang = existingGioHang.orElse(new GioHang());
        gioHang.setUser(user);
        gioHang.setSanPhamChiTiet(sanPhamChiTiet);
        gioHang.setSoLuong(gioHang.getSoLuong() + soLuong);

        gioHangRepository.save(gioHang);
    }
}
