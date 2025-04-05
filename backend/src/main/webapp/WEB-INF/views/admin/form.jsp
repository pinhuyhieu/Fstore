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

    <form:form method="post" modelAttribute="maGiamGia" action="/admin/ma-giam-gia/save" cssClass="row g-3 shadow-sm bg-white p-4 rounded">
        <form:hidden path="id"/>

        <div class="col-md-6">
            <label class="form-label">Mã:</label>
            <form:input path="ma" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Phần trăm giảm (%):</label>
            <form:input path="phanTramGiam" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Số tiền giảm (VNĐ):</label>
            <form:input path="soTienGiam" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Số lượng:</label>
            <form:input path="soLuong" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Ngày bắt đầu:</label>
            <form:input path="ngayBatDau" type="date" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Ngày kết thúc:</label>
            <form:input path="ngayKetThuc" type="date" cssClass="form-control"/>
        </div>

        <div class="col-md-6">
            <label class="form-label">Giá trị tối thiểu (VNĐ):</label>
            <form:input path="giaTriToiThieu" cssClass="form-control"/>
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
</body>
</html>
