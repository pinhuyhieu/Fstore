<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background-color: #f1f4f9;
            font-family: "Segoe UI", sans-serif;
        }
        .container {
            max-width: 1000px;
            margin-top: 40px;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease-in-out;
        }
        .card:hover {
            transform: scale(1.01);
            box-shadow: 0 0 30px rgba(0,0,0,0.08);
        }
        .form-label {
            font-weight: 600;
        }
        .btn i {
            margin-right: 4px;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .table thead {
            background-color: #343a40;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
        .alert {
            transition: all 0.5s ease-in-out;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4 fw-bold text-primary" data-aos="fade-down" >Danh Sách Chi Tiết Sản Phẩm</h2>


    <!-- Thông báo -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>


    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Danh sách -->
        <div class="card p-4 mb-4" data-aos="fade-up">
        <table class="table table-hover table-bordered align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Màu sắc</th>
                <th>Size</th>
                <th>Giá</th>
                <th>Số lượng tồn</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${chiTietList}" var="item">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.mauSac.tenMauSac}</td>
                    <td>${item.size.tenSize}</td>
                    <td><b><fmt:formatNumber value="${item.gia}" type="number" groupingUsed="true"/> đ</b></td>
                    <td>${item.soLuongTon}</td>
                    <td>
                        <a href="/sanphamchitiet/edit/${item.id}?sanPhamId=${item.sanPham.id}" class="btn btn-warning btn-sm" title="Sửa">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <a href="/sanphamchitiet/delete/${item.id}" class="btn btn-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa?')" title="Xóa">
                            <i class="bi bi-trash-fill"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/sanpham/admin/list" class="btn btn-primary">
            <i class="bi bi-arrow-left-circle-fill"></i> Quay lại danh sách sản phẩm
        </a>
    </div>

    <!-- Form -->
        <div class="card p-4" data-aos="zoom-in">
        <h4 class="fw-bold mb-3 text-success text-center">Thêm / Sửa Chi Tiết Sản Phẩm</h4>
        <form action="/sanphamchitiet/save" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="id" value="${id}">
            <input type="hidden" name="sanPhamId" value="${sanPhamId}" />

            <div class="mb-3">
                <label class="form-label">Size:</label>
                <select name="size.id" class="form-select" required>
                    <c:forEach items="${sizeList}" var="size">
                        <option value="${size.id}" ${size.id == sanPhamChiTiet.size.id ? 'selected' : ''}>${size.tenSize}</option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">Vui lòng chọn size.</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Màu sắc:</label>
                <select name="mauSac.id" class="form-select" required>
                    <c:forEach items="${mauSacList}" var="mau">
                        <option value="${mau.id}" ${mau.id == sanPhamChiTiet.mauSac.id ? 'selected' : ''}>${mau.tenMauSac}</option>
                    </c:forEach>
                </select>
                <div class="invalid-feedback">Vui lòng chọn màu sắc.</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Giá:</label>
                <input type="text" id="gia" name="gia" class="form-control"
                       value="${sanPhamChiTiet.gia}" required
                       oninput="formatCurrency(this)" />
                <div class="invalid-feedback">Giá tiền phải từ 1.000 đến 10 triệu VND.</div>
            </div>

            <div class="mb-3">
                <label class="form-label">Số lượng tồn:</label>
                <input type="number" name="soLuongTon" class="form-control"
                       value="${sanPhamChiTiet.soLuongTon}" required min="1" />
                <div class="invalid-feedback">Số lượng tồn không được để trống và phải lớn hơn 0.</div>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-save"></i>
                    <c:choose>
                        <c:when test="${empty sanPhamChiTiet.id}">Thêm</c:when>
                        <c:otherwise>Cập nhật</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    // Bootstrap validation (chuẩn)
    (() => {
        'use strict';
        window.addEventListener('load', () => {
            const forms = document.getElementsByClassName('needs-validation');
            Array.prototype.forEach.call(forms, form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

    // ✅ Format live trong lúc gõ
    function formatLiveCurrency(input) {
        let value = input.value.replace(/\D/g, '');
        if (value === '') return;
        input.value = Number(value).toLocaleString('vi-VN');
    }

    // ✅ Validate khi blur (rời khỏi ô)
    function validateCurrency(input) {
        let value = input.value.replace(/\D/g, '');
        let numericValue = parseInt(value, 10);
        let errorElement = input.nextElementSibling;

        if (isNaN(numericValue) || numericValue < 1000) {
            input.classList.add("is-invalid");
            errorElement.innerText = "Giá tiền phải lớn hơn hoặc bằng 1.000 VND";
            return false;
        }

        if (numericValue > 10000000) {
            input.classList.add("is-invalid");
            errorElement.innerText = "Giá tiền không được vượt quá 10 triệu VND";
            return false;
        }

        input.classList.remove("is-invalid");
        errorElement.innerText = "";
        input.value = numericValue.toLocaleString('vi-VN');
        return true;
    }

    // ✅ Xử lý submit: xóa định dạng, validate lần cuối
    window.addEventListener('load', () => {
        const forms = document.querySelectorAll('.needs-validation');
        forms.forEach(form => {
            form.addEventListener('submit', function (event) {
                let priceInput = document.getElementById("gia");
                if (priceInput) {
                    // Xóa dấu chấm
                    priceInput.value = priceInput.value.replace(/\D/g, '');
                    const isValid = validateCurrency(priceInput);

                    if (!form.checkValidity() || !isValid) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                }
                form.classList.add('was-validated');
            });
        });
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000, // Thời gian hiệu ứng (ms)
        easing: 'ease-in-out',
        once: true // Chỉ chạy 1 lần khi cuộn
    });
</script>

</body>
</html>
