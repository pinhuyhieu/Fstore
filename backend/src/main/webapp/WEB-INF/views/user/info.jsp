<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Thông Tin Người Dùng - Fstore</title>
    <link rel="stylesheet" href="/static/css/styles.css" />
    <style>
        body {
            background-color: #f4f6f9;
            font-family: sans-serif;
        }
        .container {
            width: 500px;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #0d6efd;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin: 10px 0 4px;
            font-weight: 600;
        }
        input, select {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #0d6efd;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Cập Nhật Thông Tin</h2>

    <form:form method="post" modelAttribute="user" action="/user/update">
        <form:hidden path="id" />

        <label for="hoTen">Họ tên:</label>
        <form:input path="hoTen" id="hoTen" />

        <label for="tenDangNhap">Tên đăng nhập:</label>
        <form:input path="tenDangNhap" id="tenDangNhap" disabled="true" />

        <label for="email">Email:</label>
        <form:input path="email" id="email" />

        <label for="soDienThoai">Số điện thoại:</label>
        <form:input path="soDienThoai" id="soDienThoai" />

        <label for="diaChi">Địa chỉ:</label>
        <form:input path="diaChi" id="diaChi" />

        <label for="matKhau">Mật khẩu mới:</label>
        <form:password path="matKhau" id="matKhau" />

        <button type="submit">Cập Nhật</button>
    </form:form>
</div>

</body>
</html>
