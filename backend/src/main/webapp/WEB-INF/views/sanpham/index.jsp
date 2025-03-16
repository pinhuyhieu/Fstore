<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>

<div class="container mt-5">
    <div class="row">
        <!-- Sidebar for Categories -->
        <div class="col-lg-3">
            <div class="sidebar">
                <h4>Danh mục sản phẩm</h4>
                <ul class="list-group">
                    <c:forEach var="dm" items="${danhmuc}">
                        <a href="${pageContext.request.contextPath}/sanpham?danhMucID=${dm.id}" class="list-group-item list-group-item-action">
                                ${dm.tenDanhMuc}
                        </a>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <!-- Main Content for Products -->
        <div class="col-lg-9">
            <h1 class="mb-4">Sản phẩm nổi bật</h1>
            <div class="row">
                <c:forEach var="sp" items="${dsSanPham}">
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/${sp.hinhAnhs[0].duongDan}" class="card-img-top" alt="${sp.tenSanPham}">
                            <div class="card-body">
                                <h5 class="card-title">${sp.tenSanPham}</h5>
                                <p class="card-text">Giá: <b>${sp.giaBan} ₫</b></p>
                                <a href="${pageContext.request.contextPath}/sanpham/detail/${sp.id}" class="btn btn-primary">Xem chi tiết</a>
                                <a href="${pageContext.request.contextPath}/sanpham/cart/add/${sp.id}" class="btn btn-secondary">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>
