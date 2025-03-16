<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website của tôi</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        .navbar {
            margin-bottom: 20px;
        }
        .cart-icon {
            position: relative;
        }
        .cart-count {
            position: absolute;
            top: -5px;
            right: -10px;
            background-color: red;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 50%;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <!-- Logo / Trang chủ -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">Trang Chủ</a>

        <!-- Nút toggle khi màn hình hẹp -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Danh sách link chính -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham/list">
                        🛍️ Sản Phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                        ℹ️ Giới Thiệu
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        📞 Liên Hệ
                    </a>
                </li>

                <!-- Dropdown Danh Mục -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        📂 Danh Mục
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <c:forEach var="category" items="${danhmuc}">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/sanpham?danhMucID=${category.id}">
                                        ${category.tenDanhMuc}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>

            <!-- Giỏ hàng -->
            <a href="${pageContext.request.contextPath}/cart" class="nav-link cart-icon position-relative me-3">
                🛒 Giỏ hàng
                <c:if test="${not empty sessionScope.gioHangList}">
                    <span class="cart-count">${sessionScope.gioHangList.size()}</span>
                </c:if>
            </a>

            <!-- Đăng nhập / Đăng xuất -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                👤 ${sessionScope.user.hoTen}
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/info">
                                        🔍 Thông tin cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        🚪 Đăng Xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                🔑 Đăng Nhập
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

        </div> <!-- end .collapse -->
    </div> <!-- end .container-fluid -->
</nav>

<!-- Bootstrap 5 Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
