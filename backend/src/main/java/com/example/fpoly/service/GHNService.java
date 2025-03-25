package com.example.fpoly.service;

import com.example.fpoly.dto.request.OrderRequest;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

@Service
public class GHNService {

    private final String API_KEY = "0de48c96-041e-11f0-aff4-822fc4284d92";  // API key từ GHN
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
    public String getProvinceName(String provinceId) {
        String url = API_URL + "master-data/province";
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return extractNameFromResponse(response.getBody(), provinceId, "ProvinceID", "ProvinceName");
    }

    public String getDistrictName(String provinceId, String districtId) {
        if (provinceId == null || districtId == null || provinceId.isEmpty() || districtId.isEmpty()) {
            return "Không xác định";
        }

        String url = API_URL + "master-data/district?province_id=" + provinceId;
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return extractNameFromResponse(response.getBody(), districtId, "DistrictID", "DistrictName");
    }
    public String getWardName(String districtId, String wardCode) {
        if (districtId == null || wardCode == null || districtId.isEmpty() || wardCode.isEmpty()) {
            return "Không xác định";
        }

        String url = API_URL + "master-data/ward?district_id=" + districtId;
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return extractNameFromResponse(response.getBody(), wardCode, "WardCode", "WardName");
    }


    // 🔍 Phương thức xử lý dữ liệu JSON trả về từ GHN API
    private String extractNameFromResponse(String responseBody, Object id, String idKey, String nameKey) {
        try {
            JSONObject jsonResponse = new JSONObject(responseBody);
            JSONArray data = jsonResponse.getJSONArray("data");

            for (int i = 0; i < data.length(); i++) {
                JSONObject item = data.getJSONObject(i);
                if (item.get(idKey).toString().equals(id.toString())) {
                    return item.getString(nameKey);
                }
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return "Không xác định";
    }
    public int getAvailableServiceId(int fromDistrictId, int toDistrictId) {
        String url = "https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services";

        JSONObject requestBody = new JSONObject();
        requestBody.put("shop_id", 5691281); // ✅ Thay bằng shop ID thật của bạn
        requestBody.put("from_district", fromDistrictId);
        requestBody.put("to_district", toDistrictId);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Token", API_KEY); // ⚠️ Token GHN của bạn
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(requestBody.toString(), headers);

        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.POST,
                entity,
                String.class
        );

        if (response.getStatusCode().is2xxSuccessful()) {
            JSONObject jsonResponse = new JSONObject(response.getBody());
            JSONArray dataArray = jsonResponse.getJSONArray("data");

            if (!dataArray.isEmpty()) {
                int serviceId = dataArray.getJSONObject(0).getInt("service_id"); // Lấy cái đầu tiên
                System.out.println("✅ service_id được chọn: " + serviceId);
                return serviceId;
            } else {
                throw new RuntimeException("❌ Không có dịch vụ khả dụng cho tuyến này.");
            }
        } else {
            throw new RuntimeException("❌ Lỗi GHN khi lấy available-services: " + response.getBody());
        }
    }




    public int tinhTienShipTheoSoLuong(int soLuongSanPham, int toDistrictId, String toWardCode, int insuranceValue) {
        String url = API_URL + "v2/shipping-order/fee";

        // Ước lượng cân nặng & kích thước
        int weight = soLuongSanPham * 300; // mỗi món 300g
        int length = 30, width = 25, height = 10;

        if (soLuongSanPham <= 2) {
            length = 25; width = 20; height = 5;
        } else if (soLuongSanPham >= 5) {
            length = 35; width = 30; height = 15;
        }
        int serviceId = getAvailableServiceId(1482, toDistrictId);
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("shop_id", "5691281"); // điền ShopId thật

        JSONObject json = new JSONObject();
        try {
            json.put("from_district_id", 1482); // Mã quận cửa hàng của bạn (ví dụ: Q.1 HCM)
            json.put("service_id", serviceId);
            json.put("to_district_id", toDistrictId);
            json.put("to_ward_code", toWardCode);
            json.put("weight", weight);
            json.put("length", length);
            json.put("width", width);
            json.put("height", height);
            json.put("insurance_value", insuranceValue);
            System.out.println("📦 GHN Fee Request JSON:\n" + json.toString(2));

        } catch (JSONException e) {
            e.printStackTrace();
            return 0;
        }

        HttpEntity<String> request = new HttpEntity<>(json.toString(), headers);
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
            JSONObject responseJson = new JSONObject(response.getBody());
            JSONObject data = responseJson.getJSONObject("data");
            return data.getInt("total");
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }



}
