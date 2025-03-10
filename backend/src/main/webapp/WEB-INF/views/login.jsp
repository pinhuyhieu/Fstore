<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng Nhập</title>
</head>
<body>
<h1>Đăng Nhập</h1>
<c:if test="${param.error != null}">
    <p style="color: red;">Sai tên đăng nhập hoặc mật khẩu!</p>
</c:if>
<c:if test="${param.logout != null}">
    <p style="color: green;">Bạn đã đăng xuất thành công.</p>
</c:if>
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
