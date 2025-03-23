package com.example.fpoly.controller;

import com.example.fpoly.util.VNPayUtils;

public class test {
    public static void main(String[] args) {
        String vnp_HashSecret = "257QN8W54L58KZTLLFRGKNV9M4ZACNXF"; // 🔐 Thay bằng secret thực tế từ VNPay

        // 🔐 Đây là chuỗi bạn sẽ ký (lấy từ log "Chuỗi hashData = ...")
        String hashData = "vnp_Amount=100000000&vnp_BankCode=NCB&vnp_BankTranNo=VNP14861759&vnp_CardType=ATM&vnp_OrderInfo=Thanh toán đơn hàng #2030&vnp_PayDate=20250323022606&vnp_ResponseCode=00&vnp_TmnCode=BQ4RRMWD&vnp_TransactionNo=14861759&vnp_TransactionStatus=00&vnp_TxnRef=2030";

        // 🧮 Gọi hàm ký (bạn đã có trong class VNPayUtils)
        String generatedSignature = VNPayUtils.hmacSHA512(vnp_HashSecret, hashData);

        System.out.println("🔑 Generated Signature: " + generatedSignature);

        // Nếu muốn so sánh với cái VNPay gửi lại
        String vnpaySentSignature = "a318f03eba796b368ac53cf4769c83413b6861eccb00b49001d06475c1f289797e9b5c3872f68a0dd5c13efd49f378364e56db917ff962ae90957ad57761f038";
        System.out.println("✅ Match with VNPay: " + generatedSignature.equalsIgnoreCase(vnpaySentSignature));
    }
}
