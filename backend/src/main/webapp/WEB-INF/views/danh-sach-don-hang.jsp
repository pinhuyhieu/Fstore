<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Danh Sách Đơn Hàng</title>
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
<h2>Danh Sách Đơn Hàng</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Ngày Đặt Hàng</th>
        <th>Tổng Tiền</th>
        <th>Trạng Thái</th>
        <th>Người Nhận</th>
        <th>Địa Chỉ Giao Hàng</th>
        <th>Phương Thức Thanh Toán</th>
        <th>Chi Tiết</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="donHang" items="${donHangs}">
        <tr>
            <td>${donHang.id}</td>
            <td>${donHang.ngayDatHang}</td>
            <td>${donHang.tongTien} VND</td>
            <td>${donHang.trangThai}</td>
            <td>${donHang.tenNguoiNhan}</td>
            <td>${donHang.diaChiGiaoHang}</td>
            <td>${donHang.phuongThucThanhToan.tenPhuongThuc}</td>
            <td><a href="/api/donhang/chi-tiet/${donHang.id}">Xem chi tiết</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
