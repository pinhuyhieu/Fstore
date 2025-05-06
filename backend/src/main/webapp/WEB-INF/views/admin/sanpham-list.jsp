<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            max-width: 1100px;
            margin-top: 40px;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 18px rgba(0, 0, 0, 0.05);
        }
        th, td {
            text-align: center;
            vertical-align: middle;
        }
        .img-container {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: center;
            margin-top: 8px;
        }
        .img-container img {
            width: 80px;
            border-radius: 8px;
            border: 1px solid #ccc;
            transition: transform 0.2s ease-in-out;
        }
        .img-container img:hover {
            transform: scale(1.05);
        }
        .btn-custom {
            margin: 2px;
        }
        .table th {
            background-color: #343a40;
            color: #fff;
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
<div class="container" data-aos="fade-up" data-aos-duration="600"> <!-- ✅ Container -->

    <h2 class="text-center text-primary mb-4" data-aos="zoom-in" data-aos-duration="800">
        <i class="bi bi-box-seam-fill"></i> Danh Sách Sản Phẩm
    </h2>


    <div class="mb-3" data-aos="fade-right" data-aos-delay="200">
        <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary">
            <i class="bi bi-house-door-fill"></i> Trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="btn btn-secondary">
            <i class="bi bi-plus-circle-fill"></i> Thêm sản phẩm mới
        </a>
    </div>

    <!-- Form tìm kiếm -->
    <form method="get" action="${pageContext.request.contextPath}/sanpham/admin/list" class="row g-3 mb-3"
          data-aos="fade-right" data-aos-delay="300">
        <div class="col-md-8">
            <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo tên sản phẩm...">
        </div>
        <div class="col-md-4">
            <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
        </div>
        <input type="hidden" name="page" value="${currentPage}">
        <input type="hidden" name="size" value="${size}">
    </form>



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
        <c:forEach items="${dsSanPham}" var="item" varStatus="status">
            <tr data-aos="fade-up" data-aos-delay="${status.index * 100}"> <!-- ✅ Mỗi dòng có độ trễ tăng -->
                <td>${item.id}</td>
                <td>${item.tenSanPham}</td>
                <td>${item.danhMuc.tenDanhMuc}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/hinhanh/upload" method="post" enctype="multipart/form-data"
                          class="d-flex flex-column align-items-center" data-aos="fade-up" data-aos-delay="100">
                        <input type="hidden" name="sanPhamId" value="${item.id}">
                        <input type="file" name="file" class="form-control form-control-sm mb-1" required>
                        <button type="submit" class="btn btn-primary btn-sm btn-custom">
                            <i class="bi bi-upload"></i> Tải ảnh
                        </button>
                    </form>

                    <div class="img-container">
                        <c:forEach var="hinhAnh" items="${item.hinhAnhs}">
                            <div class="text-center" data-aos="zoom-in" data-aos-delay="200">
                                <img src="${pageContext.request.contextPath}/${hinhAnh.duongDan}" alt="Ảnh sản phẩm">
                                <br>
                                <a href="${pageContext.request.contextPath}/hinhanh/delete/${hinhAnh.id}?sanPhamId=${item.id}"
                                   onclick="return confirm('Bạn có chắc muốn xóa ảnh này?');"
                                   class="btn btn-danger btn-sm btn-custom mt-1">
                                    <i class="bi bi-trash3-fill"></i> Xóa
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/sanpham/admin/edit/${item.id}" class="btn btn-warning btn-sm btn-custom">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </a>
                    <a href="/sanphamchitiet/list/${item.id}" class="btn btn-info btn-sm btn-custom">
                        <i class="bi bi-info-circle-fill"></i> Chi tiết
                    </a>
<%--                    <a href="/sanpham/admin/delete?id=${item.id}" class="btn btn-danger btn-sm btn-custom"--%>
<%--                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">--%>
<%--                        <i class="bi bi-x-circle-fill"></i> Xóa--%>
<%--                    </a>--%>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <c:if test="${totalPages > 0}">
        <nav aria-label="Page navigation" data-aos="fade-up" data-aos-delay="300">
            <ul class="pagination justify-content-center">
                <!-- Trang trước -->
                <c:if test="${currentPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage - 1}&keyword=${keyword}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>

                <!-- Các số trang -->
                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&keyword=${keyword}">${i + 1}</a>
                    </li>
                </c:forEach>

                <!-- Trang sau -->
                <c:if test="${currentPage < totalPages - 1}">
                    <li class="page-item">
                        <a class="page-link" href="?page=${currentPage + 1}&keyword=${keyword}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </c:if>


</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000, // Thời gian hiệu ứng (ms)
        easing: 'ease-in-out',
        once: true // Chỉ chạy 1 lần khi cuộn
    });
</script>
</body>
</html>
