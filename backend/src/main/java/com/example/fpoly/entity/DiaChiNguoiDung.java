package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "dia_chi_nguoi_dung")
public class DiaChiNguoiDung {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "nguoi_dung_id") // Khóa ngoại tới bảng user
    private User user;

    @Column(name = "ten_dia_chi")
    private String tenDiaChi; // VD: Nhà riêng, Công ty...

    @Column(name = "so_dien_thoai")
    private String soDienThoai;

    @Column(name = "dia_chi")
    private String diaChi; // Tổng địa chỉ nếu dùng 1 dòng

    @Column(name = "ten_tinh_thanh")
    private String tenTinhThanh;

    @Column(name = "ten_quan_huyen")
    private String tenQuanHuyen;

    @Column(name = "ten_phuong_xa")
    private String tenPhuongXa;

    @Column(name = "dia_chi_chi_tiet")
    private String diaChiChiTiet; // Số nhà, đường...

    @Column(name = "mac_dinh")
    private Boolean macDinh; // Có phải địa chỉ mặc định không
}
