package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "gio_hang_chi_tiet")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GioHangChiTiet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "gio_hang_id", nullable = false)
    private GioHang gioHang;

    @ManyToOne
    @JoinColumn(name = "san_pham_chi_tiet_id", nullable = false)
    private SanPhamChiTiet sanPhamChiTiet;

    private int soLuong;

    private BigDecimal giaTaiThoiDiemThem; // Giá tại thời điểm thêm vào giỏ

    // ✅ Constructor tùy chỉnh
    public GioHangChiTiet(GioHang gioHang, SanPhamChiTiet sanPhamChiTiet, int soLuong) {
        this.gioHang = gioHang;
        this.sanPhamChiTiet = sanPhamChiTiet;
        this.soLuong = soLuong;
        this.giaTaiThoiDiemThem = sanPhamChiTiet.getGia(); // Lưu giá của sản phẩm
    }


}
