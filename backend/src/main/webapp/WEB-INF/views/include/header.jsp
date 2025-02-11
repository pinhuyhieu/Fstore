<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
    </style>
</head>
<body>

<!-- Thanh Navbar -->
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
            <ul class="navbar-nav">
                <!-- Link Sản Phẩm -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/sanpham">
                        Sản Phẩm
                    </a>
                </li>
                <!-- Link Giới Thiệu -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                        Giới Thiệu
                    </a>
                </li>
                <!-- Link Liên Hệ -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        Liên Hệ
                    </a>
                </li>

                <!-- Dropdown Danh Mục -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Danh Mục
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <c:forEach var="category" items="${danhmuc}">
                            <li>
                                <!-- Giả sử ta muốn khi click danh mục sẽ lọc sp theo ID -->
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/sanpham?danhMucID=${category.id}">
                                        ${category.tenDanhMuc}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
        </div> <!-- end .collapse -->
    </div> <!-- end .container-fluid -->
</nav>

<!-- Script Bootstrap 5 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>
