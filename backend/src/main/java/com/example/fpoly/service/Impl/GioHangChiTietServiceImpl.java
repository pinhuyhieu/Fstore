package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.*;
import com.example.fpoly.repository.GioHangChiTietRepository;
import com.example.fpoly.service.GioHangChiTietService;
import com.example.fpoly.service.GioHangService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class GioHangChiTietServiceImpl implements GioHangChiTietService {
    @Override
    public Optional<GioHangChiTiet> findById(Integer id) {
        return gioHangChiTietRepository.findById(id);
    }
    private final GioHangChiTietRepository gioHangChiTietRepository;
    private final GioHangService gioHangService;

    @Override
    public List<GioHangChiTiet> getCartDetails(GioHang gioHang) {
        return gioHangChiTietRepository.findByGioHang(gioHang);
    }

    @Override
    public void addToCart(User user, SanPhamChiTiet sanPhamChiTiet, int soLuong) {
        GioHang gioHang = gioHangService.getGioHangByUser(user);
        Optional<GioHangChiTiet> existingItem = gioHangChiTietRepository.findByGioHangAndSanPhamChiTiet(gioHang, sanPhamChiTiet);

        GioHangChiTiet gioHangChiTiet = existingItem.orElse(new GioHangChiTiet(gioHang, sanPhamChiTiet, 0));
        gioHangChiTiet.setSoLuong(gioHangChiTiet.getSoLuong() + soLuong);
        gioHangChiTietRepository.save(gioHangChiTiet);
    }

    @Override
    @Transactional
    public void updateQuantity(Integer gioHangChiTietId, int soLuong) {
        Optional<GioHangChiTiet> optionalGioHangChiTiet = gioHangChiTietRepository.findById(gioHangChiTietId);
        if (optionalGioHangChiTiet.isPresent()) {
            GioHangChiTiet gioHangChiTiet = optionalGioHangChiTiet.get();
            if (soLuong > 0) {
                gioHangChiTiet.setSoLuong(soLuong);
                gioHangChiTietRepository.save(gioHangChiTiet);
            } else {
                gioHangChiTietRepository.deleteById(gioHangChiTietId); // Nếu số lượng về 0, xóa sản phẩm khỏi giỏ
            }
        } else {
            throw new RuntimeException("❌ Không tìm thấy sản phẩm trong giỏ hàng");
        }
    }
    @Override
    public int getSoLuongTon(Integer gioHangChiTietId) {
        GioHangChiTiet gioHangChiTiet = gioHangChiTietRepository.findById(gioHangChiTietId)
                .orElseThrow(() -> new RuntimeException("❌ Không tìm thấy sản phẩm trong giỏ hàng."));

        // Giả sử `SanPhamChiTiet` có phương thức `getSoLuongTon()`
        return gioHangChiTiet.getSanPhamChiTiet().getSoLuongTon();
    }

    @Override
    public void removeById(Integer gioHangChiTietId) {
        gioHangChiTietRepository.deleteById(gioHangChiTietId);
    }
}
