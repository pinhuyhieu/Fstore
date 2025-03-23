<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Lịch Sử Đơn Hàng</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Lịch Sử Mua Hàng</h2>

    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Ngày Đặt Hàng</th>
            <th>Tổng Tiền</th>
            <th>Trạng Thái</th>
            <th>Thanh toán</th>
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
                <td>
                    <span class="badge badge-info">${donHang.trangThai.hienThi}</span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${donHang.thanhToan.trangThaiThanhToan == 'DA_THANH_TOAN'}">
                            <span style="color:green;font-weight:bold;">Đã thanh toán</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:red;font-weight:bold;">Chưa thanh toán</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${donHang.tenNguoiNhan}</td>
                <td>${donHang.diaChiGiaoHang}</td>
                <td>${donHang.phuongThucThanhToan.tenPhuongThuc}</td>
                <td>
                    <a href="/api/donhang/chi-tiet/${donHang.id}" class="btn btn-primary btn-sm">
                        Xem chi tiết
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
