package com.example.fpoly.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "chi_tiet_don_hang")


public class ChiTietDonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

//    @ManyToOne
//    @JoinColumn(name = "don_hang_id", nullable = false)
//    private DonHang donHang;

    @ManyToOne
    @JoinColumn(name = "don_hang_id", nullable = false)
    @JsonBackReference
    private DonHang donHang;


    @ManyToOne
    @JoinColumn(name = "san_pham_chi_tiet_id", nullable = false)
    private SanPhamChiTiet sanPhamChiTiet;

    @Column(name = "so_luong", nullable = false)
    private int soLuong;

    @Column(name = "gia", nullable = false)
    private BigDecimal giaBan; // Giá bán tại thời điểm mua
}
