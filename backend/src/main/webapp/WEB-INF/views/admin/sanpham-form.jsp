<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f1f4f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 900px;
            margin-top: 40px;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.07);
        }
        .form-label {
            font-weight: 600;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .btn {
            font-size: 15px;
            margin: 5px 3px;
        }
        .btn i {
            margin-right: 4px;
        }
        .alert {
            font-size: 15px;
        }
        .form-title {
            font-weight: bold;
            color: #0d6efd;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center form-title mb-4"><i class="bi bi-box-seam-fill"></i> Quản Lý Sản Phẩm</h2>

    <!-- Thông báo thành công/thất bại -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <!-- Form Thêm hoặc Cập Nhật -->
    <form id="sanphamForm" action="${pageContext.request.contextPath}/sanpham/admin/add" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="id" value="${sanPham.id}" />

        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" name="tenSanPham" class="form-control" placeholder="Nhập tên sản phẩm"
                   value="${sanPham.tenSanPham}" required minlength="3" maxlength="50"
                   pattern="^[a-zA-Z0-9\sÀ-ỹ]+$">
            <div class="invalid-feedback">Tên sản phẩm từ 3–50 ký tự, không chứa ký tự đặc biệt.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="moTa" class="form-control" rows="3" placeholder="Nhập mô tả sản phẩm" required>${sanPham.moTa}</textarea>
            <div class="invalid-feedback">Mô tả không được để trống.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select name="danhMuc" class="form-select" required>
                <c:forEach items="${listDanhMuc}" var="item">
                    <option value="${item.id}" ${item.id == sanPham.danhMuc.id ? 'selected' : ''}>
                            ${item.tenDanhMuc}
                    </option>
                </c:forEach>
            </select>
            <div class="invalid-feedback">Vui lòng chọn danh mục.</div>
        </div>

        <div class="text-center mt-4">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-save-fill"></i>
                <c:choose>
                    <c:when test="${empty sanPham.id}">Thêm sản phẩm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="btn btn-secondary">
                <i class="bi bi-arrow-repeat"></i> Hủy
            </a>
        </div>
    </form>

    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary">
            <i class="bi bi-house-door-fill"></i> Trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/sanpham/admin/list" class="btn btn-primary">
            <i class="bi bi-card-list"></i> Danh sách sản phẩm
        </a>
    </div>
</div>

<!-- JavaScript -->
<script>
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
