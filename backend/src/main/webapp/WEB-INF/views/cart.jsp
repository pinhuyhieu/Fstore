<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />

<html>
<head>
    <title>🛒 Giỏ hàng</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- AOS CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            color: #333;
            font-family: Arial, sans-serif;
        }

        .content-wrapper {
            background-color: rgba(255, 255, 255, 0.97);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            margin-top: 40px;
        }

        h2, h3 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .table th {
            background-color: #0984e3;
            color: white;
        }

        .quantity-container button {
            padding: 5px 10px;
        }

        .quantity-input {
            width: 60px;
            text-align: center;
        }

        .form-control, .btn {
            border-radius: 8px;
        }

        .btn-checkout {
            background-color: #28a745;
            color: white;
            font-weight: bold;
            width: 100%;
            padding: 12px;
        }

        .btn-checkout:hover {
            background-color: #218838;
        }

        .alert {
            font-size: 14px;
        }

        #discountRow {
            font-weight: bold;
            margin-bottom: 1rem;
        }

        /* Tổng thể card */
        .col-md-5 {
            background: #ffffff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            transition: box-shadow 0.3s ease;
        }

        /* Header */
        .col-md-5 h3 {
            font-weight: bold;
            color: #007bff;
        }

        /* Form input và select */
        .col-md-5 .form-control {
            border-radius: 10px;
            border: 1px solid #ced4da;
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .col-md-5 .form-control:hover,
        .col-md-5 .form-control:focus {
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.4);
            border-color: #007bff;
        }

        /* Nút bấm */
        .col-md-5 .btn {
            border-radius: 10px;
            transition: box-shadow 0.3s ease, transform 0.2s ease;
        }

        .col-md-5 .btn:hover {
            box-shadow: 0 0 12px rgba(0, 123, 255, 0.5);
            transform: translateY(-2px);
        }

        /* Tổng giá và phần giảm giá */
        #total-price, #finalAmount, #discountAmount, #shippingFee {
            font-size: 1.2rem;
            font-weight: bold;
        }

        /* Phần hiển thị giảm giá */
        #discountRow {
            margin-top: 10px;
        }

        .btn-back {
            display: inline-block;
            background: linear-gradient(135deg, #4d9fef, #007bff);
            color: #fff;
            border: none;
            padding: 12px 28px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: linear-gradient(135deg, #007bff, #0056b3);
            box-shadow: 0 6px 18px rgba(0, 123, 255, 0.35);
            transform: translateY(-2px);
            color: #fff;
            text-decoration: none;
        }

        .btn-back:active {
            transform: scale(0.98);
            box-shadow: 0 3px 10px rgba(0, 123, 255, 0.3);
        }
    </style>
</head>
<body>
<div class="container content-wrapper"  data-aos="fade-in">
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success" data-aos="fade-down">${successMessage}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" data-aos="fade-down">${error}</div>
    </c:if>
    <c:if test="${not empty sessionScope.maGiamGiaNguoiDung}">
        <div class="alert alert-info" data-aos="fade-down">
            ✅ Đã áp dụng mã: ${sessionScope.maGiamGiaNguoiDung.maGiamGia.ma}
        </div>
    </c:if>

    <div class="container mt-4">
        <input type="hidden" name="maGiamGia.id" value="${maGiamGia.id}" />

        <div class="row">
            <!-- 🧾 Cột trái: Giỏ hàng -->
            <div class="col-md-7" data-aos="fade-right">
                <h3 class="mb-3" data-aos="fade-up">🛒 Giỏ hàng của bạn</h3>

                <c:choose>
                    <c:when test="${gioHang != null and not empty gioHang.gioHangChiTietList}">
                        <table class="table table-bordered table-hover" data-aos="zoom-in-up">
                            <thead class="thead-dark">
                            <tr>
                                <th>Chọn</th>
                                <th>Sản phẩm</th>
                                <th>Size</th>
                                <th>Màu</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${gioHang.gioHangChiTietList}">
                                <tr id="row-${item.id}" data-aos="fade-up" data-aos-delay="100">
                                    <td><input type="checkbox" class="product-checkbox" data-id="${item.id}" checked></td>
                                    <td>${item.sanPhamChiTiet.sanPham.tenSanPham}</td>
                                    <td>${item.sanPhamChiTiet.size.tenSize}</td>
                                    <td>${item.sanPhamChiTiet.mauSac.tenMauSac}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <button class="btn btn-sm btn-outline-secondary btn-decrease" data-id="${item.id}">-</button>
                                            <input type="text" class="form-control mx-1 text-center quantity-input" id="quantity-${item.id}" value="${item.soLuong}" style="width: 60px;">
                                            <button class="btn btn-sm btn-outline-secondary btn-increase" data-id="${item.id}">+</button>
                                        </div>
                                    </td>
                                    <td>
                                        <span id="gia-${item.id}" data-gia="${item.sanPhamChiTiet.gia}">
                                            <fmt:formatNumber value="${item.sanPhamChiTiet.gia}" type="number" maxFractionDigits="0"/> ₫
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-danger btn-remove" data-id="${item.id}">❌</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info" data-aos="flip-up">🛒 Giỏ hàng của bạn đang trống.</div>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/sanpham/list" class="btn btn-back" data-aos="fade-up">Quay lại</a>
            </div>

            <!-- 🧾 Cột phải: Thông tin đặt hàng -->
            <div class="col-md-5" data-aos="fade-left">
                <h3 class="mb-3" data-aos="fade-up">📦 Thông tin đặt hàng</h3>

                <!-- Thông báo -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">${successMessage}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <!-- Mã giảm giá -->
                <div class="form-group" data-aos="fade-up" data-aos-delay="100">
                    <label for="maGiamGiaInput">Mã giảm giá:</label>
                    <div class="d-flex">
                        <input type="text" class="form-control" id="maGiamGiaInput" placeholder="Nhập mã">
                        <button type="button" class="btn btn-primary ml-2" id="applyCouponBtn">Áp dụng</button>
                        <button type="button" class="btn btn-danger ml-2" id="cancelCouponBtn">Hủy</button>
                    </div>
                </div>

                <div id="discountRow" style="display: none;" data-aos="fade-up">
                    <p class="text-success">✅ Giảm giá: <span id="discountAmount" data-giam="0">-0 ₫</span></p>
                </div>

                <!-- Tổng tiền -->
                <div class="form-group mt-3" data-aos="fade-up">
                    <label>Tạm tính:</label>
                    <h5><span id="total-price" data-tong="${tongTien}">
                    <fmt:formatNumber value="${tongTien}" type="number" maxFractionDigits="0"/> ₫
                </span></h5>
                </div>

                <!-- Form đặt hàng -->
                <form action="/api/donhang/dat-hang" method="post" onsubmit="return confirm('Bạn chắc chắn muốn đặt hàng?')" data-aos="zoom-in">
                    <div class="form-group">
                        <label>Tên người nhận:</label>
                        <input type="text" class="form-control" name="tenNguoiNhan" value="${user.hoTen}" required >
                    </div>
                    <div class="form-group">
                        <label>SĐT người nhận:</label>
                        <input type="text" class="form-control" name="soDienThoaiNguoiNhan" value="${user.soDienThoai}" required>
                    </div>

                    <div class="form-group">
                        <label>Địa chỉ giao hàng:</label>
                        <input type="text" class="form-control" name="diaChiGiaoHang" value="${diaChi.diaChiChiTiet}" required>
                    </div>

                    <!-- Địa chỉ -->
                    <div class="form-group">
                        <label>Tỉnh/Thành phố:</label>
                        <select class="form-control" id="tinhThanh" name="tinhThanh" value="${diaChi.tenTinhThanh}" required></select>
                    </div>
                    <div class="form-group">
                        <label>Quận/Huyện:</label>
                        <select class="form-control" id="quanHuyen" name="quanHuyen" value="${diaChi.tenQuanHuyen}" required></select>
                    </div>
                    <div class="form-group">
                        <label>Phường/Xã:</label>
                        <select class="form-control" id="phuongXa" name="phuongXa" value="${diaChi.tenPhuongXa}" required></select>
                    </div>

                    <!-- Thanh toán -->
                    <div class="form-group">
                        <label>Phương thức thanh toán:</label>
                        <select class="form-control" name="phuongThucThanhToanId" required>
                            <c:forEach var="pt" items="${dsPhuongThuc}">
                                <option value="${pt.id}">${pt.tenPhuongThuc}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Phí ship & tổng cộng -->
                    <div class="form-group">
                        <label>Phí vận chuyển:</label>
                        <p><strong><span id="shippingFee">0</span> ₫</strong></p>
                    </div>
                    <div class="form-group">
                        <label>Tổng cộng:</label>
                        <p><strong><span id="finalAmount">0</span> ₫</strong></p>
                    </div>

                    <button type="submit" class="btn btn-warning btn-block" data-aos="zoom-in-up">🛒 Đặt hàng</button>
                </form>
            </div>
        </div>
    </div>

        <!-- AOS JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
        <script>
            AOS.init({
                duration: 1000, // Thời gian hiệu ứng (ms)
                easing: 'ease-in-out',
                once: true // Chỉ chạy 1 lần khi cuộn
            });
        </script>


        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script><script>
    function tinhTongThanhToan() {
        const tienHang = parseInt($("#total-price").data("tong")) || 0;
        const soTienGiam = parseInt($("#discountAmount").data("giam")) || 0;
        const phiShip = parseInt($("#shippingFee").text().replace(/[^\d]/g, "")) || 0;

        let tong = tienHang - soTienGiam + phiShip;
        if (tong < 0) tong = 0;

        $("#finalAmount").text(tong.toLocaleString("vi-VN") + " ₫");
    }


    $(document).ready(function () {


        // Hiển thị tổng tiền ngay khi trang được tải
        updateTotalPrice();





        // Cập nhật tổng tiền khi chọn/bỏ chọn sản phẩm
        $(".product-checkbox").change(function () {
            updateTotalPrice();
        });
        $(".btn-increase, .btn-decrease").click(function () {
            let itemId = $(this).data("id");
            let isIncrease = $(this).hasClass("btn-increase");
            let inputElem = $("#quantity-" + itemId);
            let current = parseInt(inputElem.val());

            if (isNaN(current)) current = 1;

            let newQty = current + (isIncrease ? 1 : -1);
            if (newQty <= 0) {
                removeFromCart(itemId);
                return;
            }
            if (newQty <= 0) newQty = 1;

            inputElem.val(newQty).trigger("input"); // Gọi lại logic chính dưới
        });

// ✅ Gõ trực tiếp số lượng → xử lý cập nhật
        $(".quantity-input").on("input", function () {
            let itemId = $(this).attr("id").split("-")[1];
            let quantityElem = $(this);
            let newQuantity = parseInt(quantityElem.val());

            if (isNaN(newQuantity) || newQuantity <= 0) {
                newQuantity = 1;
                quantityElem.val(newQuantity);
            }

            $.ajax({
                url: "/api/cart/details/update/" + itemId + "?soLuong=" + newQuantity,
                type: "PUT",
                success: function () {
                    // ✅ Lấy giá gốc từ data-gia
                    let giaGoc = parseInt($("#gia-" + itemId).data("gia"));
                    let newTotal = giaGoc * newQuantity;

                    // ✅ Cập nhật hiển thị thành tiền dòng
                    let formatted = new Intl.NumberFormat('vi-VN').format(newTotal);
                    $("#total-" + itemId).text(formatted + " ₫");

                    // ✅ Cập nhật tổng giỏ hàng
                    updateTotalPrice();
                    tinhTongThanhToan(); // thêm dòng này

                    // ✅ Lưu lại số lượng cũ nếu cần dùng
                    quantityElem.data("old", newQuantity);
                },
                error: function (xhr) {
                    alert("❌ Lỗi: " + xhr.responseText);
                }
            });
        });

// ✅ Hàm cập nhật tổng tiền toàn bộ giỏ hàng
        function updateTotalPrice() {
            let totalPrice = 0;

            $("tr[id^='row-']").each(function () {
                const row = $(this);
                const itemId = row.attr("id").split("-")[1];
                const isChecked = row.find(".product-checkbox").is(":checked");

                if (isChecked) {
                    const gia = parseInt($("#gia-" + itemId).data("gia"));
                    const soLuong = parseInt($("#quantity-" + itemId).val()) || 1;
                    totalPrice += gia * soLuong;
                }
            });

            const formatted = new Intl.NumberFormat('vi-VN').format(totalPrice);
            $("#total-price").text(formatted + " ₫").data("tong", totalPrice);
            $("#confirm-total-price").text(formatted + " ₫");
        }



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





        // Xác nhận đặt hàng
        $("#checkout-form").submit(function (event) {
            if (!confirm("Bạn có chắc chắn muốn đặt hàng không?")) {
                event.preventDefault();
            }
        });
        $(document).ready(function () {
            const defaultTinhThanh = "${diaChi.tenTinhThanh}";
            const defaultQuanHuyen = "${diaChi.tenQuanHuyen}";
            const defaultPhuongXa  = "${diaChi.tenPhuongXa}";

            console.log("✅ Tỉnh mặc định:", defaultTinhThanh);
            console.log("✅ Quận mặc định:", defaultQuanHuyen);
            console.log("✅ Phường mặc định:", defaultPhuongXa);
            // Lấy Tỉnh/Thành phố khi trang được tải
            $.ajax({
                url: '/api/ghn/provinces',  // API lấy danh sách Tỉnh/Thành phố
                method: 'GET',
                success: function (data) {
                    console.log('Dữ liệu tỉnh thành:', data);  // Kiểm tra dữ liệu trả về
                    var tinhThanhSelect = $('#tinhThanh');
                    tinhThanhSelect.empty();  // Xóa các tùy chọn cũ
                    tinhThanhSelect.append('<option value="">Chọn Tỉnh/Thành phố</option>');  // Thêm lựa chọn mặc định

                    // Kiểm tra nếu không có data hoặc data.data
                    if (data && data.data) {
                        data.data.forEach(function (province) {
                            tinhThanhSelect.append('<option value="' + province.ProvinceID  + '">' + province.ProvinceName  + '</option>');
                        });
                        if (defaultTinhThanh) {
                            $('#tinhThanh').val(defaultTinhThanh).trigger('change');
                        }

                    } else {
                        alert("Không có dữ liệu tỉnh/thành phố.");
                    }
                },
                error: function () {
                    alert("Lỗi khi lấy danh sách tỉnh/thành phố.");
                }
            });

            // Lấy danh sách Quận/Huyện khi người dùng chọn Tỉnh/Thành phố
            $('#tinhThanh').change(function () {
                var provinceId = $(this).val();  // Lấy giá trị provinceId từ dropdown

                // Kiểm tra xem provinceId có hợp lệ không (không phải "undefined" hoặc rỗng)
                if (!provinceId) {
                    alert("Vui lòng chọn Tỉnh/Thành phố");
                    return;  // Không thực hiện AJAX nếu không chọn Tỉnh
                }

                $.ajax({
                    url: '/api/ghn/districts/' + provinceId,  // Gọi API để lấy Quận/Huyện theo provinceId
                    method: 'GET',
                    success: function (data) {
                        console.log('Dữ liệu tỉnh thành:', data);
                        var quanHuyenSelect = $('#quanHuyen');
                        quanHuyenSelect.empty(); // Xóa các tùy chọn cũ
                        quanHuyenSelect.append('<option value="">Chọn Quận/Huyện</option>');  // Thêm lựa chọn mặc định

                        // Duyệt qua dữ liệu và thêm các quận huyện vào dropdown
                        data.data.forEach(function (district) {
                            quanHuyenSelect.append('<option value="' + district.DistrictID + '">' + district.DistrictName + '</option>');
                        });
                        if (defaultQuanHuyen) {
                            $('#quanHuyen').val(defaultQuanHuyen).trigger('change');
                        }
                    },
                    error: function () {
                        alert("Lỗi khi lấy danh sách quận/huyện.");
                    }
                });
            });

            // Lấy danh sách Phường/Xã khi người dùng chọn Quận/Huyện
            $('#quanHuyen').change(function () {
                var districtId = $(this).val();  // Lấy giá trị districtId từ dropdown

                // Kiểm tra xem districtId có hợp lệ không
                if (!districtId) {
                    return;  // Không thực hiện AJAX nếu không chọn Quận/Huyện
                }

                $.ajax({
                    url: '/api/ghn/wards/' + districtId,  // Gọi API để lấy Phường/Xã theo districtId
                    method: 'GET',
                    success: function (data) {
                        console.log('Dữ liệu tỉnh thành:', data);
                        var phuongXaSelect = $('#phuongXa');
                        phuongXaSelect.empty(); // Xóa các tùy chọn cũ
                        phuongXaSelect.append('<option value="">Chọn Phường/Xã</option>');  // Thêm lựa chọn mặc định

                        // Duyệt qua dữ liệu và thêm các phường xã vào dropdown
                        data.data.forEach(function (ward) {
                            phuongXaSelect.append('<option value="' + ward.WardCode + '">' + ward.WardName + '</option>');
                        });
                        if (defaultPhuongXa) {
                            $('#phuongXa').val(defaultPhuongXa).trigger('change');
                        }
                    },
                    error: function () {
                        alert("Lỗi khi lấy danh sách phường/xã.");
                    }

                });
                // Tính phí ship sau khi chọn Phường/Xã
                $('#phuongXa').change(function () {
                    const districtId = $('#quanHuyen').val();
                    const wardCode = $('#phuongXa').val();

                    if (!districtId || !wardCode) return;

                    // Tính lại tổng tiền hiện tại từ các dòng được chọn
                    let tongTien = 0;
                    let soLuong = 0;

                    $("tr[id^='row-']").each(function () {
                        const id = $(this).attr("id").split("-")[1];
                        if ($(this).find(".product-checkbox").is(":checked")) {
                            const gia = parseInt($("#gia-" + id).data("gia"));
                            const qty = parseInt($("#quantity-" + id).val()) || 1;
                            tongTien += gia * qty;
                            soLuong += qty;
                        }

                    });
                    $("#total-price").data("tong", tongTien); // 🔧 cập nhật lại DOM để mã giảm giá dùng giá mới


                    $.ajax({
                        url: "/api/ghn/api/ghn/calculate-fee",
                        type: "GET",
                        data: {
                            soLuong: soLuong,
                            districtId: districtId,
                            wardCode: wardCode,
                            tongTien: tongTien
                        },
                        success: function (phi) {
                            $("#shippingFee")
                                .text(phi.toLocaleString("vi-VN") + " ₫")
                                .data("ship", phi); // Cập nhật giá trị ship cho hàm tính tổng

                            tinhTongThanhToan(); // Gọi lại để hiển thị tổng mới
                        },

                        error: function () {
                            alert("Lỗi khi tính phí vận chuyển.");
                        }
                    });
                });

            });

            // Gửi yêu cầu tạo đơn hàng
            $('#create-order-form').submit(function (event) {
                event.preventDefault();  // Ngừng gửi form mặc định

                // Gửi yêu cầu tạo đơn hàng
                $.ajax({
                    url: '/api/ghn/create-order',
                    method: 'POST',
                    data: $(this).serialize(),  // Gửi toàn bộ form data
                    success: function (response) {
                        alert('Đơn hàng đã được tạo thành công!');
                        // Bạn có thể thêm logic để điều hướng người dùng đến trang khác
                    },
                    error: function () {
                        alert('Có lỗi xảy ra khi tạo đơn hàng!');
                    }
                });
            });
        });

    });
    $("#applyCouponBtn").click(function () {
        const ma = $("#maGiamGiaInput").val().trim();

        $.ajax({
            url: "/api/ma-giam-gia/apply",
            method: "POST",
            data: { ma },
            success: function (res) {
                alert(res.message || "✅ Mã đã áp dụng");

                // Gọi thêm /check để lấy số tiền giảm:
                $.ajax({
                    url: "/api/ma-giam-gia/check",
                    method: "GET",
                    data: {
                        ma: ma,
                        tongTien: parseInt($("#total-price").data("tong"))
                    },
                    success: function (data) {
                        $("#discountAmount")
                            .text("-" + data.soTienGiam.toLocaleString("vi-VN") + " ₫")
                            .data("giam", data.soTienGiam);
                        $("#discountRow").show();
                        tinhTongThanhToan();
                    }
                });
            },
            error: function (xhr) {
                alert(xhr.responseText || "❌ Mã không hợp lệ");
            }
        });
    });

    $("#cancelCouponBtn").click(function () {
        $.ajax({
            url: "/api/ma-giam-gia/cancel",
            method: "GET",
            success: function () {
                $("#discountRow").hide();
                $("#discountAmount").data("giam", 0);
                tinhTongThanhToan();
                alert("❌ Mã giảm giá đã được hủy");
            },
            error: function () {
                alert("Lỗi khi hủy mã giảm giá.");
            }
        });
    });




</script>

</body>
</html>
