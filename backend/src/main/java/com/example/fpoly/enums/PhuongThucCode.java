package com.example.fpoly.enums;

public enum PhuongThucCode {
    COD("Thanh toán khi nhận hàng"),
    CREDIT("Thẻ Tín Dụng"),
    VNPAY("Ví Điện Tử");

    private final String moTa;

    PhuongThucCode(String moTa) {
        this.moTa = moTa;
    }

    public String getMoTa() {
        return moTa;
    }

    public static PhuongThucCode fromString(String code) {
        for (PhuongThucCode pt : values()) {
            if (pt.name().equalsIgnoreCase(code)) {
                return pt;
            }
        }
        throw new IllegalArgumentException("Không tìm thấy phương thức với mã: " + code);
    }
}

