package com.example.fpoly.controller;

import com.example.fpoly.dto.request.OrderRequest;
import com.example.fpoly.dto.request.ShippingRequest;
import com.example.fpoly.service.GHNService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api/ghn")
public class GHNController {

    private final String API_KEY = "0de48c96-041e-11f0-aff4-822fc4284d92"; // Thay bằng API key của bạn từ GHN
    private final String API_URL = "https://online-gateway.ghn.vn/shiip/public-api/";

    @Autowired
    private RestTemplate restTemplate;

    /**
     * Lấy danh sách Tỉnh/Thành phố
     * @return ResponseEntity với danh sách các tỉnh thành
     */
    @GetMapping("/provinces")
    public ResponseEntity<String> getProvinces() {
        String url = API_URL + "master-data/province";
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY); // Thêm token vào headers

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Gửi yêu cầu GET đến GHN API để lấy danh sách Tỉnh/Thành phố
        return restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
    }

    /**
     * Lấy danh sách Quận/Huyện theo Tỉnh/Thành phố
     * @param provinceId ID của Tỉnh/Thành phố
     * @return ResponseEntity với danh sách Quận/Huyện
     */
    @GetMapping("/districts/{provinceId}")
    public ResponseEntity<String> getDistricts(@PathVariable int provinceId) {
        String url = API_URL + "master-data/district?province_id=" + provinceId;
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY); // Thêm token vào headers

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Gửi yêu cầu GET để lấy Quận/Huyện của Tỉnh/Thành phố
        return restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
    }

    /**
     * Lấy danh sách Phường/Xã theo Quận/Huyện
     * @param districtId ID của Quận/Huyện
     * @return ResponseEntity với danh sách Phường/Xã
     */
    @GetMapping("/wards/{districtId}")
    public ResponseEntity<String> getWards(@PathVariable int districtId) {
        String url = API_URL + "master-data/ward?district_id=" + districtId;
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY); // Thêm token vào headers

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // Gửi yêu cầu GET để lấy Phường/Xã của Quận/Huyện
        return restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
    }

    /**
     * Tính phí vận chuyển giữa 2 quận/huyện
     * @param request Chi tiết yêu cầu tính phí vận chuyển
     * @return ResponseEntity với phí vận chuyển
     */
    @PostMapping("/shipping-cost")
    public ResponseEntity<String> calculateShippingCost(@RequestBody ShippingRequest request) {
        String url = API_URL + "v2/shipping-order/fee";
        HttpHeaders headers = new HttpHeaders();
        headers.set("token", API_KEY); // Thêm token vào headers
        headers.set("shop_id", "YOUR_SHOP_ID"); // Thay bằng Shop ID của bạn

        // Tạo dữ liệu yêu cầu gửi đi
        String requestBody = createShippingRequestBody(request);
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        // Gửi yêu cầu POST để tính phí vận chuyển
        return restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
    }

    /**
     * Tạo thân dữ liệu yêu cầu tính phí vận chuyển
     * @param request Thông tin yêu cầu tính phí
     * @return Dữ liệu request dưới dạng JSON
     */
    private String createShippingRequestBody(ShippingRequest request) {
        return "{"
                + "\"service_id\":" + request.getServiceId() + ","
                + "\"insurance_value\":" + request.getInsuranceValue() + ","
                + "\"coupon\":\"" + request.getCoupon() + "\","
                + "\"from_district_id\":" + request.getFromDistrictId() + ","
                + "\"to_district_id\":" + request.getToDistrictId() + ","
                + "\"to_ward_code\":\"" + request.getToWardCode() + "\","
                + "\"height\":" + request.getHeight() + ","
                + "\"length\":" + request.getLength() + ","
                + "\"weight\":" + request.getWeight() + ","
                + "\"width\":" + request.getWidth()
                + "}";
    }
    @Autowired
    private GHNService ghnService;

    // Tạo đơn hàng vận chuyển
    @PostMapping("/create-order")
    public ResponseEntity<String> createShippingOrder(@RequestBody OrderRequest orderRequest) {
        return ghnService.createShippingOrder(orderRequest);
    }
    @GetMapping("/api/ghn/calculate-fee")
    @ResponseBody
    public ResponseEntity<Integer> calculateShippingFee(
            @RequestParam("soLuong") int soLuong,
            @RequestParam("districtId") int districtId,
            @RequestParam("wardCode") String wardCode,
            @RequestParam("tongTien") int tongTien
    ) {
        int phiShip = ghnService.tinhTienShipTheoSoLuong(soLuong, districtId, wardCode, tongTien);
        return ResponseEntity.ok(phiShip);
    }

}
