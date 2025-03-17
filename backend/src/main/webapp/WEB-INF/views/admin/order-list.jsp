<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        .action-buttons a, .action-buttons form {
            display: inline-block;
            margin: 2px;
        }
        select, button {
            padding: 5px;
        }
        .alert {
            padding: 10px;
            color: #fff;
            text-align: center;
            margin-bottom: 15px;
            border-radius: 5px;
        }
        .alert-success {
            background-color: #4CAF50;
        }
        .hidden {
            display: none;
        }
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

<!-- 🟢 Hiển thị thông báo nếu có -->
<c:if test="${not empty successMessage}">
    <div id="success-alert" class="alert alert-success">
            ${successMessage}
    </div>
</c:if>

<h2>Danh Sách Đơn Hàng</h2>
<table>
    <thead>
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
                        <span style="color: red;">Không có thông tin</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                    ${fn:substring(donHang.ngayDatHang, 0, 10)} ${fn:substring(donHang.ngayDatHang, 11, 16)}
            </td>
            <td><fmt:formatNumber value="${donHang.tongTien}" type="currency" currencyCode="VND" /></td>
            <td>
                <form action="/api/donhang/admin/update-status/${donHang.id}" method="POST">
                    <select name="trangThai" onchange="this.form.submit()">
                        <option value="Đang xử lý" ${donHang.trangThai eq 'Đang xử lý' ? 'selected' : ''}>Đang xử lý</option>
                        <option value="Hoàn thành" ${donHang.trangThai eq 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                        <option value="Đã hủy" ${donHang.trangThai eq 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </form>
            </td>
            <td class="action-buttons">
                <a href="/api/donhang/chi-tiet/${donHang.id}">🔍 Xem Chi Tiết</a> |
                <a href="/api/donhang/delete/${donHang.id}" onclick="return confirm('Bạn có chắc muốn xóa?');" style="color: red;">🗑 Xóa</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
