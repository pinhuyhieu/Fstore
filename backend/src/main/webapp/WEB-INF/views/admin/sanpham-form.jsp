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
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin-top: 30px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
        }
        .btn-custom {
            margin: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center text-primary">Thêm Sản Phẩm</h2>
    <form action="/sanpham/admin/add" method="post" class="p-3 border rounded bg-light">
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" name="tenSanPham" class="form-control" placeholder="Nhập tên sản phẩm">
        </div>
        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <input type="text" name="moTa" class="form-control" placeholder="Nhập mô tả">
        </div>
        <div class="mb-3">
            <label class="form-label">Giá bán</label>
            <input type="number" name="giaBan" class="form-control" placeholder="Nhập giá bán">
        </div>
        <div class="mb-3">
            <label class="form-label">Danh mục</label>
            <select name="danhMuc" class="form-select">
                <c:forEach items="${listDanhMuc}" var="item">
                    <option value="${item.id}">${item.tenDanhMuc}</option>
                </c:forEach>
            </select>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-success btn-custom">Thêm Sản Phẩm</button>
        </div>
    </form>

    <h2 class="text-center text-primary mt-4">Danh Sách Sản Phẩm</h2>
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Mô tả</th>
            <th>Giá bán</th>
            <th>Danh mục</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${dsSanPham}" var="item">
            <tr>
                <td>${item.id}</td>
                <td>${item.tenSanPham}</td>
                <td>${item.moTa}</td>
                <td>${item.giaBan}</td>
                <td>${item.danhMuc.tenDanhMuc}</td>
                <td>
                    <a href="/sanphamchitiet/add/${item.id}" class="btn btn-warning btn-sm btn-custom">Sửa chi tiết</a>
                    <a href="/sanpham/admin/delete?id=${item.id}" class="btn btn-danger btn-sm btn-custom">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
