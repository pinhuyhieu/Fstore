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

    <!-- Form Thêm hoặc Cập Nhật -->
    <form action="${pageContext.request.contextPath}/sanpham/admin/add" method="post" class="p-3 border rounded bg-light">
        <input type="hidden" name="id" value="${sanPham.id}" />

        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" name="tenSanPham" class="form-control" placeholder="Nhập tên sản phẩm" value="${sanPham.tenSanPham}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="moTa" class="form-control" rows="2" placeholder="Nhập mô tả sản phẩm" required>${sanPham.moTa}</textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select name="danhMuc" class="form-select">
                <c:forEach items="${listDanhMuc}" var="item">
                    <option value="${item.id}" ${item.id == sanPham.danhMuc.id ? 'selected' : ''}>${item.tenDanhMuc}</option>
                </c:forEach>
            </select>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
