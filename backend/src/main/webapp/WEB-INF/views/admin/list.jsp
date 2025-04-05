<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý mã giảm giá</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-primary">🎟️ Danh sách mã giảm giá</h2>
        <a href="/admin/ma-giam-gia/add" class="btn btn-success">
            ➕ Thêm mới
        </a>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle bg-white shadow-sm">
            <thead class="table-dark text-center">
            <tr>
                <th>Mã</th>
                <th>Phần trăm</th>
                <th>Số tiền giảm</th>
                <th>Bắt đầu</th>
                <th>Kết thúc</th>
                <th>Số lượng</th>
                <th>Giá trị tối thiểu</th>
                <th>Kích hoạt</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody class="text-center">
            <c:forEach var="item" items="${dsMaGiamGia}">
                <tr>
                    <td><strong>${item.ma}</strong></td>
                    <td>${item.phanTramGiam}%</td>
                    <td>${item.soTienGiam} ₫</td>
                    <td>${item.ngayBatDau}</td>
                    <td>${item.ngayKetThuc}</td>
                    <td>${item.soLuong}</td>
                    <td>${item.giaTriToiThieu} ₫</td>
                    <td>
                        <span class="badge ${item.kichHoat ? 'bg-success' : 'bg-secondary'}">
                                ${item.kichHoat ? "Đã kích hoạt" : "Chưa kích hoạt"}
                        </span>
                    </td>
                    <td>
                        <a href="/admin/ma-giam-gia/edit/${item.id}" class="btn btn-sm btn-warning me-1">✏️</a>
                        <form action="/admin/ma-giam-gia/delete/${item.id}" method="post" class="d-inline">
                            <button class="btn btn-sm btn-danger" onclick="return confirm('Bạn chắc chắn muốn xóa?')">
                                🗑
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS (optional for interactive components) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
