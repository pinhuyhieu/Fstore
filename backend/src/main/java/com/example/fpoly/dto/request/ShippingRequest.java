package com.example.fpoly.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ShippingRequest {
    private int serviceId;         // ID của gói dịch vụ
    private int insuranceValue;    // Giá trị bảo hiểm
    private String coupon;         // Mã giảm giá (nếu có)
    private int fromDistrictId;    // ID của quận/huyện người gửi
    private int toDistrictId;      // ID của quận/huyện người nhận
    private String toWardCode;     // Mã Phường/Xã người nhận
    private int weight;            // Trọng lượng hàng hóa (gram)
    private int length;            // Chiều dài (cm)
    private int width;             // Chiều rộng (cm)
    private int height;            // Chiều cao (cm)

}
