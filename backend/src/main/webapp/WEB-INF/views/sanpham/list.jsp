<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty errorMessage}">
    <script>
        alert("${errorMessage}");
    </script>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm - Fstore</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Thêm AOS CSS -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }


        .search-bar input {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-bar .btn-tim {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-bar .btn-tim:hover {
            background-color: #0056b3;
        }

        .container {
            flex: 1;
        }

        .product-card {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            cursor: pointer;
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


        .range-input input {
            width: 45%;
            padding: 5px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .range-input span {
            font-weight: bold;
        }

        .list-group-item-action:hover {
            background-color: #dfe6e9;
            color: #0984e3;
        }

        .list-group-item-action {
            border: none;
            transition: background-color 0.3s ease;
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

        html {
            scroll-behavior: smooth;
        }

        .btn-back {
            display: inline-block;
            background: linear-gradient(135deg, #4d9fef, #007bff);
            color: #fff;
            border: none;
            padding: 11px 18px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 10px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: linear-gradient(135deg, #007bff, #0056b3);
            box-shadow: 0 6px 18px rgba(0, 123, 255, 0.35);
            transform: translateY(-2px);
            color: #fff;
            text-decoration: none;
        }

        .btn-back:active {
            transform: scale(0.98);
            box-shadow: 0 3px 10px rgba(0, 123, 255, 0.3);
        }

        .search-input {
            padding: 10px 16px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            width: 250px;
            margin-right: 10px;
        }

        .search-input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }
    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-lg-3">
            <div class="sidebar" data-aos="fade-right">
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
            <div class="header-container d-flex align-items-center justify-content-between" data-aos="fade-up">
                <h1 class="mb-4">Danh sách sản phẩm</h1>
                <form action="${pageContext.request.contextPath}/sanpham/list/search" method="GET" class="d-flex mb-3">
                    <input type="text" name="name" class="search-input"
                           style="width: 200px; height: 35px; font-size: 14px;"
                           placeholder="Nhập tên sản phẩm..." value="${param.name}">
                    <button type="submit" class="btn btn-back" style="color: white">Tìm</button>
                </form>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="row" style="margin-top: 20px">
                <c:forEach var="sp" items="${dsSanPham}">
                    <div class="col-md-4 mb-4" data-aos="zoom-in">
                        <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/sanpham/detail/${sp.id}'">
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
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Thanh phân trang -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/sanpham/list?page=${currentPage - 1}">Trước</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/sanpham/list?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/sanpham/list?page=${currentPage + 1}">Tiếp</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<!-- Thêm AOS JS -->
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1200,
        easing: 'ease-in-out',
        once: true
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
