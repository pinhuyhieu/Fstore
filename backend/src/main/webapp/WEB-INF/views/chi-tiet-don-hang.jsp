<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Chi Tiết Đơn Hàng</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<h2>Chi Tiết Đơn Hàng</h2>

<p><strong>ID:</strong> ${donHang.id}</p>
<p><strong>Ngày Đặt Hàng:</strong> ${donHang.ngayDatHang}</p>
<p><strong>Tổng Tiền:</strong> ${donHang.tongTien} VND</p>
<p><strong>Trạng Thái:</strong> ${donHang.trangThai}</p>
<p><strong>Người Nhận:</strong> ${donHang.tenNguoiNhan}</p>
<p><strong>Địa Chỉ Giao Hàng:</strong> ${donHang.diaChiGiaoHang}</p>
<p><strong>Phương Thức Thanh Toán:</strong> ${donHang.phuongThucThanhToan.tenPhuongThuc}</p>

<h3>Sản phẩm trong đơn hàng</h3>
<table>
    <thead>
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

<br>
<a href="/donhang/danh-sach">⬅ Quay lại danh sách đơn hàng</a>
</body>
</html>
