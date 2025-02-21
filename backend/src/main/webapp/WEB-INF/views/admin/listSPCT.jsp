<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Sản phẩm Chi tiết</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4">Danh sách Chi tiết Sản phẩm</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Màu sắc</th>
            <th>Size</th>
            <th>Giá</th>
            <th>Số lượng tồn</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${chiTietList}" var="item">
            <tr>
                <td>${item.id}</td>
                <td>${item.mauSac.tenMauSac}</td>
                <td>${item.size.tenSize}</td>
                <td>${item.gia}</td>
                <td>${item.soLuongTon}</td>
                <td>
                    <a href="/sanphamchitiet/update/${item.id}" class="btn btn-primary btn-sm">Sửa</a>
                    <a href="/sanphamchitiet/delete/${item.id}" class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <form action="/sanphamchitiet/add/${sanPhamId}" method="post">

        <label>Size:</label>
        <select name="size.id">
            <c:forEach items="${sizeList}" var="size">
                <option value="${size.id}">${size.tenSize}</option>
            </c:forEach>
        </select>

        <label>Màu sắc:</label>
        <select name="mauSac.id">
            <c:forEach items="${mauSacList}" var="mau">
                <option value="${mau.id}">${mau.tenMauSac}</option>
            </c:forEach>
        </select>

        <label>Giá:</label>
        <input type="number" name="gia"/>

        <label>Số lượng:</label>
        <input type="number" name="soLuongTon"/>

        <button type="submit">Thêm</button>
    </form>



    <a href="/sanphamchitiet/add/${sanPhamId}" class="btn btn-success">Thêm Sản phẩm Chi tiết</a>
    <a href="/sanpham/list" class="btn btn-secondary">Quay lại danh sách Sản phẩm</a>
</div>
</body>
</html>
