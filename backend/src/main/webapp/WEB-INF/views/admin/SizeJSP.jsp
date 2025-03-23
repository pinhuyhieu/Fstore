<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Quản Lý Size</title>
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
    <h2 class="text-center mb-4">Quản Lý Size</h2>

    <!-- Form Thêm/Sửa Size -->
    <div class="form-section">
        <form method="POST" action="${pageContext.request.contextPath}/admin/size/save">
            <input type="hidden" name="id" value="${size.id}" />

            <div class="mb-3">
                <label for="tenSize" class="form-label">Tên Size:</label>
                <input type="text" class="form-control" id="tenSize" name="tenSize" value="${size.tenSize}" required>
            </div>

            <button type="submit" class="btn btn-success">
                <c:choose>
                    <c:when test="${empty size.id}">Thêm</c:when>
                    <c:otherwise>Cập nhật</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/size/list" class="btn btn-secondary">Hủy</a>
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
        <c:forEach var="s" items="${sizes}">
            <tr>
                <td>${s.id}</td>
                <td>${s.tenSize}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/size/edit/${s.id}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/size/delete/${s.id}"
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
