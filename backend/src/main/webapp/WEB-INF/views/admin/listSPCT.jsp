<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Sản phẩm Chi tiết</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 900px;
            margin-top: 40px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .btn-custom {
            margin: 3px;
            font-size: 14px;
        }
        .btn-custom:hover {
            opacity: 0.85;
        }
        .form-label {
            font-weight: bold;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
        .btn {
            margin: 3px;
            font-size: 14px;
        }
        .btn:hover {
            opacity: 0.85;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center text-primary mb-4">Danh sách Chi tiết Sản phẩm</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Danh Sách Chi Tiết Sản Phẩm -->
    <table class="table table-bordered table-striped">
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
                <td><b>${item.gia} VNĐ</b></td>
                <td>${item.soLuongTon}</td>
                <td>
                    <a href="/sanphamchitiet/edit/${item.id}?sanPhamId=${item.sanPham.id}" class="btn btn-warning btn-sm btn-custom">Sửa</a>
                    <a href="/sanphamchitiet/delete/${item.id}" class="btn btn-danger btn-sm btn-custom"
                       onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/sanpham/admin/list" class="btn btn-primary btn-lg">Quay lại danh sách sản phẩm</a>

    <!-- Form Thêm / Cập Nhật Chi Tiết Sản Phẩm -->
    <h3 class="text-center text-success mt-4">Thêm / Sửa Chi tiết Sản phẩm</h3>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <form action="/sanphamchitiet/save" method="post" class="p-3 border rounded bg-light mt-3 needs-validation" novalidate>
        <input type="hidden" name="id" value="${id}">
        <input type="hidden" name="sanPhamId" value="${sanPhamId}" />

        <div class="mb-3">
            <label class="form-label">Size:</label>
            <select name="size.id" class="form-select">
                <c:forEach items="${sizeList}" var="size">
                    <option value="${size.id}" ${size.id == sanPhamChiTiet.size.id ? 'selected' : ''}>${size.tenSize}</option>
                </c:forEach>
            </select>
            <div class="invalid-feedback">Vui lòng chọn size.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Màu sắc:</label>
            <select name="mauSac.id" class="form-select">
                <c:forEach items="${mauSacList}" var="mau">
                    <option value="${mau.id}" ${mau.id == sanPhamChiTiet.mauSac.id ? 'selected' : ''}>${mau.tenMauSac}</option>
                </c:forEach>
            </select>
            <div class="invalid-feedback">Vui lòng chọn màu sắc.</div>
        </div>

<%--        <div class="mb-3">--%>
<%--            <label class="form-label">Giá:</label>--%>
<%--            <input type="number" name="gia" class="form-control" value="${sanPhamChiTiet.gia}" required oninput="formatCurrency(this)" min="1" />--%>
<%--            <div class="invalid-feedback">Giá không được để trống và phải lớn hơn 0.</div>--%>
<%--        </div>--%>
        <div class="mb-3">
            <label class="form-label">Giá:</label>
            <input type="text" id="gia" name="gia" class="form-control"
                   value="${sanPhamChiTiet.gia}" required
                   oninput="formatCurrency(this)" />
            <div class="invalid-feedback">Giá tiền phải từ 1.000 đến 10 triệu VND.</div>
        </div>

        <div class="mb-3">
            <label class="form-label">Số lượng tồn:</label>
            <input type="number" name="soLuongTon" class="form-control" value="${sanPhamChiTiet.soLuongTon}" required min="1" />
            <div class="invalid-feedback">Số lượng tồn không được để trống và phải lớn hơn 0.</div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-success btn-lg">
                <c:choose>
                    <c:when test="${empty sanPhamChiTiet.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
        </div>
    </form>


</div>
<script>
    (function() {
        'use strict';
        var forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function(form) {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

    // function formatCurrency(input) {
    //     // Lấy giá trị nhập vào, loại bỏ ký tự không phải số
    //     let value = input.value.replace(/\D/g, '');
    //
    //     // Chuyển thành số nguyên
    //     let numericValue = parseInt(value, 10);
    //
    //     // Kiểm tra nếu giá trị nhỏ hơn 1, đặt về 1
    //     if (isNaN(numericValue) || numericValue < 1) {
    //         numericValue = 1;
    //     }
    //
    //     // // Định dạng số tiền (thêm dấu . phân tách hàng nghìn)
    //     // input.value = numericValue.toLocaleString('vi-VN');
    // }
    function formatCurrency(input) {
        let value = input.value.replace(/\D/g, ''); // Loại bỏ ký tự không phải số
        let numericValue = parseInt(value, 10);

        // Lấy thẻ thông báo lỗi và class input
        let errorElement = input.nextElementSibling;

        if (isNaN(numericValue) || numericValue < 1000) {
            numericValue = 1000;
            errorElement.innerText = "Giá tiền phải lớn hơn hoặc bằng 1.000 VND";
            input.classList.add("is-invalid");
        } else if (numericValue > 10000000) {
            numericValue = 10000000;
            errorElement.innerText = "Giá tiền không được vượt quá 10 triệu VND";
            input.classList.add("is-invalid");
        } else {
            errorElement.innerText = ""; // Xóa lỗi nếu hợp lệ
            input.classList.remove("is-invalid");
        }

        // Định dạng số tiền theo chuẩn Việt Nam
        input.value = numericValue.toLocaleString('vi-VN');
    }

    // Xóa dấu chấm khi submit form
    document.querySelector("form").addEventListener("submit", function (event) {
        let priceInput = document.getElementById("gia");
        priceInput.value = priceInput.value.replace(/\./g, '');
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
