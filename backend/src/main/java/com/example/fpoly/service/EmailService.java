package com.example.fpoly.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOrderConfirmationEmail(String to, String orderId) {
        String subject = "Xác nhận đơn hàng #" + orderId + " - FStore";

        String body = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;'>"
                + "<h2 style='color: #007bff; text-align: center;'>🎉 Cảm ơn bạn đã đặt hàng tại FStore!</h2>"
                + "<p style='font-size: 16px; text-align: center;'>Chúng tôi đã nhận được đơn hàng của bạn và đang xử lý.</p>"
                + "<div style='background: #fff; padding: 15px; border-radius: 8px; margin-top: 20px;'>"
                + "   <p><strong>Mã đơn hàng:</strong> <span style='color: #007bff;'>" + orderId + "</span></p>"
                + "   <p><strong>Ngày đặt hàng:</strong> " + LocalDate.now() + "</p>"
                + "   <p><strong>Trạng thái:</strong> Đang xử lý</p>"
                + "</div>"
                + "<p style='margin-top: 20px;'>Bạn có thể theo dõi đơn hàng của mình bằng cách <a href='https://fstore.com/don-hang/" + orderId + "' style='color: #007bff;'>bấm vào đây</a>.</p>"
                + "<p style='text-align: center; margin-top: 20px;'><strong>FStore - Mua sắm dễ dàng, nhận hàng nhanh chóng!</strong></p>"
                + "</div>";


        sendEmail(to, subject, body);
    }

    public void sendOrderStatusUpdateEmail(String to, String orderId, String status) {
        String subject = "Cập nhật trạng thái đơn hàng #" + orderId;
        String body = "<h2>🔔 Đơn hàng của bạn đã được cập nhật!</h2>"
                + "<p>Mã đơn hàng: <strong>" + orderId + "</strong></p>"
                + "<p>Trạng thái mới: <strong>" + status + "</strong></p>";

        sendEmail(to, subject, body);
    }

    private void sendEmail(String to, String subject, String body) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(body, true); // true để gửi HTML
            mailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("❌ Lỗi gửi email: " + e.getMessage());
        }
    }
}