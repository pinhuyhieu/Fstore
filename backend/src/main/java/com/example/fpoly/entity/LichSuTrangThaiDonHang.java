package com.example.fpoly.entity;

import com.example.fpoly.enums.TrangThaiDonHang;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "lich_su_trang_thai_don_hang")
public class LichSuTrangThaiDonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "don_hang_id", nullable = false)
    private DonHang donHang;

    @Enumerated(EnumType.STRING)
    @Column(name = "trang_thai_moi", nullable = false)
    private TrangThaiDonHang trangThaiMoi;

    @Column(name = "thoi_gian", nullable = false)
    private LocalDateTime thoiGian = LocalDateTime.now();

    @Column(name = "ghi_chu")
    private String ghiChu;

    // Getters & Setters
    // ...
}
