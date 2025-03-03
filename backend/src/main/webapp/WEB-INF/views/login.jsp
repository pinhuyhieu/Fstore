<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng Nhập</title>
</head>
<body>
<h1>Đăng Nhập</h1>
<form action="/doLogin" method="post">
    <div>
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>
    </div>
    <div>
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div>
        <button type="submit">Đăng Nhập</button>
    </div>
</form>
<p>Chưa có tài khoản? <a href="/register">Đăng ký ngay</a></p>
</body>
</html>