package com.example.fpoly.enums;

public enum TrangThaiThanhToan {
    CHUA_THANH_TOAN("Chưa thanh toán"),
    DA_THANH_TOAN("Đã thanh toán"),
    DANG_HOAN_TIEN("Đang hoàn tiền"),
    DA_HOAN_TIEN("Đã hoàn tiền");

    private final String hienThi;

    TrangThaiThanhToan(String hienThi) {
        this.hienThi = hienThi;
    }

    public String getHienThi() {
        return hienThi;
    }
}
