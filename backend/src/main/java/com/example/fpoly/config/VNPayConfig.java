package com.example.fpoly.config;

import com.example.fpoly.util.VNPayUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Component
public class VNPayConfig {


    @Value("${vnpay.tmnCode}")
    private String vnp_TmnCode;

    @Value("${vnpay.hashSecret}")
    private String vnp_HashSecret;

    @Value("${vnpay.returnUrl}")
    private String vnp_ReturnUrl;

    @Value("${vnpay.payUrl}")
    private String vnp_PayUrl;

    /**
     * Tạo URL redirect đến VNPay (sử dụng để thanh toán)
     */
    public String createPaymentUrl(long amount, String orderInfo, String orderId) throws Exception {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        String vnp_CurrCode = "VND";
        String vnp_Locale = "vn";
        String vnp_IpAddr = "127.0.0.1";
        String vnp_CreateDate = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        Map<String, String> vnp_Params = new TreeMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount)); // ✅ nhân 100
        vnp_Params.put("vnp_CurrCode", vnp_CurrCode);
        vnp_Params.put("vnp_TxnRef", orderId);
        vnp_Params.put("vnp_OrderInfo", orderInfo);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", vnp_Locale);
        vnp_Params.put("vnp_ReturnUrl", vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);


        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            if (value != null && !value.isEmpty()) {
                // ✅ URL encode cho cả hashData và query
                String encodedValue = URLEncoder.encode(value, StandardCharsets.US_ASCII.toString());
                hashData.append(key).append('=')
                        .append(URLEncoder.encode(value, StandardCharsets.US_ASCII.toString()))
                        .append('&'); // ✅ hoặc dùng UTF-8 nếu cần

                query.append(key).append('=').append(encodedValue).append('&');
            }
        }

        // ✅ Xoá dấu & cuối
        hashData.setLength(hashData.length() - 1);
        query.setLength(query.length() - 1);

        // ✅ Tạo secure hash
        String secureHash = VNPayUtils.hmacSHA512(vnp_HashSecret, hashData.toString());
        query.append("&vnp_SecureHash=").append(secureHash);

        return vnp_PayUrl + "?" + query.toString();
    }

    /**
     * Kiểm tra chữ ký trả về từ VNPay có hợp lệ không
     */
    public boolean isValidSignature(Map<String, String> vnpParams) {
        String receivedHash = vnpParams.get("vnp_SecureHash");
        vnpParams.remove("vnp_SecureHash");
        vnpParams.remove("vnp_SecureHashType");

        List<String> sortedKeys = new ArrayList<>(vnpParams.keySet());
        Collections.sort(sortedKeys);

        StringBuilder hashData = new StringBuilder();
        for (String key : sortedKeys) {
            String value = vnpParams.get(key);
            if (value != null && !value.isEmpty()) {
                hashData.append(key).append("=")
                        .append(URLEncoder.encode(value, StandardCharsets.US_ASCII))
                        .append("&");
            }
        }

        if (hashData.length() > 0) {
            hashData.setLength(hashData.length() - 1); // remove last &
        }

        String calculatedHash = VNPayUtils.hmacSHA512(vnp_HashSecret, hashData.toString());

        System.out.println("🔐 Chuỗi hashData = " + hashData.toString());
        System.out.println("🔐 VNPay gửi: " + receivedHash);
        System.out.println("🔐 Tự tính lại: " + calculatedHash);

        return calculatedHash.equalsIgnoreCase(receivedHash);
    }


}
