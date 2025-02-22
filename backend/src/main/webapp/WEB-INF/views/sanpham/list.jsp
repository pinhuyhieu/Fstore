<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .product-card {
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .product-card h5 {
            font-size: 18px;
            font-weight: bold;
        }
        .product-card p {
            font-size: 14px;
            color: #666;
        }
        .btn-action {
            margin: 5px 0;
        }
    </style>
</head>
<body>

<%@ include file="../include/header.jsp" %>

<div class="container mt-4">
    <h1 class="mb-4">Danh sách sản phẩm</h1>
    <div class="row">
        <!-- SIDEBAR (col-lg-3) -->
        <div class="col-lg-3 col-md-4">
            <aside>
                <h4>Danh mục</h4>
                <ul class="list-group mb-4">
                    <c:forEach var="dm" items="${danhmuc}">
                        <li class="list-group-item">
                            <!-- Giả sử bạn muốn link đến /sanpham?danhMucID=xx -->
                            <a href="${pageContext.request.contextPath}/sanpham?danhMucID=${dm.id}">
                                    ${dm.tenDanhMuc}
                            </a>
                        </li>
                    </c:forEach>
                </ul>

                <!-- Bạn có thể thêm các phần sidebar khác như bộ lọc giá, top sản phẩm, v.v. -->
                <h4>Bộ lọc giá (ví dụ)</h4>
                <div class="mb-4">
                    <!-- Tùy ý, demo thôi -->
                    <form action="#" method="get">
                        <label for="minPrice">Giá tối thiểu</label>
                        <input type="number" class="form-control" name="minPrice" id="minPrice" />
                        <label for="maxPrice" class="mt-2">Giá tối đa</label>
                        <input type="number" class="form-control" name="maxPrice" id="maxPrice" />
                        <button type="submit" class="btn btn-primary mt-2">Lọc</button>
                    </form>
                </div>
            </aside>
        </div>

        <!-- DANH SÁCH SẢN PHẨM (col-lg-9) -->
        <div class="col-lg-9 col-md-8">
            <a class="btn btn-primary mb-3"
               href="${pageContext.request.contextPath}/sanpham/create">Thêm Sản Phẩm</a>

            <div class="row">
                <c:forEach var="sp" items="${dsSanPham}">
                    <div class="col-md-4">
                        <div class="product-card">
                            <c:choose>
                                <c:when test="${not empty sp.hinhAnhs}">
                                    <img src="${pageContext.request.contextPath}/${sp.hinhAnhs[0].duongDan}"
                                         alt="${sp.tenSanPham}" />
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/300"
                                         alt="Ảnh mặc định" />
                                </c:otherwise>
                            </c:choose>
                            <h5>${sp.tenSanPham}</h5>
                            <p>Giá: <b>${sp.giaBan} ₫</b></p>
                            <p>${sp.moTa}</p>
                            <div>
                                <!-- Tùy ý đổi text nút -->
                                <a class="btn btn-info btn-sm btn-action"
                                   href="${pageContext.request.contextPath}/sanpham/edit/${sp.id}">
                                    Mua ngay
                                </a>
                                <br>
                                <a class="btn btn-danger btn-sm btn-action"
                                   href="${pageContext.request.contextPath}/sanpham/delete/${sp.id}">
                                    Thêm vào giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
