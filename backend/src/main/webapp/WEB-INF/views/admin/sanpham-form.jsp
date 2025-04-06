<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 900px;
            margin-top: 40px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn {
            margin: 3px;
            font-size: 14px;
        }
        .btn:hover {
            opacity: 0.85;
        }
        .form-label {
            font-weight: bold;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
    </style>

</head>
<body>

<div class="container">
    <h2 class="text-center text-primary mb-4">Quản Lý Sản Phẩm</h2>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <!-- Form Thêm hoặc Cập Nhật -->
    <form id="sanphamForm" action="${pageContext.request.contextPath}/sanpham/admin/add" method="post" class="p-3 border rounded bg-light needs-validation" novalidate>
        <input type="hidden" name="id" value="${sanPham.id}" />

        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" name="tenSanPham" class="form-control" placeholder="Nhập tên sản phẩm" value="${sanPham.tenSanPham}" required>
            <div class="invalid-feedback">Tên sản phẩm không được để trống.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="moTa" class="form-control" rows="2" placeholder="Nhập mô tả sản phẩm" required>${sanPham.moTa}</textarea>
            <div class="invalid-feedback">Mô tả không được để trống.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select name="danhMuc" class="form-select">
                <c:forEach items="${listDanhMuc}" var="item">
                    <option value="${item.id}" ${item.id == sanPham.danhMuc.id ? 'selected' : ''}>${item.tenDanhMuc}</option>
                </c:forEach>
            </select>
            <div class="invalid-feedback">Vui lòng chọn danh mục.</div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-success btn-lg">
                <c:choose>
                    <c:when test="${empty sanPham.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="btn btn-secondary btn-lg">Hủy</a>
        </div>
    </form>
    <div style="text-align: center; margin-top: 10px">
        <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary btn-lg">Quay lại trang chủ</a>
        <a href="${pageContext.request.contextPath}/sanpham/admin/list" class="btn btn-primary btn-lg">Xem danh sách sản phẩm</a>
    </div>
</div>
<script>
    // (function() {
    //     'use strict';
    //     var forms = document.querySelectorAll('.needs-validation');
    //     Array.prototype.slice.call(forms).forEach(function(form) {
    //         form.addEventListener('submit', function(event) {
    //             if (!form.checkValidity()) {
    //                 event.preventDefault();
    //                 event.stopPropagation();
    //             }
    //             form.classList.add('was-validated');
    //         }, false);
    //     });
    // })();
    document.addEventListener("DOMContentLoaded", function () {
        var form = document.getElementById("sanphamForm");
        var tenSanPhamInput = form.querySelector("input[name='tenSanPham']");

        form.addEventListener("submit", function (event) {
            var tenSanPham = tenSanPhamInput.value.trim();
            var regex = /^[a-zA-Z0-9\sÀ-ỹ]+$/;

            if (tenSanPham.length < 3 || tenSanPham.length > 50) {
                alert("Tên sản phẩm phải từ 3 đến 50 ký tự.");
                event.preventDefault();
                return;
            }

            if (!regex.test(tenSanPham)) {
                alert("Tên sản phẩm không được chứa ký tự đặc biệt.");
                event.preventDefault();
            }
        });
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
