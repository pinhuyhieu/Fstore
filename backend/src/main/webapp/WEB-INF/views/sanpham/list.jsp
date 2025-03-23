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
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the body takes at least the full height of the viewport */
        }

        .container {
            flex: 1; /* Ensure the container takes up available space */
        }

        .product-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-card img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .product-card h5 {
            font-size: 20px;
            font-weight: bold;
        }

        .product-card p {
            font-size: 16px;
            color: #555;
        }

        .btn-action {
            margin: 5px;
            width: 100%;
        }

        /* Sidebar cải tiến */
        .sidebar {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 20px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .sidebar h4 {
            font-size: 24px;
            font-weight: bold;
            color: #0984e3;
            text-align: center;
        }

        .list-group-item-action:hover {
            background-color: #dfe6e9;
            color: #0984e3;
        }

        .list-group-item-action {
            border: none;
            transition: background-color 0.3s ease;
        }

        .sidebar .badge {
            font-size: 14px;
        }

        footer {
            background-color: #f8f9fa;
            line-height: 1.5;
            text-align: center;
            padding: 10px 0;
            font-size: 14px;
            margin-top: 20px;
            width: 100%;
            position: relative;
            bottom: 0;
        }

    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <div class="sidebar">
                <h4>Danh mục sản phẩm</h4>
                <ul class="list-group">
                    <c:forEach var="dm" items="${danhmuc}">
                        <a href="${pageContext.request.contextPath}/sanpham?danhMucID=${dm.id}"
                           class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span>${dm.tenDanhMuc}</span>

                        </a>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <!-- Product list -->
        <div class="col-lg-9">
            <h1 class="mb-4">Danh sách sản phẩm</h1>
            <div class="row">
                <c:forEach var="sp" items="${dsSanPham}">
                    <div class="col-md-4 mb-4">
                        <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/sanpham/detail/${sp.id}'" style="cursor: pointer;">
                        <c:choose>
                                <c:when test="${not empty sp.hinhAnhs}">
                                    <img src="${pageContext.request.contextPath}/${sp.hinhAnhs[0].duongDan}" alt="${sp.tenSanPham}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300" alt="Ảnh mặc định">
                                </c:otherwise>
                            </c:choose>
                            <h5>${sp.tenSanPham}</h5>
                            <p>${giaMap[sp.id]}</p>
<%--                            nút --%>
<%--                            <a class="btn btn-primary btn-action" href="${pageContext.request.contextPath}/sanpham/detail/${sp.id}">Mua ngay</a>--%>
<%--                            <a class="btn btn-secondary btn-action" href="${pageContext.request.contextPath}/sanpham/cart/add/${sp.id}">Thêm vào giỏ</a>--%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
