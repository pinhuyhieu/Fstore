<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .container { margin-top: 30px; }
        .alert { text-align: center; }
        .table { margin-top: 20px; }
        .table thead { background-color: #007bff; color: #fff; }
        .table th { text-align: center; padding: 12px; }

        select { padding: 5px; border-radius: 5px; }
        .btn-sm { padding: 5px 10px; font-size: 14px; }
        .hidden { display: none; }
    </style>

    <script>
        // Ẩn thông báo sau 3 giây
        setTimeout(function() {
            var alertBox = document.getElementById("success-alert");
            if (alertBox) {
                alertBox.classList.add("hidden");
            }
        }, 3000);
    </script>
</head>
<body>

<div class="container">
    <!-- 🟢 Hiển thị thông báo nếu có -->
    <c:if test="${not empty successMessage}">
        <div id="success-alert" class="alert alert-success">
                ${successMessage}
        </div>
    </c:if>

    <h2 class="text-center mb-4">Danh Sách Đơn Hàng</h2>

    <table class="table table-bordered table-striped table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Người Đặt</th>
            <th>Ngày Đặt</th>
            <th>Tổng Tiền</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="donHang" items="${donHangs}">
            <tr>
                <td>${donHang.id}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty donHang.user.hoTen}">
                            ${donHang.user.hoTen}
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger">Không có thông tin</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${fn:substring(donHang.ngayDatHang, 0, 10)} ${fn:substring(donHang.ngayDatHang, 11, 16)}</td>
                <td><fmt:formatNumber value="${donHang.tongTien}" type="currency" currencyCode="VND" /></td>
                <td>
                    <form action="/api/donhang/admin/update-status/${donHang.id}" method="POST">
                        <select name="trangThai" class="form-select form-select-sm" onchange="this.form.submit()">
                            <option value="Chờ xác nhận" ${donHang.trangThai eq 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="Đã xác nhận" ${donHang.trangThai eq 'Đã xác nhận' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="Đang giao hàng" ${donHang.trangThai eq 'Đang giao hàng' ? 'selected' : ''}>Đang giao hàng</option>
                            <option value="Thành công" ${donHang.trangThai eq 'Thành công' ? 'selected' : ''}>Thành công</option>
                            <option value="Thất bại" ${donHang.trangThai eq 'Thất bại' ? 'selected' : ''}>Thất bại</option>
                            <option value="Hủy" ${donHang.trangThai eq 'Hủy' ? 'selected' : ''}>Hủy</option>
                        </select>
                    </form>
                </td>
                <td class="text-center">
                    <a href="/api/donhang/chi-tiet/${donHang.id}" class="btn btn-primary btn-sm">🔍 Xem</a>
                    <a href="/api/donhang/delete/${donHang.id}" onclick="return confirm('Bạn có chắc muốn xóa?');" class="btn btn-danger btn-sm">🗑 Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>