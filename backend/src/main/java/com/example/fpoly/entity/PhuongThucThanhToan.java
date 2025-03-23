package com.example.fpoly.entity;

import com.example.fpoly.enums.PhuongThucCode;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "phuong_thuc_thanh_toan")
@Getter
@Setter
public class PhuongThucThanhToan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma_phuong_thuc", nullable = false)
    private String maPhuongThuc; // e.g., "COD", "VNPAY", "CREDIT"

    @Column(name = "ten_phuong_thuc", nullable = false)
    private String tenPhuongThuc;

    // ✅ Trả về enum từ mã phương thức
    public PhuongThucCode getPhuongThucCode() {
        return PhuongThucCode.fromString(this.maPhuongThuc);
    }

    // (Tùy chọn) Cho phép set enum dễ dàng
    public void setPhuongThucCode(PhuongThucCode code) {
        this.maPhuongThuc = code.name();
    }
}
