<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN" />

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
        .list-group-item {
            border-left: 4px solid #0d6efd;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Chi Tiết Đơn Hàng</h2>

    <div class="card shadow p-4">
        <p><strong>Mã đơn hàng:</strong> #${donHang.id}</p>

        <p><strong>📅 Ngày đặt:</strong>
            ${fn:substring(donHang.ngayDatHang, 0, 10)} ${fn:substring(donHang.ngayDatHang, 11, 16)}
        </p>

        <p><strong>💰 Tổng tiền:</strong>
            <fmt:formatNumber value="${donHang.tongTien}" type="number" maxFractionDigits="0"/> ₫
        </p>

        <p><strong>📦 Trạng thái:</strong> ${donHang.trangThai.hienThi}</p>

        <p><strong>👤 Người nhận:</strong> ${donHang.tenNguoiNhan}</p>

        <p><strong>📍 Địa chỉ giao hàng:</strong><br/>
            ${donHang.diaChiGiaoHang}<br/>
            ${donHang.phuongXa}, ${donHang.quanHuyen}, ${donHang.tinhThanh}
        </p>

        <p><strong>💳 Thanh toán:</strong> ${donHang.phuongThucThanhToan.tenPhuongThuc}</p>

        <p><strong>💸 Trạng thái thanh toán:</strong>
            <c:choose>
                <c:when test="${not empty donHang.thanhToan}">
                    ${donHang.thanhToan.trangThaiThanhToan.hienThi}
                </c:when>
                <c:otherwise>
                    Không có thông tin
                </c:otherwise>
            </c:choose>
        </p>
    </div>

    <h5 class="mt-4">🕓 Lịch sử trạng thái đơn hàng</h5>
    <ul class="list-group mb-4">
        <c:forEach var="log" items="${lichSuTrangThai}">
            <li class="list-group-item">
                <strong>${log.trangThaiMoi.hienThi}</strong>
                <span class="text-muted">
                    - ${fn:substring(log.thoiGian, 0, 10)} ${fn:substring(log.thoiGian, 11, 16)}
                </span>
                <c:if test="${not empty log.ghiChu}">
                    <br/><em>📝 ${log.ghiChu}</em>
                </c:if>
            </li>
        </c:forEach>
    </ul>

    <h3 class="mt-4">Sản phẩm trong đơn hàng</h3>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>Sản phẩm</th>
            <th>Màu sắc</th>
            <th>Size</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="chiTiet" items="${donHang.chiTietDonHangList}">
            <tr>
                <td>${chiTiet.sanPhamChiTiet.sanPham.tenSanPham}</td>
                <td>${chiTiet.sanPhamChiTiet.mauSac.tenMauSac}</td>
                <td>${chiTiet.sanPhamChiTiet.size.tenSize}</td>
                <td>${chiTiet.soLuong}</td>
                <td><fmt:formatNumber value="${chiTiet.giaBan}" type="number" maxFractionDigits="0"/> ₫</td>
                <td><fmt:formatNumber value="${chiTiet.soLuong * chiTiet.giaBan}" type="number" maxFractionDigits="0"/> ₫</td>
            </tr>
        </c:forEach>
        </tbody>
        <!-- thêm sau bảng sản phẩm -->
        <tfoot>
        <tr>
            <td colspan="5" class="text-end"><strong>Phí vận chuyển:</strong></td>
            <td><fmt:formatNumber value="${donHang.phiShip}" type="number" maxFractionDigits="0"/> ₫</td>
        </tr>

            <tr>
                <td colspan="5" class="text-end"><strong>Giảm giá:</strong></td>
                <td>-<fmt:formatNumber value="${donHang.soTienGiam}" type="number" maxFractionDigits="0"/> ₫</td>
            </tr>

        <tr>
            <td colspan="5" class="text-end"><strong>Tổng thanh toán:</strong></td>
            <td>
                <fmt:formatNumber value="${donHang.thanhToan.soTien}" type="number" maxFractionDigits="0"/> ₫
            </td>
        </tr>
        </tfoot>

    </table>

    <a href="${backUrl}" class="btn btn-primary btn-back">⬅ Quay lại danh sách đơn hàng</a>
</div>

</body>
</html>
