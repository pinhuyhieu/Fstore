<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Giỏ hàng</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        .btn { padding: 5px 10px; background: blue; color: white; border: none; cursor: pointer; }
        .btn-remove { background: red; }
    </style>
</head>
<body>
<h2>🛒 Giỏ hàng của bạn</h2>

<c:choose>
    <c:when test="${not empty gioHang.gioHangChiTiets}">
        <table>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Tổng</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="item" items="${gioHang.gioHangChiTiets}">
                <tr>
                    <td>${item.sanPhamChiTiet.sanPham.tenSanPham}</td>
                    <td>${item.soLuong}</td>
                    <td>${item.sanPhamChiTiet.gia} VND</td>
                    <td>${item.soLuong * item.sanPhamChiTiet.gia} VND</td>
                    <td>
                        <form action="/cart/remove/${item.id}" method="post">
                            <button class="btn btn-remove">Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <br>
        <form action="/cart/clear" method="post">
            <button class="btn">Xóa toàn bộ giỏ hàng</button>
        </form>
    </c:when>
    <c:otherwise>
        <p>Giỏ hàng của bạn đang trống.</p>
    </c:otherwise>
</c:choose>
</body>
</html>
