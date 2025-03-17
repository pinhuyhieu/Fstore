<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Không có quyền truy cập</title>
</head>
<body>
<h2>Bạn không có quyền truy cập trang này!</h2>
<p>${error}</p>
<a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
</body>
</html>
