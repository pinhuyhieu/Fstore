package com.example.fpoly.util;

import com.example.fpoly.enums.TrangThaiDonHang;

import java.util.List;

public class TrangThaiValidator {

    public static boolean isHopLe(TrangThaiDonHang hienTai, TrangThaiDonHang moi) {
        return switch (hienTai) {
            case CHO_XAC_NHAN -> List.of(TrangThaiDonHang.DANG_CHUAN_BI, TrangThaiDonHang.DA_HUY).contains(moi);
            case DANG_CHUAN_BI -> List.of(TrangThaiDonHang.DANG_GIAO, TrangThaiDonHang.DA_HUY).contains(moi);
            case DANG_GIAO -> List.of(TrangThaiDonHang.HOAN_TAT).contains(moi);
            case HOAN_TAT, DA_HUY -> false; // Không thể đổi trạng thái từ đây
        };
    }
}
