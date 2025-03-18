package com.example.fpoly.service;

import com.example.fpoly.dto.request.OrderRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

@Service
public class GHNService {

    private final String API_KEY = "YOUR_GHN_API_KEY";  // API key từ GHN
    private final String API_URL = "https://online-gateway.ghn.vn/shiip/public-api/";

    private final RestTemplate restTemplate;

    @Autowired
    public GHNService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    /**
     * Tạo đơn hàng vận chuyển với GHN API
     * @param orderRequest Thông tin đơn hàng
     * @return ResponseEntity với thông tin tạo đơn hàng
     */
    public ResponseEntity<String> createShippingOrder(OrderRequest orderRequest) {
        String url = API_URL + "v2/shipping-order/create";
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY);
        headers.set("shop_id", "YOUR_SHOP_ID"); // ID cửa hàng của bạn

        String requestBody = createShippingOrderRequestBody(orderRequest);
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        // Gửi yêu cầu POST để tạo đơn hàng vận chuyển
        return restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
    }

    /**
     * Tạo thân dữ liệu yêu cầu tạo đơn hàng
     * @param orderRequest Thông tin đơn hàng
     * @return Dữ liệu request dưới dạng JSON
     */
    private String createShippingOrderRequestBody(OrderRequest orderRequest) {
        return "{"
                + "\"from_district_id\":" + orderRequest.getFromDistrictId() + ","
                + "\"to_district_id\":" + orderRequest.getToDistrictId() + ","
                + "\"to_ward_code\":\"" + orderRequest.getToWardCode() + "\","
                + "\"order_code\":\"" + orderRequest.getOrderCode() + "\","
                + "\"weight\":" + orderRequest.getWeight() + ","
                + "\"length\":" + orderRequest.getLength() + ","
                + "\"width\":" + orderRequest.getWidth() + ","
                + "\"height\":" + orderRequest.getHeight() + ","
                + "\"service_id\":" + orderRequest.getServiceId() + ","
                + "\"insurance_value\":" + orderRequest.getInsuranceValue() + ","
                + "\"coupon\":\"" + orderRequest.getCoupon() + "\""
                + "}";
    }
}
