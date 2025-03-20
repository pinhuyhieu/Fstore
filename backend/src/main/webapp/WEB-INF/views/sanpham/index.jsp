<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm - Fstore</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            margin: 0;
            padding: 0;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the body takes at least the full height of the viewport */
        }
        .banner {
            background-image: linear-gradient(transparent, rgba(0, 0, 0, 0.3)),
            url("${pageContext.request.contextPath}/images/banner.jpg"),
            linear-gradient(rgba(0, 0, 0, 0.3), transparent);
            background-size: cover;
            background-position: center;
            height: 485px;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            margin-top: -0.5rem;
            width: 100%;
            overflow: visible;
        }


        .banner-content {
            text-align: center;
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
        }

        .banner h1 {
            font-size: 3rem;
            font-weight: bold;
        }

        .banner p {
            font-size: 1.5rem;
        }

        .banner img {
            width: 100%;
            height: auto; /* Giữ nguyên tỷ lệ ảnh */
        }

        .btn-primary {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .service-section, .product-section {
            padding: 40px 0;
        }

        .service-item img {
            width: 80px;
            margin-bottom: 10px;
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .product-card {
            background-color: #fff;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<!-- Banner -->
<div class="banner">
    <div class="banner-content">
        <h1>Welcome to Fstore</h1>
        <p>The best fashion store for you</p>
        <a href="/sanpham/list" class="btn btn-primary">Shop Now</a>
    </div>
</div>

<!-- Service Section -->
<div class="container service-section text-center">
    <h2 class="mb-4">Service by Fstore</h2>
    <div class="row">
        <div class="col-md-4 service-item">
            <img src="https://via.placeholder.com/80" alt="Free Shipping">
            <h4>Free Shipping</h4>
            <p>Free shipping nationwide on orders over 1,500,000₫</p>
        </div>
        <div class="col-md-4 service-item">
            <img src="https://via.placeholder.com/80" alt="Genuine Products">
            <h4>Genuine Products</h4>
            <p>6-month warranty for all products</p>
        </div>
        <div class="col-md-4 service-item">
            <img src="https://via.placeholder.com/80" alt="Free Cleaning">
            <h4>Free Cleaning</h4>
            <p>Free shoe cleaning within the first 3 months</p>
        </div>
    </div>
</div>

<!-- Best Sellers Section -->
<div class="container product-section" id="products">
    <h2 class="text-center mb-4">Best Sellers</h2>
    <div class="row">
        <c:forEach var="sp" items="${dsSanPham}">
            <div class="col-md-3">
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/${sp.hinhAnhs[0].duongDan}" alt="${sp.tenSanPham}">
                    <h5>${sp.tenSanPham}</h5>
                    <p>Giá: <b>${sp.giaBan} ₫</b></p>
                    <a href="${pageContext.request.contextPath}/sanpham/detail/${sp.id}" class="btn btn-primary">Xem chi tiết</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
