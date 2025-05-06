<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- AOS CSS -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .product-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin: 30px auto;
        }
        .carousel-item img {
            border-radius: 15px;
            max-height: 400px;
            width: 100%;
            object-fit: contain;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .carousel-item img:hover {
            transform: scale(1.05);
        }
        h2 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }
        .color-selector {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .color-option {
            position: relative;
        }

        .color-option input[type="radio"] {
            display: none;
        }

        .color-box {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            display: inline-block;
        }

        .color-box:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }

        .color-radio:checked + .color-box {
            border: 3px solid #0d6efd;
            transform: scale(1.15);
            box-shadow: 0 6px 12px rgba(13,110,253,0.6);
        }

        .color-box::after {
            content: attr(data-tooltip);
            position: absolute;
            bottom: -28px;
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(0,0,0,0.75);
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
            opacity: 0;
            white-space: nowrap;
            pointer-events: none;
            transition: opacity 0.3s;
        }

        .color-box:hover::after {
            opacity: 1;
        }

        .size-btn {
            padding: 10px 25px;
            margin: 5px;
            border: 2px solid #ccc;
            background: #f0f0f0;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s, color 0.3s, transform 0.2s ease, box-shadow 0.2s ease;
            font-weight: bold;
            color: #333;
        }

        .size-btn:hover, .size-btn.active {
            background-color: #333;
            color: white;
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .btn-success, .btn-secondary {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-success:hover, .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        .quantity-container {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 10px;
        }

        .quantity-container label {
            font-size: 16px;
            font-weight: bold;
            margin-right: 5px;
        }

        .quantity-wrapper {
            display: flex;
            align-items: center;
            border: 2px solid #ddd;
            border-radius: 8px;
            overflow: hidden;
            background-color: #888888;
        }

        .quantity-btn {
            background-color: #343a40; /* Blue color */
            color: white;
            border: none;
            padding: 8px 14px;
            font-size: 20px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 38px;
            width: 38px;
        }

        .quantity-btn:hover {
            background-color: #333333; /* Darker blue */
            transform: scale(1.1); /* Slight zoom effect */
        }

        .quantity-btn:active {
            transform: scale(0.95); /* Shrink when pressed */
        }

        .quantity-input {
            width: 60px;
            height: 38px;
            border: none;
            text-align: center;
            font-size: 16px;
            outline: none;
            background-color: #f9f9f9;
        }

        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .quantity-input[type="number"] {
            -moz-appearance: textfield; /* Firefox */
        }

        .carousel-control-prev-icon, .carousel-control-next-icon {
            background-color: #000; /* Màu đen */
            border-radius: 50%; /* Tạo hiệu ứng nút tròn */
        }

        .carousel-control-prev, .carousel-control-next {
            color: #000; /* Đảm bảo màu nút là đen */
        }

        .carousel-control-prev-icon:hover, .carousel-control-next-icon:hover {
            background-color: #333; /* Đổi màu khi hover để tạo hiệu ứng */
        }

    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container product-container" data-aos="fade-up">
    <div class="row">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-6" data-aos="zoom-in">
            <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${sanPham.hinhAnhs}" var="img" varStatus="loop">
                        <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                            <img src="/${img.duongDan}" class="d-block w-100" alt="Hình ảnh sản phẩm">
                        </div>
                    </c:forEach>
                </div>
                <!-- Chỉ hiển thị nút điều hướng nếu có nhiều hơn 1 hình ảnh -->
                <c:if test="${fn:length(sanPham.hinhAnhs) > 1}">
                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
                </c:if>
            </div>
        </div>

        <!-- Thông tin sản phẩm -->
        <div class="col-md-6" data-aos="fade-left" >
            <h2>${sanPham.tenSanPham}</h2>
            <p><strong>Mô tả:</strong> ${sanPham.moTa}</p>

            <!-- Chọn màu sắc -->
            <div class="mb-3" data-aos="fade-up" data-aos-delay="200">
                <label><strong>Màu sắc:</strong></label>
                <div class="color-selector">
                    <c:forEach items="${mauSacList}" var="mau">
                        <label class="color-option">
                            <input type="radio" name="mauSac" value="${mau.id}" class="color-radio ">
                            <span class="color-box"
                                  data-tooltip="${mau.tenMauSac}"
                                  style="background-color:
                                  <c:choose>
                                  <c:when test="${mau.tenMauSac == 'Đỏ'}">#FF0000</c:when>
                                  <c:when test="${mau.tenMauSac == 'Vàng'}">#FFFF00</c:when>
                                  <c:when test="${mau.tenMauSac == 'Trắng'}">#FFFFFF</c:when>
                                  <c:when test="${mau.tenMauSac == 'Đen'}">#000000</c:when>
                                  <c:when test="${mau.tenMauSac == 'Xám'}">#808080</c:when>
                                  <c:when test="${mau.tenMauSac == 'Hồng'}">#FF69B4</c:when>
                                  <c:when test="${mau.tenMauSac == 'Tím'}">#800080</c:when>
                                  <c:when test="${mau.tenMauSac == 'Be'}">#F5F5DC</c:when>
                                  <c:when test="${mau.tenMauSac == 'Xanh'}">#008000</c:when>
                                  <c:otherwise>#000000</c:otherwise>
                                  </c:choose>;">
                            </span>
<%--                            <span class="ms-2">${mau.tenMauSac}</span>--%>
                        </label>
                    </c:forEach>
                </div>
            </div>



            <!-- Chọn kích thước -->
            <div class="mb-3" data-aos="fade-up" data-aos-delay="200">
                <label><strong>Kích thước:</strong></label>
                <div>
                    <c:forEach items="${sizeList}" var="size">
                        <button type="button" class="size-btn" data-size="${size.id}">${size.tenSize}</button>
                    </c:forEach>
                </div>
            </div>
            <div class="quantity-container" data-aos="fade-up" data-aos-delay="200">
                <label for="soLuong">Số lượng:</label>
                <div class="quantity-wrapper">
                    <button class="quantity-btn" onclick="decrease()">-</button>
                    <input type="number" name="soLuong" id="soLuong" class="quantity-input" value="1" min="1" oninput="validateQuantity()">
                    <button class="quantity-btn" onclick="increase()">+</button>
                </div>
            </div>


            <!-- Hiển thị số lượng tồn -->
            <div class="mb-3" data-aos="fade-up" data-aos-delay="200">
                <label><strong>Số lượng tồn:</strong></label>
                <span id="soLuongTon">0</span>
                <span id="hetHang" class="text-danger" style="display: none;"> (Hết hàng)</span>
            </div>
            <div class="mb-3" data-aos="fade-up" data-aos-delay="200">
                <label><strong>Giá tiền:</strong></label>
                <span id="giaTien">0 VNĐ</span>
            </div>


            <!-- Nút thêm vào giỏ hàng -->
            <button id="btnThemVaoGio" class="btn btn-success" data-aos="fade-up" data-aos-delay="200">Thêm vào giỏ hàng</button>
            <!-- Nút mua hàng -->
<%--            <button id="btnMuaHang" class="btn btn-primary">Mua hàng</button>--%>
            <a href="/sanpham/list" class="btn btn-secondary" data-aos="fade-up" data-aos-delay="200">Quay lại danh sách</a>
            <input type="hidden" id="sanPhamId" value="${sanPham.id}">
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS JS -->
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000, // thời gian hiệu ứng (ms)
        once: true      // chỉ chạy 1 lần khi scroll đến
    });
</script>

<script>
    // Xử lý chọn màu sắc
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll('.color-radio').forEach(radio => {
            radio.addEventListener('change', handleColorChange);
        });

        document.querySelectorAll('.size-btn').forEach(button => {
            button.addEventListener('click', handleSizeChange);
        });
    });

    function handleColorChange() {
        document.querySelectorAll('.color-box').forEach(box => box.style.border = '2px solid transparent');
        this.nextElementSibling.style.border = '2px solid black';
        debounce(updateSoLuongTonVaGiaTien, 300)(); // Debounce để tránh nhiều request
    }

    function handleSizeChange() {
        document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('active'));
        this.classList.add('active');
        debounce(updateSoLuongTonVaGiaTien, 300)(); // Debounce để tránh nhiều request
    }

    // Debounce function để tránh spam API
    let debounceTimer;
    function debounce(func, delay) {
        return function () {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(func, delay);
        };
    }

    function updateSoLuongTonVaGiaTien() {
        requestAnimationFrame(() => {
            const selectedColor = document.querySelector('input[name="mauSac"]:checked');
            const colorId = selectedColor ? selectedColor.value : null;

            const selectedSize = document.querySelector('.size-btn.active');
            const sizeId = selectedSize ? selectedSize.dataset.size : null;

            const sanPhamInput = document.getElementById('sanPhamId');
            const sanPhamId = sanPhamInput ? sanPhamInput.value : null;

            if (!colorId || !sizeId || !sanPhamId) {
                setHetHang(true);
                return;
            }
            const url = "/sanpham/soLuongTonVaGiaTien?mauSacId=" + colorId + "&sizeId=" + sizeId + "&sanPhamId=" + sanPhamId;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (!data || typeof data.soLuongTon !== 'number' || typeof data.giaTien !== 'number') {
                        throw new Error("Dữ liệu API không hợp lệ");
                    }

                    document.getElementById('soLuongTon').innerText = data.soLuongTon;

                    const giaTien = new Intl.NumberFormat('vi-VN', {
                        style: 'currency',
                        currency: 'VND'
                    }).format(data.giaTien);
                    document.getElementById('giaTien').innerText = giaTien;

                    setHetHang(data.soLuongTon === 0);
                })
                .catch(error => {
                    console.error("❌ Lỗi khi lấy số lượng tồn và giá tiền:", error);
                    setHetHang(true);
                });
        });
    }

    function setHetHang(isHetHang) {
        document.getElementById('hetHang').style.display = isHetHang ? 'inline' : 'none';
        document.getElementById('btnThemVaoGio').classList.toggle('disabled', isHetHang);
    }

    function addToCart() {
        requestAnimationFrame(() => {
            const soLuongInput = document.getElementById('soLuong');
            const soLuong = parseInt(soLuongInput.value);
            const soLuongTon = parseInt(document.getElementById('soLuongTon').innerText);

            if (soLuong > soLuongTon) {
                alert("❌ Số lượng vượt quá hàng tồn kho!");
                return;
            }

            const selectedColor = document.querySelector('input[name="mauSac"]:checked');
            const colorId = selectedColor ? selectedColor.value : null;

            const selectedSize = document.querySelector('.size-btn.active');
            const sizeId = selectedSize ? selectedSize.dataset.size : null;

            const sanPhamInput = document.getElementById('sanPhamId');
            const sanPhamId = sanPhamInput ? sanPhamInput.value : null;

            if (!colorId || !sizeId || !sanPhamId) {
                alert("❌ Vui lòng chọn màu sắc và kích thước trước khi thêm vào giỏ hàng!");
                return;
            }

            const url = "/sanpham/sanPhamChiTietId?mauSacId=" + colorId + "&sizeId=" + sizeId + "&sanPhamId=" + sanPhamId;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    const sanPhamChiTietId = Number(data);
                    if (isNaN(sanPhamChiTietId)) {
                        alert("❌ Không tìm thấy sản phẩm chi tiết!");
                        return;
                    }

                    const cartData = new URLSearchParams();
                    cartData.append("sanPhamChiTietId", sanPhamChiTietId);
                    cartData.append("soLuong", soLuong);

                    return fetch('/api/cart/details/add', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: cartData.toString()
                    });
                })
                .then(response => response.json())
                .then(result => {
                    if (result.message) {
                        alert(result.message);
                        window.location.reload();
                    } else {
                        alert("❌ Lỗi khi thêm vào giỏ hàng!");
                    }
                })
                .catch(error => {
                    console.error("❌ Lỗi:", error);
                    alert("❌ Lỗi khi thêm sản phẩm vào giỏ hàng!");
                });
        });
    }


    // Gán sự kiện click cho nút "Thêm vào giỏ hàng"
    document.getElementById('btnThemVaoGio').addEventListener('click', addToCart);

    function validateQuantity() {
        const quantityInput = document.getElementById('soLuong');
        const soLuongTon = parseInt(document.getElementById('soLuongTon').innerText);
        let quantity = parseInt(quantityInput.value);

        if (quantity > soLuongTon) {
            alert("❌ Số lượng vượt quá hàng tồn kho!");
            quantityInput.value = soLuongTon;  // Đặt lại về số lượng tồn tối đa
        } else if (quantity < 1) {
            quantityInput.value = 1;  // Không cho phép nhập số lượng nhỏ hơn 1
        }
    }

    // Hàm tăng số lượng
    function increase() {
        const quantityInput = document.getElementById('soLuong');
        const soLuongTon = parseInt(document.getElementById('soLuongTon').innerText);
        let quantity = parseInt(quantityInput.value);

        if (quantity < soLuongTon) {
            quantityInput.value = quantity + 1;  // Tăng số lượng lên 1
        } else {
            alert("❌ Số lượng vượt quá hàng tồn kho!");
        }
    }

    // // Gán sự kiện click cho nút "Mua hàng"
    // document.getElementById('btnMuaHang').addEventListener('click', function() {
    //     addToCart(true); // Gọi hàm addToCart với tham số true để chuyển trang
    // });
    //
    // function addToCart(redirectToCart = false) {
    //     requestAnimationFrame(() => {
    //         const soLuongInput = document.getElementById('soLuong');
    //         const soLuong = parseInt(soLuongInput.value);
    //         const soLuongTon = parseInt(document.getElementById('soLuongTon').innerText);
    //
    //         if (soLuong > soLuongTon) {
    //             alert("❌ Số lượng vượt quá hàng tồn kho!");
    //             return;
    //         }
    //
    //         const selectedColor = document.querySelector('input[name="mauSac"]:checked');
    //         const colorId = selectedColor ? selectedColor.value : null;
    //
    //         const selectedSize = document.querySelector('.size-btn.active');
    //         const sizeId = selectedSize ? selectedSize.dataset.size : null;
    //
    //         const sanPhamInput = document.getElementById('sanPhamId');
    //         const sanPhamId = sanPhamInput ? sanPhamInput.value : null;
    //
    //         if (!colorId || !sizeId || !sanPhamId) {
    //             alert("❌ Vui lòng chọn màu sắc và kích thước trước khi mua!");
    //             return;
    //         }
    //
    //         const url = "/sanpham/sanPhamChiTietId?mauSacId=" + colorId + "&sizeId=" + sizeId + "&sanPhamId=" + sanPhamId;
    //         fetch(url)
    //             .then(response => response.json())
    //             .then(data => {
    //                 const sanPhamChiTietId = Number(data);
    //                 if (isNaN(sanPhamChiTietId)) {
    //                     alert("❌ Không tìm thấy sản phẩm chi tiết!");
    //                     return;
    //                 }
    //
    //                 const cartData = new URLSearchParams();
    //                 cartData.append("sanPhamChiTietId", sanPhamChiTietId);
    //                 cartData.append("soLuong", soLuong);
    //
    //                 return fetch('/api/cart/details/add', {
    //                     method: 'POST',
    //                     headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    //                     body: cartData.toString()
    //                 });
    //             })
    //             .then(response => response.json())
    //             .then(result => {
    //                 if (result.message) {
    //                     if (redirectToCart) {
    //                         window.location.href = "/cart"; // Điều hướng đến trang giỏ hàng
    //                     } else {
    //                         window.location.reload();
    //                     }
    //                 }
    //             })
    //             .catch(error => {
    //                 console.error("❌ Lỗi:", error);
    //                 alert("❌ Lỗi khi thêm sản phẩm vào giỏ hàng!");
    //             });
    //     });
    // }


    // Hàm giảm số lượng
    function decrease() {
        const quantityInput = document.getElementById('soLuong');
        let quantity = parseInt(quantityInput.value);
        if (quantity > 1) {
            quantityInput.value = quantity - 1;  // Giảm số lượng xuống 1
        }
    }



</script>
</body>
</html>