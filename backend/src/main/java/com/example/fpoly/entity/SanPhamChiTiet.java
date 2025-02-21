package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham_chi_tiet")
public class SanPhamChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "gia")
    private BigDecimal gia;
    @Column(name = "so_luong_ton")
    private int soLuongTon;
    @ManyToOne
    @JoinColumn(name = "size_id", referencedColumnName = "id")
    private Size size;
    @ManyToOne
    @JoinColumn(name = "mau_sac_id", referencedColumnName = "id")
    private MauSac mauSac;
    @ManyToOne
    @JoinColumn(name = "san_pham_id", referencedColumnName = "id") // Khớp với tên cột trong DB
    private SanPham sanPham;

}
