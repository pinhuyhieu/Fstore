<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setLocale value="vi_VN"/>

<html>
<head>
    <title>Danh Sách Đơn Hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        .btn-back {
            display: inline-block;
            background: linear-gradient(135deg, #4d9fef, #007bff);
            color: #fff;
            border: none;
            padding: 11px 18px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 10px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: linear-gradient(135deg, #007bff, #0056b3);
            box-shadow: 0 6px 18px rgba(0, 123, 255, 0.35);
            transform: translateY(-2px);
            color: #fff;
            text-decoration: none;
        }

        .btn-back:active {
            transform: scale(0.98);
            box-shadow: 0 3px 10px rgba(0, 123, 255, 0.3);
        }

        .search-input {
            padding: 10px 16px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            width: 250px;
            margin-right: 10px;
        }

        .search-input:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }


    </style>
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center mb-4" data-aos="fade-down">📦 Lịch Sử Đơn Hàng</h2>

    <!-- 🔍 Form tìm kiếm -->
    <form method="get" class="form-inline mb-3" data-aos="fade-up" data-aos-delay="100">
        <input type="text" name="keyword" class="search-input"
               placeholder="Nhập mã đơn hàng..." value="${keyword}">
        <button type="submit" class="btn btn-back">🔍 Tìm kiếm</button>
    </form>

    <!-- 🧾 Bảng đơn hàng -->
    <table class="table table-bordered table-hover" data-aos="zoom-in-up" data-aos-delay="200">
        <thead class="thead-dark">
        <tr>
            <th>#ID</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Thanh toán</th>
            <th>Phương thức</th>
            <th>Chi tiết</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="donHang" items="${donHangs}">
            <tr data-aos="fade-up" data-aos-delay="${status.index * 100}">
                <td>${donHang.id}</td>
                <td>
                        ${fn:substring(donHang.ngayDatHang, 0, 10)}
                        ${fn:substring(donHang.ngayDatHang, 11, 16)}
                </td>
                <td><fmt:formatNumber value="${donHang.tongTien}" type="number" maxFractionDigits="0"/> ₫</td>
                <td>
                    <span class="badge badge-info">${donHang.trangThai.hienThi}</span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${donHang.thanhToan.trangThaiThanhToan == 'DA_THANH_TOAN'}">
                            <span class="badge badge-success">Đã thanh toán</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-warning">Chưa thanh toán</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${donHang.phuongThucThanhToan.tenPhuongThuc}</td>
                <td>
                    <a href="/api/donhang/chi-tiet/${donHang.id}" class="btn btn-back">Xem</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/sanpham/list" class="btn btn-back"  data-aos="fade-right" data-aos-delay="300">Quay lại</a>
    <!-- 🔁 Phân trang -->
    <nav data-aos="fade-up" data-aos-delay="400">
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link btn-back" href="?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<!-- Bootstrap scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000, // Thời gian hiệu ứng (ms)
        easing: 'ease-in-out',
        once: true // Chỉ chạy 1 lần khi cuộn
    });
</script>

</body>
</html>
