
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - Fstore</title>
    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 15px 15px; /* Giảm padding để thu nhỏ chiều dài */
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            width: 280px;  /* Thu nhỏ form */
            text-align: center;
            transition: transform 0.3s ease;

        }

        .container:hover {
            transform: translateY(-3px);
        }

        .logo {
            font-size: 20px;  /* Giảm kích thước logo */
            font-weight: bold;
            color: #0984e3;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-block;
            padding-bottom: 2px;
        }

        .logo::after {
            content: "";
            display: block;
            width: 40%;
            height: 2px;
            background-color: #0984e3;
            margin: 4px auto 0;
            border-radius: 2px;
        }

        h2 {
            font-size: 14px; /* Thu nhỏ tiêu đề */
            margin-bottom: 6px;
            color: #333;
        }

        label {
            font-weight: 600;
            display: block;
            margin: 4px 0 2px; /* Giảm margin giữa các label */
            color: #555;
            text-align: left;
            font-size: 12px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 6px;  /* Giảm padding để nhỏ hơn */
            margin: 3px 0 6px;  /* Giảm khoảng cách */
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 12px;
            outline: none;
        }

        input[type="text"]:hover, input[type="password"]:hover {
            border-color: #0984e3;
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2),
            -4px -4px 8px rgba(9, 132, 227, 0.1);
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #0984e3;
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4),
            -4px -4px 12px rgba(9, 132, 227, 0.2);
        }


        button {
            width: 100%;
            padding: 6px; /* Giảm kích thước nút */
            background-color: #0984e3;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 13px;
            font-weight: bold;
            margin-top: 6px;
        }

        button:hover {
            background-color: #74b9ff;
            transform: translateY(-2px);
        }

        p, a {
            margin-top: 5px; /* Giảm margin dưới cùng */
            color: #0984e3;
            text-decoration: none;
            font-size: 11px;
        }

        a:hover {
            text-decoration: underline;
        }

        .form-group {
            margin-bottom: 5px; /* Giảm khoảng cách giữa các input  */
            text-align: left;
        }


    </style>
</head>
<body>

<div class="container">
    <div class="logo">Fstore</div>
    <h2>Đăng Ký Tài Khoản</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/doRegister" method="post">
        <div class="form-group">
            <label for="hoTen">Họ và tên:</label>
            <input type="text" id="hoTen" name="hoTen" required>
        </div>

        <div class="form-group">
            <label for="tenDangNhap">Tên đăng nhập:</label>
            <input type="text" id="tenDangNhap" name="tenDangNhap" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="soDienThoai">Số điện thoại:</label>
            <input type="text" id="soDienThoai" name="soDienThoai">
        </div>

        <div class="form-group">
            <label for="diaChi">Địa chỉ:</label>
            <input type="text" id="diaChi" name="diaChi">
        </div>

        <div class="form-group">
            <label for="matKhau">Mật khẩu:</label>
            <input type="password" id="matKhau" name="matKhau" required>
        </div>

        <button type="submit">Đăng Ký</button>
    </form>

    <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
</div>

</body>
</html>