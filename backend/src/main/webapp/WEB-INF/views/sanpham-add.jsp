<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Sản Phẩm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="mt-4">Thêm Sản Phẩm</h2>
    <form:form action="${pageContext.request.contextPath}/sanpham/add" modelAttribute="sanPham" method="post">
        <div class="mb-3">
            <label class="form-label">Tên Sản Phẩm</label>
            <form:input path="tenSanPham" class="form-control" required="true"/>
        </div>

        <div class="mb-3">
            <label class="form-label">Mô Tả</label>
            <form:textarea path="moTa" class="form-control"/>
        </div>

        <div class="mb-3">
            <label class="form-label">Giá Bán</label>
            <form:input path="giaBan" type="number" class="form-control" required="true"/>
        </div>

        <div class="mb-3">
            <label class="form-label">Danh Mục</label>
            <form:select path="danhMuc.id" class="form-control">
                <c:forEach var="dm" items="${danhmuc}">
                    <form:option value="${dm.id}" label="${dm.tenDanhMuc}"/>
                </c:forEach>
            </form:select>
        </div>

        <button type="submit" class="btn btn-primary">Thêm Sản Phẩm</button>
    </form:form>
</div>
</body>
</html>
