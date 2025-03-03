<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng Ký</title>
</head>
<body>
<h1>Đăng Ký</h1>
<form action="/register" method="post">
    <div>
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>
    </div>
    <div>
        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>
    </div>
    <div>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div>
        <button type="submit">Đăng Ký</button>
    </div>
</form>
<p>Đã có tài khoản? <a href="/login">Đăng nhập ngay</a></p>
</body>
</html>