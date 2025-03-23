package com.example.fpoly.enums;

public enum TrangThaiDonHang {
    CHO_XAC_NHAN("Chờ xác nhận"),
    DANG_CHUAN_BI("Đang chuẩn bị"),
    DANG_GIAO("Đang giao hàng"),
    HOAN_TAT("Hoàn tất"),
    DA_HUY("Đã hủy");

    private final String hienThi;

    TrangThaiDonHang(String hienThi) {
        this.hienThi = hienThi;
    }

    public String getHienThi() {
        return hienThi;
    }
}
