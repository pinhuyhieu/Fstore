<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Liên hệ - Fstore</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- AOS CSS (Animation on Scroll) -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background: #f2f6fc;
            margin: 0;
            padding: 0;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .contact-banner {
            background:
                    linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
                    url("${pageContext.request.contextPath}/images/banner.jpg") no-repeat center center/cover;
            height: 450px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            position: relative;
        }

        .contact-content {
            text-align: center;
            padding: 40px;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 20px;
        }

        .contact-content h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .contact-content p {
            font-size: 1.4rem;
        }

        .contact-section {
            padding: 80px 0;
            background: #ffffff;
        }

        .contact-section h2 {
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2.2rem;
            color: #0d6efd;
        }

        .contact-section p {
            font-size: 1.1rem;
            line-height: 1.7;
            color: #555;
        }

        .form-control, .btn-primary {
            border-radius: 10px;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 12px 30px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<!-- Banner liên hệ -->
<div class="contact-banner">
    <div class="contact-content" data-aos="fade-up">
        <h1>Liên hệ với Fstore</h1>
        <p>Chúng tôi luôn sẵn sàng lắng nghe bạn</p>
    </div>
</div>

<!-- Nội dung liên hệ -->
<div class="container contact-section">
    <div class="row g-5">
        <div class="col-md-6" data-aos="fade-right">
            <h2>Thông tin liên hệ</h2>
            <p><strong>Địa chỉ:</strong> 123 Đường Thời Trang, Quận 1, TP.HCM</p>
            <p><strong>Hotline:</strong> 0123 456 789</p>
            <p><strong>Email:</strong> support@fstore.vn</p>
            <p><strong>Giờ làm việc:</strong> 9:00 - 18:00 (Thứ 2 - Thứ 7)</p>
        </div>
        <div class="col-md-6" data-aos="fade-left">
            <h2>Gửi tin nhắn cho chúng tôi</h2>
            <form>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Họ và Tên" required>
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" placeholder="Email" required>
                </div>
                <div class="mb-3">
                    <textarea class="form-control" rows="5" placeholder="Nội dung tin nhắn" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100">Gửi tin nhắn</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS JS -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000,
        once: true
    });
</script>
</body>
</html>
