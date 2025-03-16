<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>🛒 Giỏ hàng</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            margin: 0;
            padding: 20px 0;
            color: #333;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .container.mt-5 {
            display: block;
        }


        .container:hover {
            transform: translateY(-5px);
        }

        h2, h3 {
            color: #333;
            text-align: center;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table th, table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        table th {
            background-color: #0984e3;
            color: #fff;
            font-weight: bold;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .quantity-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 4px;
        }

        .quantity-btn {
            background-color: #0984e3;
            color: #fff;
            border: none;
            padding: 8px 12px;
            margin: 0;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 16px;
            line-height: 1;
        }

        .quantity-btn:hover {
            background-color: #74b9ff;
            transform: translateY(-2px);
        }

        .quantity-input {
            width: 50px;
            height: 40px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 0;
            font-size: 16px;
            outline: none;
        }

        .btn-remove {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-remove:hover {
            background-color: #c0392b;
        }

        .btn-checkout {
            background-color: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin: 20px auto;
            display: block;
            font-size: 17px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-checkout:hover {
            background-color: #218838;
            transform: translateY(-3px);
        }

        .empty-cart {
            text-align: center;
            color: #888;
            margin: 20px 0;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
        }

        .form-control {
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

        .form-control:hover {
            border-color: #0984e3;
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2);
        }

        .form-control:focus {
            border-color: #0984e3;
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4);
        }

        .btn-success {
            background-color: #0984e3;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin: 20px 0;
            font-size: 17px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-success:hover {
            background-color: #74b9ff;
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
                    <th>Chọn</th>
                    <th>Sản phẩm</th>
                    <th>Size</th>
                    <th>Màu sắc</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="item" items="${gioHang.gioHangChiTietList}">
                    <tr id="row-${item.id}">
                        <td>
                            <input type="checkbox" class="product-checkbox" data-id="${item.id}" checked>
                        </td>
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
            <h3>💰 Tổng tiền: <span id="total-price">${tongTien}</span></h3>

        </c:when>
        <c:otherwise>
            <p class="empty-cart">🛒 Giỏ hàng của bạn đang trống.</p>
        </c:otherwise>
    </c:choose>


    <c:if test="${gioHang != null and not empty gioHang.gioHangChiTietList}">
        <div class="container mt-5">
            <h2 class="text-center">Xác nhận đặt hàng</h2>
            <form action="/api/donhang/dat-hang" method="post">
            <div class="form-group">
                    <label>Tên người nhận:</label>
                    <input type="text" class="form-control" name="tenNguoiNhan" placeholder="Nhập tên người nhận" required>
                </div>
                <div class="form-group">
                    <label>Số điện thoại người nhận:</label>
                    <input type="text" class="form-control" name="soDienThoaiNguoiNhan" placeholder="Nhập số điện thoại" required>
                </div>
                <div class="form-group">
                    <label>Địa chỉ giao hàng:</label>
                    <input type="text" class="form-control" name="diaChiGiaoHang" placeholder="Nhập địa chỉ" required>
                </div>
                <div class="form-group">
                    <label>Phương thức thanh toán:</label>
                    <select class="form-control" name="phuongThucThanhToanId" required>
                        <option value="1">Thanh toán khi nhận hàng</option>
                        <option value="2">Chuyển khoản ngân hàng</option>
                        <option value="3">Thanh toán bằng ví điện tử</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Tổng tiền:</label>
                    <p class="font-weight-bold">
                        <span id="confirm-total-price">${donHang.tongTien}</span> VND
                    </p>
                </div>
                <button type="submit" class="btn btn-checkout">🛒 Xác nhận đặt hàng</button>
            </form>
        </div>
    </c:if>

</div>

<script>


    $(document).ready(function () {
        // Hiển thị tổng tiền ngay khi trang được tải
        updateTotalPrice();

        // Cập nhật tổng tiền khi chọn/bỏ chọn sản phẩm
        $(".product-checkbox").change(function () {
            updateTotalPrice();
        });

        // Cập nhật số lượng sản phẩm bằng AJAX
        $(".btn-increase, .btn-decrease").click(function () {
            let itemId = $(this).data("id");
            let isIncrease = $(this).hasClass("btn-increase");
            let quantityElem = $("#quantity-" + itemId);
            let totalElem = $("#total-" + itemId);

            let currentQuantity = parseInt(quantityElem.val());
            let newQuantity = currentQuantity + (isIncrease ? 1 : -1);

            if (newQuantity <= 0) {
                removeFromCart(itemId);
                return;
            }

            $.ajax({
                url: "/api/cart/details/update/" + itemId + "?soLuong=" + newQuantity,
                type: "PUT",
                success: function () {
                    // Cập nhật số lượng hiển thị
                    quantityElem.val(newQuantity);

                    // Tính lại giá tiền sản phẩm
                    let pricePerItem = parseFloat(totalElem.text().replace(/[^\d.-]/g, '')) / currentQuantity;
                    let newTotal = pricePerItem * newQuantity;
                    totalElem.text(newTotal.toFixed(2) + " ₫");

                    // Cập nhật lại tổng tiền giỏ hàng
                    updateTotalPrice();
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
                    updateTotalPrice();

                    // Kiểm tra nếu giỏ hàng trống
                    if ($("tr[id^='row-']").length === 0) {
                        $("table").remove();
                        $("h3").remove();
                        $("#checkout-form").remove();
                        $(".container").append('<p class="empty-cart">🛒 Giỏ hàng của bạn đang trống.</p>');

                        // Ẩn luôn bảng xác nhận đặt hàng
                        $(".container.mt-5").hide();
                    }
                },
                error: function () {
                    alert("❌ Lỗi khi xóa sản phẩm khỏi giỏ hàng.");
                }
            });
        }


        // Hàm cập nhật tổng tiền dựa trên sản phẩm được chọn
        function updateTotalPrice() {
            let totalPrice = 0;
            $("tr[id^='row-']").each(function () {
                let itemId = $(this).attr("id").split("-")[1];
                if ($("#row-" + itemId + " .product-checkbox").is(":checked")) {
                    let itemTotal = parseFloat($("#total-" + itemId).text().replace(/[^\d.-]/g, ''));
                    totalPrice += isNaN(itemTotal) ? 0 : itemTotal;
                }
            });
            $("#total-price").text(totalPrice.toFixed(2) + " ₫");
            // Cập nhật tổng tiền ở phần xác nhận đặt hàng
            $("#confirm-total-price").text(totalPrice.toFixed(2) + " ₫");
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
