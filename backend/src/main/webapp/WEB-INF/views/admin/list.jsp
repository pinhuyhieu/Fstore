<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý mã giảm giá</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f4f9;
            font-family: "Segoe UI", sans-serif;
        }

        .custom-hover {
            transition: all 0.3s ease;
        }

        .custom-hover:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .container {
            max-width: 1200px;
            margin-top: 40px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease-in-out;
        }

        .card:hover {
            transform: scale(1.01);
            box-shadow: 0 0 30px rgba(0,0,0,0.08);
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }

        .btn i {
            margin-right: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary fw-bold">🎟️ Danh sách mã giảm giá</h2>
        <div class="d-flex gap-2">
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-primary btn-lg shadow-sm rounded-pill custom-hover">
                <i class="bi bi-house-door-fill"></i> Trang chủ
            </a>
            <a href="/admin/ma-giam-gia/add" class="btn btn-success btn-lg shadow-sm rounded-pill custom-hover">
                <i class="bi bi-plus-circle-fill"></i> Thêm mới
            </a>
        </div>
    </div>

    <div class="card p-4">
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle bg-white">
                <thead class="table-dark text-center">
                <tr>
                    <th>Mã</th>
                    <th>Phần trăm</th>
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
                            <a href="/admin/ma-giam-gia/edit/${item.id}" class="btn btn-sm btn-warning me-1" title="Sửa">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <form action="/admin/ma-giam-gia/delete/${item.id}" method="post" class="d-inline">
                                <button class="btn btn-sm btn-danger" onclick="return confirm('Bạn chắc chắn muốn xóa?')" title="Xóa">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
