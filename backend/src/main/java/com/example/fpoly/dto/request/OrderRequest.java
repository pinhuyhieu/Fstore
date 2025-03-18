package com.example.fpoly.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderRequest {
    private int fromDistrictId;    // ID Quận/Huyện người gửi
    private int toDistrictId;      // ID Quận/Huyện người nhận
    private String toWardCode;     // Mã Phường/Xã người nhận
    private String orderCode;      // Mã đơn hàng (có thể tạo ngẫu nhiên hoặc từ hệ thống)
    private int weight;            // Trọng lượng hàng hóa (gram)
    private int length;            // Chiều dài (cm)
    private int width;             // Chiều rộng (cm)
    private int height;            // Chiều cao (cm)
    private int serviceId;         // ID gói dịch vụ
    private int insuranceValue;    // Giá trị bảo hiểm
    private String coupon;         // Mã giảm giá (nếu có)

    // Getters and Setters
}

