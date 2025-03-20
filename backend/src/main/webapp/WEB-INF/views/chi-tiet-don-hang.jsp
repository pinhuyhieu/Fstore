<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Chi Tiết Đơn Hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .container { margin-top: 30px; }
        .table th { background-color: #007bff; color: #fff; }
        .table td, .table th { padding: 12px; }
        .btn-back { margin-top: 20px; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Chi Tiết Đơn Hàng</h2>

    <div class="card shadow p-4">
        <p><strong>ID:</strong> ${donHang.id}</p>
        <p><strong>Ngày Đặt Hàng:</strong> ${donHang.ngayDatHang}</p>
        <p><strong>Tổng Tiền:</strong> ${donHang.tongTien} VND</p>
        <p><strong>Trạng Thái:</strong> ${donHang.trangThai}</p>
        <p><strong>Người Nhận:</strong> ${donHang.tenNguoiNhan}</p>
        <p><strong>Địa Chỉ Giao Hàng:</strong> ${donHang.diaChiGiaoHang}, ${donHang.phuongXa}, ${donHang.quanHuyen}, ${donHang.tinhThanh}</p>
        <p><strong>Phương Thức Thanh Toán:</strong> ${donHang.phuongThucThanhToan.tenPhuongThuc}</p>
    </div>

    <h3 class="mt-4">Sản phẩm trong đơn hàng</h3>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="chiTiet" items="${donHang.chiTietDonHangList}">
            <tr>
                <td>${chiTiet.sanPhamChiTiet.sanPham.tenSanPham}</td>
                <td>${chiTiet.soLuong}</td>
                <td>${chiTiet.giaBan} VND</td>
                <td>${chiTiet.soLuong * chiTiet.giaBan} VND</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="/donhang/danh-sach" class="btn btn-primary btn-back">⬅ Quay lại danh sách đơn hàng</a>
</div>

</body>
</html>