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
        .img-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
        }
        .img-container img {
            width: 80px;
            height: auto;
            border: 1px solid #ccc;
            padding: 5px;
            border-radius: 8px;
            transition: transform 0.2s ease-in-out;
        }
        .img-container img:hover {
            transform: scale(1.1);
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

    <!-- Danh Sách Sản Phẩm -->
    <h2 class="text-center text-primary mt-4">Danh Sách Sản Phẩm</h2>
    <table class="table table-bordered table-striped mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Danh mục</th>
            <th>Hình ảnh</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${dsSanPham}" var="item">
            <tr>
                <td>${item.id}</td>
                <td>${item.tenSanPham}</td>
                <td>${item.danhMuc.tenDanhMuc}</td>
                <td>
                    <!-- Form Upload Ảnh -->
                    <form action="${pageContext.request.contextPath}/hinhanh/upload" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="sanPhamId" value="${item.id}">
                        <input type="file" name="file" required>
                        <button type="submit" class="btn btn-primary btn-sm btn-custom">Tải ảnh</button>
                    </form>

                    <!-- Danh sách hình ảnh -->
                    <div class="img-container">
                        <c:forEach var="hinhAnh" items="${item.hinhAnhs}">
                            <div>
                                <img src="${pageContext.request.contextPath}/${hinhAnh.duongDan}">
                                <br>
                                <a href="${pageContext.request.contextPath}/hinhanh/delete/${hinhAnh.id}?sanPhamId=${item.id}"
                                   onclick="return confirm('Bạn có chắc muốn xóa ảnh này?');"
                                   class="btn btn-danger btn-sm btn-custom">Xóa</a>
                            </div>
                        </c:forEach>
                    </div>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/sanpham/admin/edit/${item.id}" class="btn btn-warning btn-sm btn-custom">Sửa</a>
                    <a href="/sanphamchitiet/list/${item.id}" class="btn btn-info btn-sm btn-custom">Chi tiết</a>
                    <a href="/sanpham/admin/delete?id=${item.id}" class="btn btn-danger btn-sm btn-custom"
                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
