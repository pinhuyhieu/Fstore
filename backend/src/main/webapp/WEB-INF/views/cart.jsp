<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>🛒 Giỏ hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn-remove {
            background: red;
            color: white;
        }
        .btn-update {
            background: orange;
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
        .quantity-container {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .quantity-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            border-radius: 5px;
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            font-size: 14px;
            border: 1px solid #ddd;
            margin: 0 5px;
            padding: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${gioHang != null and not empty gioHang.gioHangChiTietList}">
            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Size</th>
                    <th>Màu sắc</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="item" items="${gioHang.gioHangChiTietList}">
                    <tr id="row-${item.id}">
                        <td>${item.sanPhamChiTiet.sanPham.tenSanPham}</td>
                        <td>${item.sanPhamChiTiet.size.tenSize}</td>
                        <td>${item.sanPhamChiTiet.mauSac.tenMauSac}</td>
                        <td class="quantity-container">
                            <button class="quantity-btn btn-decrease" data-id="${item.id}">-</button>
                            <input type="text" id="quantity-${item.id}" class="quantity-input" value="${item.soLuong}" readonly>
                            <button class="quantity-btn btn-increase" data-id="${item.id}">+</button>
                        </td>
                        <td><span id="total-${item.id}">${item.sanPhamChiTiet.gia * item.soLuong}</span> ₫</td>
                        <td>
                            <button class="btn btn-remove" data-id="${item.id}">❌ Xóa</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <h3>💰 Tổng tiền: <span id="total-price">${tongTien}</span> ₫</h3>

            <form id="checkout-form" action="/api/order/checkout" method="post">
                <button type="submit" class="btn btn-checkout">🛒 Đặt hàng</button>
            </form>
        </c:when>
        <c:otherwise>
            <p class="empty-cart">🛒 Giỏ hàng của bạn đang trống.</p>
        </c:otherwise>
    </c:choose>
</div>

<script>
    $(document).ready(function () {
        // Cập nhật số lượng sản phẩm bằng AJAX
        $(".btn-increase, .btn-decrease").click(function () {
            let itemId = $(this).data("id");
            let isIncrease = $(this).hasClass("btn-increase");
            let quantityElem = $("#quantity-" + itemId);
            let totalElem = $("#total-" + itemId);
            let totalPriceElem = $("#total-price");

            let newQuantity = parseInt(quantityElem.val()) + (isIncrease ? 1 : -1);

            if (newQuantity <= 0) {
                removeFromCart(itemId);
                return;
            }

            $.ajax({
                url: "/api/cart/details/update/" + itemId + "?soLuong=" + newQuantity,
                type: "PUT",
                success: function () {
                    quantityElem.val(newQuantity);
                    let price = parseFloat(totalElem.text()) / parseInt(quantityElem.val());
                    totalElem.text((price * newQuantity).toFixed(2));

                    let totalPrice = 0;
                    $("span[id^='total-']").each(function () {
                        totalPrice += parseFloat($(this).text());
                    });
                    totalPriceElem.text(totalPrice.toFixed(2));
                }
            });
        });

        // Xóa sản phẩm khỏi giỏ hàng bằng AJAX
        $(".btn-remove").click(function () {
            let itemId = $(this).data("id");
            removeFromCart(itemId);
        });

        function removeFromCart(itemId) {
            $.ajax({
                url: "/api/cart/details/remove/" + itemId,
                type: "DELETE",
                success: function () {
                    $("#row-" + itemId).remove();

                    let totalPrice = 0;
                    $("span[id^='total-']").each(function () {
                        totalPrice += parseFloat($(this).text());
                    });
                    $("#total-price").text(totalPrice.toFixed(2));
                }
            });
        }

        // Xác nhận đặt hàng
        $("#checkout-form").submit(function (event) {
            if (!confirm("Bạn có chắc chắn muốn đặt hàng không?")) {
                event.preventDefault();
            }
        });
    });
</script>

</body>
</html>
