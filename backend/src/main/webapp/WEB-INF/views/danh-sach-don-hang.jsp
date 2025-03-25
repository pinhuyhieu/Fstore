<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN"/>

<html>
<head>
    <title>Danh Sách Đơn Hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">📦 Lịch Sử Đơn Hàng</h2>

    <!-- 🔍 Form tìm kiếm -->
    <form method="get" class="form-inline mb-3">
        <input type="text" name="keyword" class="form-control mr-2"
               placeholder="Nhập mã đơn hàng..." value="${keyword}">
        <button type="submit" class="btn btn-outline-primary">🔍 Tìm kiếm</button>
    </form>

    <!-- 🧾 Bảng đơn hàng -->
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>#ID</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Thanh toán</th>
            <th>Phương thức</th>
            <th>Chi tiết</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="donHang" items="${donHangs}">
            <tr>
                <td>${donHang.id}</td>
                <td>
                        ${fn:substring(donHang.ngayDatHang, 0, 10)}
                        ${fn:substring(donHang.ngayDatHang, 11, 16)}
                </td>
                <td><fmt:formatNumber value="${donHang.tongTien}" type="number" maxFractionDigits="0"/> ₫</td>
                <td>
                    <span class="badge badge-info">${donHang.trangThai.hienThi}</span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${donHang.thanhToan.trangThaiThanhToan == 'DA_THANH_TOAN'}">
                            <span class="badge badge-success">Đã thanh toán</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-warning">Chưa thanh toán</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${donHang.phuongThucThanhToan.tenPhuongThuc}</td>
                <td>
                    <a href="/api/donhang/chi-tiet/${donHang.id}" class="btn btn-sm btn-primary">Xem</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 🔁 Phân trang -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<!-- Bootstrap scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
