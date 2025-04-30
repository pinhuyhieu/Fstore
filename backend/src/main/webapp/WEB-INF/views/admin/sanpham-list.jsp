<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 1000px;
            margin-top: 40px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
        }
        th, td {
            text-align: center;
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
        .btn {
            margin: 3px;
            font-size: 14px;
        }
        .btn:hover {
            opacity: 0.85;
        }
        .pagination .page-link {
            color: #0d6efd;
        }
        .pagination .active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: white;
        }

    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center text-primary mb-4">Danh Sách Sản Phẩm</h2>
    <!-- Form tìm kiếm -->
    <form method="get" action="${pageContext.request.contextPath}/admin/list" class="row g-3 mb-3">
        <div class="col-md-8">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên sản phẩm...">
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
        </div>
    </form>

    <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="btn btn-secondary ">Quay lại thêm sản phẩm</a>
    <!-- Bảng Danh Sách Sản Phẩm -->
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
    <!-- Phân trang -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
