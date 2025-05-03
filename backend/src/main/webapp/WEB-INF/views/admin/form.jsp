<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${maGiamGia.id != null ? "Cập nhật mã" : "Thêm mã mới"}</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="text-center text-primary mb-4">
        ${maGiamGia.id != null ? "✏️ Cập nhật mã giảm giá" : "➕ Thêm mã giảm giá"}
    </h2>
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>

    <%-- Hiển thị thông báo thành công nếu có --%>
    <c:if test="${not empty success}">
        <div class="alert alert-success">
                ${success}
        </div>
    </c:if>

    <form:form method="post" modelAttribute="maGiamGia" action="/admin/ma-giam-gia/save" cssClass="row g-3 shadow-sm bg-white p-4 rounded">
        <form:hidden path="id"/>

        <div class="col-md-6">
            <label class="form-label">Mã:</label>
            <form:input path="ma" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Phần trăm giảm (%):</label>
            <form:input path="phanTramGiam" cssClass="form-control"  type="number" min="0" max="100"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Số tiền giảm (VNĐ):</label>
            <form:input path="soTienGiam" cssClass="form-control"  type="number" min="0"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Số lượng:</label>
            <form:input path="soLuong" cssClass="form-control"  type="number" min="1"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Ngày bắt đầu:</label>
            <form:input path="ngayBatDau" type="date" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Ngày kết thúc:</label>
            <form:input path="ngayKetThuc" type="date" cssClass="form-control" />
        </div>

        <div class="col-md-6">
            <label class="form-label">Giá trị tối thiểu (VNĐ):</label>
            <form:input path="giaTriToiThieu" cssClass="form-control"  type="number" min="0"/>
        </div>

        <div class="col-md-6 d-flex align-items-center mt-4">
            <div class="form-check">
                <form:checkbox path="kichHoat" cssClass="form-check-input" id="kichHoat"/>
                <label for="kichHoat" class="form-check-label">Kích hoạt</label>
            </div>
        </div>

        <div class="col-12 d-flex justify-content-between mt-4">
            <a href="/admin/ma-giam-gia" class="btn btn-secondary">
                ⬅ Quay lại
            </a>
            <button type="submit" class="btn btn-primary">
                💾 Lưu mã giảm giá
            </button>
        </div>
    </form:form>

</div>


<!-- Bootstrap JS (tùy chọn) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelector('form').onsubmit = function(event) {
        var maField = document.querySelector('[name="ma"]');
        var phanTramGiamField = document.querySelector('[name="phanTramGiam"]');
        var soLuongField = document.querySelector('[name="soLuong"]');
        var ngayBatDauField = document.querySelector('[name="ngayBatDau"]');
        var ngayKetThucField = document.querySelector('[name="ngayKetThuc"]');
        var giaTriToiThieuField = document.querySelector('[name="giaTriToiThieu"]');
        var kichHoatField = document.querySelector('[name="kichHoat"]');

        var errorMessage = false;

        // Clear previous error messages
        clearErrorMessages();

        // Validate mã (must not be empty or just spaces)
        if (maField.value.trim() === '') {
            showError(maField, 'Mã không được để trống!');
            errorMessage = true;
        }

        // Validate phần trăm giảm (should be between 0 and 100)
        var phanTramGiamValue = parseInt(phanTramGiamField.value, 10);
        if (isNaN(phanTramGiamValue) || phanTramGiamValue < 0 || phanTramGiamValue > 50) {
            showError(phanTramGiamField, 'Phần trăm giảm phải từ 0 đến 50!');
            errorMessage = true;
        }

        // Validate số tiền giảm (should be a positive number)


        // Validate số lượng (should be a positive integer)
        var soLuongValue = parseInt(soLuongField.value, 10);
        if (isNaN(soLuongValue) || soLuongValue < 1) {
            showError(soLuongField, 'Số lượng phải là một số nguyên dương!');
            errorMessage = true;
        }

        // Validate ngày bắt đầu và ngày kết thúc
        if (new Date(ngayBatDauField.value) >= new Date(ngayKetThucField.value)) {
            showError(ngayKetThucField, 'Ngày kết thúc phải sau ngày bắt đầu!');
            errorMessage = true;
        }

        // Validate giá trị tối thiểu (must be a positive number)
        var giaTriToiThieuValue = parseInt(giaTriToiThieuField.value, 10);
        if (isNaN(giaTriToiThieuValue) || giaTriToiThieuValue < 0) {
            showError(giaTriToiThieuField, 'Giá trị tối thiểu phải là một số dương!');
            errorMessage = true;
        }

        // If there's an error, prevent form submission
        if (errorMessage) {
            event.preventDefault();
            return false;
        }

        return confirm('Bạn chắc chắn muốn lưu mã giảm giá?');
    };

    function showError(field, message) {
        var errorDiv = document.createElement('div');
        errorDiv.classList.add('error-message');
        errorDiv.style.color = 'red';
        errorDiv.style.fontSize = '0.9rem';
        errorDiv.textContent = message;

        // Insert the error message after the input field
        field.parentElement.appendChild(errorDiv);
    }

    function clearErrorMessages() {
        var errorMessages = document.querySelectorAll('.error-message');
        errorMessages.forEach(function(message) {
            message.remove();
        });
    }
</script>

</body>

</html>
