<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>🛒 Giỏ hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn-remove {
            background: red;
            color: white;
        }
        .btn-checkout {
            background: green;
            color: white;
            width: 100%;
            display: block;
            margin-top: 20px;
        }
        .empty-cart {
            text-align: center;
            font-size: 18px;
            color: #666;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🛒 Giỏ hàng của bạn</h2>

    <c:if test="${not empty error}">
        <p style="color: red; text-align: center;">${error}</p>
    </c:if>

    <c:choose>
        <c:when test="${gioHang != null and not empty gioHang.gioHangChiTietList}">
            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Size</th>
                    <th>Màu sắc</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                </tr>
                <c:forEach var="item" items="${gioHang.gioHangChiTietList}">
                    <tr>
                        <td>${item.sanPhamChiTiet.sanPham.tenSanPham}</td>
                        <td>${item.sanPhamChiTiet.size.tenSize}</td>
                        <td>${item.sanPhamChiTiet.mauSac.tenMauSac}</td>
                        <td>${item.soLuong}</td>
                        <td>${item.sanPhamChiTiet.gia * item.soLuong} ₫</td>
                    </tr>
                </c:forEach>
            </table>
            <form action="/api/order/checkout" method="post">
                <button type="submit" class="btn btn-checkout">🛒 Đặt hàng</button>
            </form>
        </c:when>
        <c:otherwise>
            <p class="empty-cart">🛒 Giỏ hàng của bạn đang trống.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>