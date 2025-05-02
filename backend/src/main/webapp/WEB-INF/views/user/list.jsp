<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>

<html>
<head>
    <title>Danh sách Người dùng</title>
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- AOS (Animate On Scroll) -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background-color: #f1f4f9;
            font-family: "Segoe UI", sans-serif;
        }
        .container {
            max-width: 1000px;
            margin-top: 40px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.01);
            box-shadow: 0 0 30px rgba(0,0,0,0.08);
        }
        .alert {
            transition: all 0.5s ease-in-out;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4 fw-bold" data-aos="fade-down">Danh sách Người dùng</h2>

    <!-- Thông báo -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="fade-right">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="fade-left">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary" data-aos="fade-right">
        <i class="bi bi-house-door-fill"></i> Trang chủ
    </a> <br> <br>

    <!-- Bảng người dùng -->
    <div class="card p-4" data-aos="zoom-in">
        <h4 class="fw-bold mb-3">Thông tin người dùng</h4>
        <table class="table table-hover table-bordered align-middle" data-aos="fade-up" data-aos-delay="100">
            <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Chỉnh sửa</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}" varStatus="loop">
                <tr class="text-center" data-aos="fade-up" data-aos-delay="${loop.index * 50}">
                    <td>${user.id}</td>
                    <td>${user.hoTen}</td>
                    <td>${user.email}</td>
                    <td>
                        <c:forEach var="role" items="${user.roles}">
                            <span class="badge bg-secondary">${role.tenVaiTro}</span><br/>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/edit-roles/${user.id}" class="btn btn-warning btn-sm" title="Chỉnh sửa vai trò">
                            <i class="bi bi-pencil-square"></i> Sửa
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true
    });
</script>

</body>
</html>
