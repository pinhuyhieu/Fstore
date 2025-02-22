<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Quản Lý Danh Mục</title>
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
    <h2 class="text-center mb-4">Quản Lý Danh Mục</h2>

    <!-- Form Thêm/Sửa Danh Mục -->
    <div class="form-section">
        <form method="POST" action="${pageContext.request.contextPath}/danhmuc/save">
            <input type="hidden" name="id" value="${danhmuc.id}" />

            <div class="mb-3">
                <label for="tenDanhMuc" class="form-label">Tên Danh Mục:</label>
                <input type="text" class="form-control" id="tenDanhMuc" name="tenDanhMuc" value="${danhmuc.tenDanhMuc}" required>
            </div>

            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty danhmuc.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/danhmuc/list" class="btn btn-secondary">Hủy</a>
        </form>
    </div>

    <!-- Bảng Danh Sách Danh Mục -->
    <h4 class="mt-4">Danh Sách Danh Mục</h4>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Danh Mục</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="d" items="${danhmucs}">
            <tr>
                <td>${d.id}</td>
                <td>${d.tenDanhMuc}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/danhmuc/edit/${d.id}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/danhmuc/delete/${d.id}"
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

</body>
</html>
