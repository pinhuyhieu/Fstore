<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng Ký</title>
</head>
<body>
<h1>Đăng Ký</h1>
<form action="/doRegister" method="post">
    <div>
        <label for="hoTen">Họ và Tên:</label>
        <input type="text" id="hoTen" name="hoTen" required>
    </div>
    <div>
        <label for="tenDangNhap">Tên đăng nhập:</label>
        <input type="text" id="tenDangNhap" name="tenDangNhap" required>
    </div>
    <div>
        <label for="matKhau">Mật khẩu:</label>
        <input type="password" id="matKhau" name="matKhau" required>
    </div>
    <div>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div>
        <label for="soDienThoai">Số điện thoại:</label>
        <input type="text" id="soDienThoai" name="soDienThoai">
    </div>
    <div>
        <label for="diaChi">Địa chỉ:</label>
        <input type="text" id="diaChi" name="diaChi">
    </div>
    <div>
        <button type="submit">Đăng Ký</button>
    </div>
</form>
<p>Đã có tài khoản? <a href="/login">Đăng nhập ngay</a></p>
</body>
</html>
