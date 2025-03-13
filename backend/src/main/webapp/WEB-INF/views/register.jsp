<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký</title>
    <link rel="stylesheet" href="/css/style.css"> <!-- Thêm CSS nếu cần -->
</head>
<body>

<div class="container">
    <h2>Đăng Ký Tài Khoản</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/doRegister" method="post">
        <label for="hoTen">Họ và tên:</label>
        <input type="text" id="hoTen" name="hoTen" required>

        <label for="tenDangNhap">Tên đăng nhập:</label>
        <input type="text" id="tenDangNhap" name="tenDangNhap" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="soDienThoai">Số điện thoại:</label>
        <input type="text" id="soDienThoai" name="soDienThoai">

        <label for="diaChi">Địa chỉ:</label>
        <input type="text" id="diaChi" name="diaChi">

        <label for="matKhau">Mật khẩu:</label>
        <input type="password" id="matKhau" name="matKhau" required>

        <button type="submit">Đăng Ký</button>
    </form>

    <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
</div>

</body>
</html>
