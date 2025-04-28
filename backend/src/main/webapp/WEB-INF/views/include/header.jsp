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
            margin-bottom: 15px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .left{
            justify-content: center; /* Căn giữa các mục trong navbar */
        }

        .navbar-nav {
            display: flex;
            /*justify-content: center; !* Căn giữa các mục trong navbar *!*/
            /*flex-grow: 1; !* Làm cho phần navbar nav chiếm không gian còn lại *!*/
        }

        .navbar-nav .nav-link {
            color: #000 !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #007bff !important;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #000 !important;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover {
            color: #007bff !important;
        }

        .cart-icon {
            position: relative;
            color: #000;
        }

        .cart-icon:hover {
            color: #007bff;
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

        .navbar-toggler-icon {
            background-color: #000;
        }

        .dropdown-menu {
            background-color: #fff;
        }

        .dropdown-item {
            color: #000 !important;
            transition: background-color 0.3s ease;
        }

        .dropdown-item:hover {
            background-color: #007bff !important;
            color: #fff !important;
        }

        .navbar-collapse {
            display: flex;
            justify-content: space-between; /* Căn giữa navbar thành 2 phần */
        }

        /* Điều chỉnh khi màn hình nhỏ */
        @media (max-width: 767px) {
            .navbar-nav {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <!-- Logo / Trang chủ -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/sanpham/index">Trang Chủ</a>

        <!-- Nút toggle khi màn hình hẹp lại -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Danh sách link chính (Bên phải) -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="left">
            <ul class="navbar-nav ms-auto"> <!-- Căn phải cho phần link chính -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham/list">
                        🛍️ Sản Phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham/introduce">
                        ℹ️ Giới Thiệu
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham/contact">
                        📞 Liên Hệ
                    </a>
                </li>
            </ul>
            </div>
            <!-- Giỏ hàng và Đăng nhập/Đăng xuất (Bên trái) -->
            <ul class="navbar-nav"> <!-- Không cần thêm ms-auto, nó sẽ tự động căn trái -->
                <a href="${pageContext.request.contextPath}/api/cart" class="nav-link cart-icon position-relative me-3">
                    🛒 Giỏ hàng
                    <c:if test="${not empty sessionScope.gioHangList}">
                        <span class="cart-count">${sessionScope.gioHangList.size()}</span>
                    </c:if>
                </a>

                <!-- Đăng nhập / Đăng xuất -->
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
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/api/donhang/danh-sach">
                                        Lịch sử mua hàng
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
