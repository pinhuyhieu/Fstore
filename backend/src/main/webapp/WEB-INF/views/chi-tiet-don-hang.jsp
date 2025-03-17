<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Chi Tiết Đơn Hàng</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Chi Tiết Đơn Hàng</h2>

    <div class="card mb-4">
        <div class="card-body">
            <p><strong>ID:</strong> ${donHang.id}</p>
            <p><strong>Ngày Đặt Hàng:</strong> ${donHang.ngayDatHang}</p>
            <p><strong>Tổng Tiền:</strong> ${donHang.tongTien} VND</p>
            <p><strong>Trạng Thái:</strong>
                <span class="badge badge-info">${donHang.trangThai}</span>
            </p>
            <p><strong>Người Nhận:</strong> ${donHang.tenNguoiNhan}</p>
            <p><strong>Địa Chỉ Giao Hàng:</strong> ${donHang.diaChiGiaoHang}</p>
            <p><strong>Phương Thức Thanh Toán:</strong> ${donHang.phuongThucThanhToan.tenPhuongThuc}</p>
        </div>
    </div>

    <h3>Sản phẩm trong đơn hàng</h3>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
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

    <a href="/api/donhang/danh-sach" class="btn btn-secondary mt-3" style="margin-bottom: 20px">⬅ Quay lại danh sách đơn hàng</a>

</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
