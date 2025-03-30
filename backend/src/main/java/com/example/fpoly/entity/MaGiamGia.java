package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Getter
@Setter
@Table(name = "ma_giam_gia")
public class MaGiamGia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true, nullable = false)
    private String ma;

    private Float phanTramGiam;
    private Float soTienGiam;

    private LocalDateTime ngayBatDau;
    private LocalDateTime ngayKetThuc;

    private Integer soLuong;
    private Float giaTriToiThieu;

    private Boolean kichHoat;

    @OneToMany(mappedBy = "maGiamGia", cascade = CascadeType.ALL)
    private List<MaGiamGiaNguoiDung> danhSachNguoiDung;
}

