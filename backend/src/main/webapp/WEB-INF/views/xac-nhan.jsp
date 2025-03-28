<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Xác nhận đặt hàng</title>
    <!-- Thêm Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .success-message {
            color: #28a745;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            border-radius: 25px;
            padding: 10px 20px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card p-4">
        <h2 class="text-center text-primary">Thành công</h2>

        <!-- Hiển thị thông báo thành công nếu có -->
        <c:if test="${not empty successMessage}">
            <p class="success-message text-center">${successMessage}</p>
        </c:if>

        <div class="mt-3">
            <p><strong>Mã đơn hàng:</strong> ${donHang.id}</p>
            <p><strong>Người đặt:</strong> ${donHang.user.hoTen}</p>
            <p><strong>Phương thức thanh toán:</strong> ${donHang.phuongThucThanhToan.tenPhuongThuc}</p>
            <p><strong>Tổng tiền:</strong> <span class="text-danger fw-bold">${donHang.tongTien} VNĐ</span></p>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/sanpham/list" class="btn btn-custom">🏠 Quay về trang sản phẩm</a>
        </div>
    </div>
</div>

<!-- Thêm Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
