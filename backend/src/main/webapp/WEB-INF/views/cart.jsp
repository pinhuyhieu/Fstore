<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
</head>
<body>
<h2>🛒 Giỏ hàng của bạn</h2>

<c:choose>
    <c:when test="${empty gioHangList}">
        <p>Giỏ hàng trống. <a href="<c:url value='/san-pham'/>">🛍 Mua sắm ngay</a></p>
    </c:when>
    <c:otherwise>
        <table border="1">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${gioHangList}">
                <tr>
                    <td>${item.sanPhamChiTiet.sanPham.ten}</td>
                    <td><fmt:formatNumber value="${item.sanPhamChiTiet.gia}" type="currency" currencySymbol="₫" /></td>
                    <td>
                        <form action="<c:url value='/gio-hang/cap-nhat'/>" method="post">
                            <input type="hidden" name="id" value="${item.id}">
                            <input type="number" name="soLuong" value="${item.soLuong}" min="1" required>
                            <button type="submit">🔄 Cập nhật</button>
                        </form>
                    </td>
                    <td>
                        <fmt:formatNumber value="${item.sanPhamChiTiet.gia * item.soLuong}" type="currency" currencySymbol="₫" />
                    </td>
                    <td>
                        <form action="<c:url value='/gio-hang/xoa'/>" method="post">
                            <input type="hidden" name="id" value="${item.id}">
                            <button type="submit" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">❌ Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <h3>🧾 Tổng tiền:
            <fmt:formatNumber value="${tongTien != null ? tongTien : 0}" type="currency" currencySymbol="₫" />
        </h3>

        <form action="<c:url value='/gio-hang/thanh-toan'/>" method="post">
            <button type="submit">💳 Thanh toán</button>
        </form>
    </c:otherwise>
</c:choose>

<a href="<c:url value='/san-pham'/>">⬅ Tiếp tục mua sắm</a>
</body>
</html>
