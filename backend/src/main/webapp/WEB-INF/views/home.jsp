<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
<h1>Chào mừng đến với trang chủ!</h1>
<p>Xin chào, ${username}!</p>
<form action="/logout" method="post">
    <button type="submit">Đăng Xuất</button>
</form>
</body>
</html>