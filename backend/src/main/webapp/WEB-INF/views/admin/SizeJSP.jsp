<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Quản Lý Size</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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

<div class="container">
    <h2 class="text-center mb-4 fw-bold">Quản Lý Size</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Form Thêm/Sửa Size -->
    <div class="card p-4 mb-4">
        <form method="POST" action="${pageContext.request.contextPath}/admin/size/save" class="needs-validation" novalidate>
            <input type="hidden" name="id" value="${size.id}" />

            <div class="mb-3">
                <label for="tenSize" class="form-label">Tên Size:</label>
                <input type="text" class="form-control" id="tenSize" name="tenSize"
                       value="${size.tenSize}" required minlength="1" maxlength="5"
                       pattern="^[a-zA-ZÀ-ỹ0-9 ]+$" oninput="validateInput()"
                       placeholder="Nhập tên size">
                <div class="invalid-feedback">Tên size không được để trống và không chứa ký tự đặc biệt.</div>
            </div>

            <button type="submit" class="btn btn-success me-2">
                <i class="bi bi-save"></i>
                <c:choose>
                    <c:when test="${empty size.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/admin/size/list" class="btn btn-secondary me-2">
                <i class="bi bi-arrow-counterclockwise"></i> Hủy
            </a>
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary">
                <i class="bi bi-house-door-fill"></i> Trang chủ
            </a>
        </form>
    </div>

    <!-- Bảng Danh Sách Size -->
    <div class="card p-4">
        <h4 class="fw-bold mb-3">Danh Sách Size</h4>
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Tên Size</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="s" items="${sizes}">
                <tr class="text-center">
                    <td>${s.id}</td>
                    <td>${s.tenSize}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/size/edit/${s.id}" class="btn btn-warning btn-sm me-1" title="Sửa">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/size/delete/${s.id}"
                           class="btn btn-danger btn-sm"
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

<script>
    function validateInput() {
        let input = document.getElementById("tenSize");
        let regex = /^[a-zA-ZÀ-ỹ ]+$/;  // Chỉ cho phép chữ cái và khoảng trắng
        if (!regex.test(input.value)) {
            input.setCustomValidity("Tên size không được chứa ký tự đặc biệt.");
        } else {
            input.setCustomValidity("");
        }
    }

    // Bootstrap form validation
    (() => {
        'use strict';
        window.addEventListener('load', () => {
            const forms = document.getElementsByClassName('needs-validation');
            Array.prototype.forEach.call(forms, form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                        document.getElementById("tenSize").focus();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
