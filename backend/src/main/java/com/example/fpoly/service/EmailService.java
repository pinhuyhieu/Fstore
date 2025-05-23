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
        String subject = "📦 Đơn hàng #" + orderId + " của bạn đã được cập nhật";

        String body = """
            <div style="font-family: Arial, sans-serif; color: #333;">
                <h2 style="color: #007bff;">🔔 Cập nhật đơn hàng</h2>
                <p>Xin chào quý khách,</p>
                <p>Đơn hàng <strong>#%s</strong> của bạn đã được cập nhật trạng thái.</p>
                <p><strong>Trạng thái mới:</strong> <span style="color: green;">%s</span></p>
                <hr>
                <p>Bạn có thể theo dõi chi tiết đơn hàng tại liên kết sau:</p>
                <p><a href="http://yourdomain.com/api/donhang/chi-tiet/%s" style="color: #007bff;">Xem chi tiết đơn hàng</a></p>
                <br>
                <p>Trân trọng,</p>
                <p><strong>Đội ngũ hỗ trợ khách hàng</strong></p>
            </div>
            """.formatted(orderId, status, orderId);

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