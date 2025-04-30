<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Quản Lý Màu Sắc</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .container { max-width: 800px; margin-top: 30px; }
        table { margin-top: 20px; }
        .btn-sm { padding: 5px 10px; font-size: 14px; }
        .form-section { padding: 20px; background-color: #f9f9f9; border-radius: 8px; box-shadow: 0px 0px 10px #ccc; }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Quản Lý Màu Sắc</h2>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <!-- Form Thêm/Sửa Màu Sắc -->
    <div class="form-section">
        <form method="POST" action="${pageContext.request.contextPath}/admin/mausac/save" class="needs-validation" novalidate>
            <input type="hidden" name="id" value="${mausac.id}" />

            <div class="mb-3">
                <label for="tenMauSac" class="form-label">Tên Màu Sắc:</label>
                <input type="text" class="form-control" id="tenMauSac" name="tenMauSac"
                       value="${mausac.tenMauSac}" required minlength="2" maxlength="30"
                       pattern="^[a-zA-ZÀ-ỹ0-9 ]+$" oninput="validateInput()">
                <div class="invalid-feedback">Màu sắc không được để trống.</div>
            </div>

            <button type="submit" class="btn btn-success">
                <c:choose>
                    <c:when test="${empty mausac.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/admin/mausac/list" class="btn btn-secondary">Hủy</a>
            <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary">Quay lại</a>
        </form>
    </div>

    <!-- Bảng Danh Sách Size -->
    <h4 class="mt-4">Danh Sách Size</h4>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Size</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="s" items="${mausacs}">
            <tr>
                <td>${s.id}</td>
                <td>${s.tenMauSac}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/mausac/edit/${s.id}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/mausac/delete/${s.id}"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa?');">
                        Xóa
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    function validateInput() {
        let input = document.getElementById("tenDanhMuc");
        let regex = /^[a-zA-ZÀ-ỹ0-9 ]+$/;
        if (!regex.test(input.value)) {
            input.setCustomValidity("Tên danh mục không được chứa ký tự đặc biệt.");
        } else {
            input.setCustomValidity("");
        }
    }
</script>
</body>
</html>
