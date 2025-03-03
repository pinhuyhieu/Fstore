<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Sản phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .color-box {
            width: 35px;
            height: 35px;
            display: inline-block;
            border-radius: 50%;
            cursor: pointer;
            border: 2px solid transparent;
            transition: 0.3s;
        }
        .color-radio:checked + .color-box {
            border: 2px solid black;
        }
        .size-btn {
            padding: 8px 15px;
            margin: 5px;
            border: 1px solid #ccc;
            background: #f8f9fa;
            cursor: pointer;
            border-radius: 5px;
        }
        .size-btn.active {
            background: black;
            color: white;
        }
        .disabled {
            opacity: 0.5;
            pointer-events: none;
        }
    </style>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<div class="container mt-5">
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
            <div class="mb-3">
                <label><strong>Số lượng:</strong></label>
                <input type="number" name="soLuong" id="soLuong" class="form-control" value="1" min="1">
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

            <!-- Nút Thêm vào giỏ hàng -->
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

    document.getElementById('btnThemVaoGio').addEventListener('click', function () {
        const sanPhamId = document.getElementById('sanPhamId').value;
        const soLuong = document.getElementById('soLuong') ? document.getElementById('soLuong').value : 1;
        const mauSac = document.querySelector('input[name="mauSacId"]:checked');
        const size = document.querySelector('input[name="sizeId"]:checked');

        if (!mauSac || !size) {
            alert("Vui lòng chọn màu sắc và kích thước trước khi thêm vào giỏ hàng!");
            return;
        }

        const data = new URLSearchParams();
        data.append("sanPhamId", sanPhamId);
        data.append("mauSacId", mauSac.value);
        data.append("sizeId", size.value);
        data.append("soLuong", soLuong);

        fetch('/cart/add', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: data.toString()
        })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    alert("✅ Đã thêm vào giỏ hàng!");
                    window.location.reload(); // Cập nhật giỏ hàng ngay
                } else {
                    alert("❌ Lỗi khi thêm vào giỏ hàng!");
                }
            })
            .catch(error => console.error("Lỗi gửi yêu cầu giỏ hàng:", error));
    });

</script>
</body>
</html>