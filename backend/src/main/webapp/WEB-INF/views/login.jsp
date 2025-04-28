<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đăng Nhập - Fstore</title>
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
            padding: 40px 30px;
            border-radius: 30px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            width: 340px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        .logo {
            font-size: 32px;
            font-weight: bold;
            color: #0984e3;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            position: relative;
            display: inline-block;
            padding-bottom: 4px;
        }

        .logo::after {
            content: "";
            display: block;
            width: 60%;
            height: 3px;
            background-color: #0984e3;
            margin: 6px auto 0;
            border-radius: 2px;
        }

        h1 {
            font-size: 26px;
            color: #333;
            margin-bottom: 20px;
        }

        .message {
            margin-bottom: 15px;
            font-size: 14px;
        }

        .message.error {
            color: red;
        }

        .message.success {
            color: green;
        }

        label {
            font-weight: 600;
            display: block;
            margin: 8px 0 4px;
            color: #555;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 15px;
            outline: none;
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
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
            padding: 12px;
            background-color: #0984e3;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 17px;
            font-weight: bold;
        }

        button:hover {
            background-color: #74b9ff;
            transform: translateY(-3px);
        }

        p, a {
            margin-top: 15px;
            color: #0984e3;
            text-decoration: none;
            font-size: 14px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateForm() {
            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();

            if (username === "" || password === "") {
                alert("Tên đăng nhập và mật khẩu không được bỏ trống!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container">
    <div class="logo">Fstore</div>
    <h1>Đăng Nhập</h1>
    <c:if test="${param.error != null}">
        <p class="message error">Sai tên đăng nhập hoặc mật khẩu!</p>
    </c:if>
    <c:if test="${param.logout != null}">
        <p class="message success">Bạn đã đăng xuất thành công.</p>
    </c:if>
    <form action="/doLogin" method="post" onsubmit="return validateForm();">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" >

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" >

        <button type="submit">Đăng Nhập</button>
    </form>
    <p>Chưa có tài khoản? <a href="/register">Đăng ký ngay</a></p>
</div>
</body>
</html>
