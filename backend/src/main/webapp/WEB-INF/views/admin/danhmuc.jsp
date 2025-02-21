<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>Quản lý Danh Mục</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 30px;
        }
        .table th, .table td {
            text-align: center;
        }
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center text-primary mb-4">Thêm Danh Mục</h2>

    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-container">
                <form action="/danh-muc/admin/add" method="post">
                    <div class="mb-3">
                        <label class="form-label">Tên danh mục:</label>
                        <input type="text" name="tenDanhMuc" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả:</label>
                        <input type="text" name="moTa" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Thêm mới</button>
                </form>
            </div>
        </div>
    </div>

    <h2 class="text-center text-success mt-5">Danh Sách Danh Mục</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-striped mt-3">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th>Ngày tạo</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listDanhMuc}" var="item">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.tenDanhMuc}</td>
                    <td>${item.moTa}</td>
                    <td>${item.ngayTao}</td>
                    <td>
                        <a href="/shop/product/update/${item.id}" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="/danh-muc/admin/delete?id=${item.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
