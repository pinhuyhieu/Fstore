package com.example.fpoly.entity;

import com.example.fpoly.enums.TrangThaiDonHang;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "don_hang")


public class DonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "nguoi_dung_id", nullable = false)
    private User user;

    @Column(name = "ngay_dat", nullable = false)
    private LocalDateTime ngayDatHang = LocalDateTime.now();

    @Column(name = "tong_tien", nullable = false)
    private Double tongTien;

    @Enumerated(EnumType.STRING)
    @Column(name = "trang_thai", nullable = false)
    private TrangThaiDonHang trangThai = TrangThaiDonHang.CHO_XAC_NHAN;


    @Column(name = "ten_nguoi_nhan", nullable = false)
    private String tenNguoiNhan;

    @Column(name = "so_dien_thoai_nguoi_nhan", nullable = false)
    private String soDienThoaiNguoiNhan;

    @Column(name = "dia_chi_giao_hang", nullable = false)
    private String diaChiGiaoHang;
    // Các trường cho Tỉnh/Thành phố, Quận/Huyện, Phường/Xã
    @Column(name = "tinh_thanh", nullable = false)
    private String tinhThanh;

    @Column(name = "quan_huyen", nullable = false)
    private String quanHuyen;

    @Column(name = "phuong_xa", nullable = false)
    private String phuongXa;

    @ManyToOne
    @JoinColumn(name = "phuong_thuc_thanh_toan_id", referencedColumnName = "id", nullable = false)
    private PhuongThucThanhToan phuongThucThanhToan;
    @OneToOne(mappedBy = "donHang", fetch = FetchType.LAZY)
    private ThanhToan thanhToan;


    //    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, orphanRemoval = true)
//    private List<ChiTietDonHang> chiTietDonHangList;
@OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
@JsonManagedReference
private List<ChiTietDonHang> chiTietDonHangList;
}
