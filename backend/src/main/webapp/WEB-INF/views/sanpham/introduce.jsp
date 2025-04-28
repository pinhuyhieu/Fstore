<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Giới thiệu - Fstore</title>
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

        .intro-banner {
            background:
                    linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
                    url("${pageContext.request.contextPath}/images/banner.jpg") no-repeat center center/cover;
            height: 450px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            width: 100%;
        }

        .intro-content {
            text-align: center;
            padding: 40px;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 20px;
        }

        .intro-content h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .intro-content p {
            font-size: 1.4rem;
        }

        .about-section {
            padding: 80px 0;
            background: #ffffff;
        }

        .about-section h2 {
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2.5rem;
            color: #0d6efd;
        }

        .about-section p {
            font-size: 1.2rem;
            line-height: 1.8;
            color: #555;
        }

        .core-values {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            color: white;
            padding: 60px 30px;
            border-radius: 20px;
            margin-top: 50px;
        }

        .core-values h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .core-values p {
            font-size: 1.3rem;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 12px 30px;
            font-size: 1.1rem;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<!-- Banner giới thiệu -->
<div class="intro-banner">
    <div class="intro-content" data-aos="fade-up">
        <h1>Giới thiệu về Fstore</h1>
        <p>Phong cách thời trang đỉnh cao - Nơi phong cách cá tính được khai phóng</p>
    </div>
</div>

<!-- Nội dung giới thiệu -->
<div class="container about-section">
    <div class="row align-items-center">
        <div class="col-md-6" data-aos="fade-right">
            <h2>Fstore - Thương hiệu của sự khác biệt</h2>
            <p>Fstore là trang web thương mại điện tử chuyên cung cấp các sản phẩm quần áo thời trang dành cho giới trẻ.
                Chúng tôi mang đến những sản phẩm chất lượng cao, thiết kế hiện đại và giá cả hợp lý nhằm đáp ứng nhu cầu ngày càng cao của khách hàng.</p>
            <p>Với đội ngũ nhân viên chuyên nghiệp và nhiệt huyết, Fstore cam kết mang lại trải nghiệm mua sắm online tuyệt vời, an toàn và tiện lợi nhất cho khách hàng trên toàn quốc.</p>
        </div>
        <div class="col-md-6" data-aos="fade-left">
            <img src="${pageContext.request.contextPath}/images/about-us.jpg" alt="Giới thiệu Fstore" class="img-fluid rounded shadow-lg">
        </div>
    </div>

    <div class="row justify-content-center mt-5">
        <div class="col-md-10 text-center core-values" data-aos="zoom-in">
            <h2>Giá trị cốt lõi của chúng tôi</h2>
            <p><b>Chất lượng</b> - <b>Uy tín</b> - <b>Đổi mới</b> - <b>Khách hàng là trung tâm</b></p>
            <p>Fstore không ngừng nỗ lực để trở thành sự lựa chọn số một của bạn trong hành trình tìm kiếm phong cách thời trang riêng biệt.</p>
            <a href="${pageContext.request.contextPath}/sanpham/list" class="btn btn-primary mt-3">Khám phá sản phẩm</a>
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
        duration: 1000, // Animation time (ms)
        once: true,     // Chỉ chạy 1 lần
    });
</script>
</body>
</html>
