<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Sản phẩm Chi tiết</title>
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
        .btn-custom {
            margin: 3px;
            font-size: 14px;
        }
        .btn-custom:hover {
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
    <h2 class="text-center text-primary mb-4">Danh sách Chi tiết Sản phẩm</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Danh Sách Chi Tiết Sản Phẩm -->
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Màu sắc</th>
            <th>Size</th>
            <th>Giá</th>
            <th>Số lượng tồn</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${chiTietList}" var="item">
            <tr>
                <td>${item.id}</td>
                <td>${item.mauSac.tenMauSac}</td>
                <td>${item.size.tenSize}</td>
                <td><b>${item.gia} VNĐ</b></td>
                <td>${item.soLuongTon}</td>
                <td>
                    <a href="/sanphamchitiet/edit/${item.id}?sanPhamId=${item.sanPham.id}" class="btn btn-warning btn-sm btn-custom">Sửa</a>
                    <a href="/sanphamchitiet/delete/${item.id}" class="btn btn-danger btn-sm btn-custom"
                       onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Form Thêm / Cập Nhật Chi Tiết Sản Phẩm -->
    <h3 class="text-center text-success mt-4">Thêm / Cập nhật Chi tiết Sản phẩm</h3>
    <form action="/sanphamchitiet/save" method="post" class="p-3 border rounded bg-light mt-3">
        <input type="hidden" name="id" value="${id}">
        <input type="hidden" name="sanPhamId" value="${sanPhamId}" />

        <div class="mb-3">
            <label class="form-label">Size:</label>
            <select name="size.id" class="form-select">
                <c:forEach items="${sizeList}" var="size">
                    <option value="${size.id}" ${size.id == sanPhamChiTiet.size.id ? 'selected' : ''}>${size.tenSize}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Màu sắc:</label>
            <select name="mauSac.id" class="form-select">
                <c:forEach items="${mauSacList}" var="mau">
                    <option value="${mau.id}" ${mau.id == sanPhamChiTiet.mauSac.id ? 'selected' : ''}>${mau.tenMauSac}</option>
                </c:forEach>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá:</label>
            <input type="number" name="gia" class="form-control" value="${sanPhamChiTiet.gia}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Số lượng tồn:</label>
            <input type="number" name="soLuongTon" class="form-control" value="${sanPhamChiTiet.soLuongTon}" required />
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-success btn-lg">
                <c:choose>
                    <c:when test="${empty sanPhamChiTiet.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
        </div>
    </form>

    <div class="mt-4 text-center">
        <a href="/sanphamchitiet/add/${sanPhamId}" class="btn btn-primary btn-lg">Thêm Sản phẩm Chi tiết</a>
        <a href="/sanpham/list" class="btn btn-secondary btn-lg">Quay lại danh sách Sản phẩm</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
