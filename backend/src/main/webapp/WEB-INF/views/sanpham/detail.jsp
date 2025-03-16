<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
        .color-box {
            width: 40px;
            height: 40px;
            display: inline-block;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
            margin-right: 5px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .color-box:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .color-radio:checked + .color-box {
            border: 3px solid #333;
            transform: scale(1.15);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
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
            background-color: #007bff; /* Blue color */
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
            background-color: #0056b3; /* Darker blue */
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


    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container product-container">
    <div class="row">
        <!-- Hình ảnh sản phẩm -->
        <div class="col-md-6">
            <div id="productCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${sanPham.hinhAnhs}" var="img" varStatus="loop">
                        <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                            <img src="/${img.duongDan}" class="d-block w-100" alt="Hình ảnh sản phẩm">
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#productCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#productCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
            </div>
        </div>

        <!-- Thông tin sản phẩm -->
        <div class="col-md-6">
            <h2>${sanPham.tenSanPham}</h2>
            <p><strong>Mô tả:</strong> ${sanPham.moTa}</p>

            <!-- Chọn màu sắc -->
            <div class="mb-3">
                <label><strong>Màu sắc:</strong></label>
                <div>
                    <c:forEach items="${mauSacList}" var="mau">
                        <label class="d-flex align-items-center m-2">
                            <input type="radio" name="mauSac" value="${mau.id}" class="color-radio d-none">
                            <span class="color-box" style="background-color: ${mau.tenMauSac};"></span>
                            <span class="ms-2">${mau.tenMauSac}  </span>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <!-- Chọn kích thước -->
            <div class="mb-3">
                <label><strong>Kích thước:</strong></label>
                <div>
                    <c:forEach items="${sizeList}" var="size">
                        <button type="button" class="size-btn" data-size="${size.id}">${size.tenSize}</button>
                    </c:forEach>
                </div>
            </div>
            <div class="quantity-container">
                <label for="soLuong">Số lượng:</label>
                <div class="quantity-wrapper">
                    <button class="quantity-btn" onclick="decrease()">-</button>
                    <input type="number" name="soLuong" id="soLuong" class="quantity-input" value="1" min="1">
                    <button class="quantity-btn" onclick="increase()">+</button>
                </div>
            </div>


            <!-- Hiển thị số lượng tồn -->
            <div class="mb-3">
                <label><strong>Số lượng tồn:</strong></label>
                <span id="soLuongTon">0</span>
                <span id="hetHang" class="text-danger" style="display: none;"> (Hết hàng)</span>
            </div>
            <div class="mb-3">
                <label><strong>Giá tiền:</strong></label>
                <span id="giaTien">0 VNĐ</span>
            </div>


            <!-- Nút thêm vào giỏ hàng -->
            <button id="btnThemVaoGio" class="btn btn-success">Thêm vào giỏ hàng</button>
            <a href="/sanpham/list" class="btn btn-secondary">Quay lại danh sách</a>
            <input type="hidden" id="sanPhamId" value="${sanPham.id}">
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
            const selectedColor = document.querySelector('input[name="mauSac"]:checked');
            const colorId = selectedColor ? selectedColor.value : null;

            const selectedSize = document.querySelector('.size-btn.active');
            const sizeId = selectedSize ? selectedSize.dataset.size : null;

            const sanPhamInput = document.getElementById('sanPhamId');
            const sanPhamId = sanPhamInput ? sanPhamInput.value : null;

            const soLuongInput = document.getElementById('soLuong');
            const soLuong = soLuongInput ? soLuongInput.value : 1;

            if (!colorId || !sizeId || !sanPhamId) {
                alert("❌ Vui lòng chọn màu sắc và kích thước trước khi thêm vào giỏ hàng!");
                return;
            }

            const url = "/sanpham/sanPhamChiTietId?mauSacId=" + colorId + "&sizeId=" + sizeId + "&sanPhamId=" + sanPhamId;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    console.log("📌 API Response:", data);
                    const sanPhamChiTietId = Number(data);
                    if (isNaN(sanPhamChiTietId)) {
                        alert("❌ Không tìm thấy sản phẩm chi tiết!");
                        return;
                    }

                    console.log("✅ Sản phẩm chi tiết ID:", sanPhamChiTietId); // Debug

                    // Chuẩn bị dữ liệu gửi đến API
                    const cartData = new URLSearchParams();
                    cartData.append("sanPhamChiTietId", sanPhamChiTietId);
                    cartData.append("soLuong", soLuong); // Lấy từ input

                    // Gửi request POST
                    return fetch('/api/cart/details/add', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: cartData.toString()
                    });
                })
                .then(response => response.json())
                .then(result => {
                    console.log("📌 API Response:", result); // Debug response

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

    // Hàm tăng số lượng
    function increase() {
        const quantityInput = document.getElementById('soLuong');
        let quantity = parseInt(quantityInput.value);
        quantityInput.value = quantity + 1;  // Tăng số lượng lên 1
    }

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