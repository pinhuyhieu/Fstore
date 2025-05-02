<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Quản Lý Danh Mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet"> <!-- ✅ AOS CSS -->

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
        .form-label {
            font-weight: 600;
        }
        .btn i {
            margin-right: 4px;
        }
        .table th, .table td {
            vertical-align: middle;
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

<div class="container" data-aos="fade-in">
    <h2 class="text-center mb-4 fw-bold" data-aos="zoom-in">Quản Lý Danh Mục</h2>

    <!-- Thông báo -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="fade-down">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="fade-down">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Form -->
    <div class="card p-4 mb-4" data-aos="fade-up" data-aos-duration="600">
        <form method="POST" action="${pageContext.request.contextPath}/admin/danhmuc/save" class="needs-validation" novalidate>
            <input type="hidden" name="id" value="${danhmuc.id}" />

            <div class="mb-3">
                <label for="tenDanhMuc" class="form-label">Tên Danh Mục:</label>
                <input type="text" class="form-control" id="tenDanhMuc" name="tenDanhMuc"
                       value="${danhmuc.tenDanhMuc}" required minlength="2" maxlength="30"
                       pattern="^[a-zA-ZÀ-ỹ0-9 ]+$" oninput="validateInput()"
                       placeholder="Nhập tên danh mục">
                <div class="invalid-feedback">Tên danh mục không được để trống và không chứa kí từ đặc biệt.</div>
            </div>

            <button type="submit" class="btn btn-success me-2">
                <i class="bi bi-save"></i>
                <c:choose>
                    <c:when test="${empty danhmuc.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/admin/danhmuc/list" class="btn btn-secondary me-2">
                <i class="bi bi-arrow-counterclockwise"></i> Hủy
            </a>
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary">
                <i class="bi bi-house-door-fill"></i> Trang chủ
            </a>
        </form>
    </div>

    <!-- Bảng danh sách -->
    <div class="card p-4" data-aos="fade-up" data-aos-duration="600">
        <h4 class="fw-bold mb-3">Danh Sách Danh Mục</h4>
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Tên Danh Mục</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="d" items="${danhmucs}" varStatus="loop">
                <tr class="text-center" data-aos="fade-up" data-aos-delay="${loop.index * 100}">
                    <td>${d.id}</td>
                    <td>${d.tenDanhMuc}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/danhmuc/edit/${d.id}" class="btn btn-warning btn-sm me-1" title="Sửa">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/danhmuc/delete/${d.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa?');" title="Xóa">
                            <i class="bi bi-trash-fill"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Script -->
<script>
    function validateInput() {
        let input = document.getElementById("tenDanhMuc");
        let regex = /^[a-zA-ZÀ-ỹ ]+$/;
        if (!regex.test(input.value)) {
            input.setCustomValidity("Tên danh mục không được chứa số và ký tự đặc biệt.");
        } else {
            input.setCustomValidity("");
        }
    }

    // Bootstrap validation
    (() => {
        'use strict';
        window.addEventListener('load', () => {
            const forms = document.getElementsByClassName('needs-validation');
            Array.prototype.forEach.call(forms, form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                        document.getElementById("tenDanhMuc").focus();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script> <!-- ✅ AOS Script -->
<script>
    AOS.init({
        duration: 1000, // Thời gian hiệu ứng (ms)
        easing: 'ease-in-out',
        once: true // Chỉ chạy 1 lần khi cuộn
    });
</script>

</body>
</html>
