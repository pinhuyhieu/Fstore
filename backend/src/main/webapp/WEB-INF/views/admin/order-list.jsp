<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
    <title>Quản lý đơn hàng</title>
    <!-- Bootstrap & AOS CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            background-color: #f2f6fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 50px;
        }

        .alert {
            text-align: center;
        }

        h2 {
            color: #0d6efd;
            font-weight: 700;
            text-align: center;
            margin-bottom: 30px;
        }

        .btn-primary {
            margin-bottom: 15px;
        }

        .table th {
            background-color: #0d6efd;
            color: white;
            text-align: center;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .card h5 {
            font-weight: 600;
        }

        .form-select, .form-control {
            border-radius: 10px;
        }

        .pagination .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <!-- ✅ Hiển thị thông báo -->
    <c:if test="${not empty successMessage}">
        <div id="success-alert" class="alert alert-success" data-aos="fade-down">
                ${successMessage}
        </div>
    </c:if>

    <h2 data-aos="fade-down">Danh Sách Đơn Hàng</h2>

    <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-primary" data-aos="fade-right">
        <i class="fa-solid fa-arrow-left"></i> Quay lại
    </a>

    <div class="row mt-3">
        <!-- 🔍 Bộ lọc -->
        <div class="col-md-3" data-aos="fade-right">
            <div class="card p-3 shadow-sm">
                <h5 class="text-primary">Bộ lọc</h5>
                <form method="get" action="/api/donhang/admin/list">
                    <div class="mb-2">
                        <label class="form-label">Từ ngày:</label>
                        <input type="date" name="tuNgay" class="form-control" value="${tuNgay}" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Đến ngày:</label>
                        <input type="date" name="denNgay" class="form-control" value="${denNgay}" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Trạng thái:</label>
                        <select name="trangThai" class="form-select">
                            <option value="">-- Tất cả --</option>
                            <c:forEach var="tt" items="${dsTrangThai}">
                                <option value="${tt}" <c:if test="${tt == trangThai}">selected</c:if>>${tt.hienThi}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Trạng thái thanh toán:</label>
                        <select name="trangThaiThanhToan" class="form-select">
                            <option value="">-- Tất cả --</option>
                            <option value="DA_THANH_TOAN" ${trangThaiThanhToan == 'DA_THANH_TOAN' ? 'selected' : ''}>Đã thanh toán</option>
                            <option value="CHUA_THANH_TOAN" ${trangThaiThanhToan == 'CHUA_THANH_TOAN' ? 'selected' : ''}>Chưa thanh toán</option>
                        </select>
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Giá từ:</label>
                        <input type="number" name="minGia" class="form-control" step="1000" value="${minGia}" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Giá đến:</label>
                        <input type="number" name="maxGia" class="form-control" step="1000" value="${maxGia}" />
                    </div>
                    <div class="mb-2">
                        <label class="form-label">Tìm kiếm:</label>
                        <input type="text" name="keyword" class="form-control" placeholder="ID, tên, SĐT..." value="${keyword}" />
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                </form>
            </div>
        </div>

        <!-- 📦 Danh sách -->
        <div class="col-md-9" data-aos="fade-left">
            <table class="table table-bordered table-hover mt-3">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Người Đặt</th>
                    <th>Số ĐT</th>
                    <th>Ngày Đặt</th>
                    <th>Tổng Tiền</th>
                    <th>Trạng Thái</th>
                    <th>Thanh Toán</th>
                    <th>Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="donHang" items="${donHangs}">
                    <tr>
                        <td>${donHang.id}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty donHang.user.hoTen}">${donHang.user.hoTen}</c:when>
                                <c:otherwise><span class="text-danger">Không có thông tin</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${donHang.soDienThoaiNguoiNhan}</td>
                        <td>${fn:substring(donHang.ngayDatHang, 0, 10)} ${fn:substring(donHang.ngayDatHang, 11, 16)}</td>
                        <td><fmt:formatNumber value="${donHang.tongTien}" type="currency" currencyCode="VND" /></td>
                        <td>
                            <c:choose>
                                <c:when test="${donHang.trangThai.name() == 'HOAN_TAT' || donHang.trangThai.name() == 'DA_HUY'}">
                                    <span class="badge bg-secondary">${donHang.trangThai.hienThi}</span>
                                </c:when>
                                <c:otherwise>
                                    <form action="/api/donhang/admin/update-status/${donHang.id}" method="POST">
                                        <select name="trangThai" class="form-select form-select-sm" onchange="confirmChange(this)">
                                            <c:forEach var="tt" items="${dsTrangThai}">
                                                <option value="${tt.name()}" ${tt == donHang.trangThai ? 'selected' : ''}>${tt.hienThi}</option>
                                            </c:forEach>
                                        </select>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${donHang.thanhToan.trangThaiThanhToan == 'DA_THANH_TOAN'}">
                                    <span class="text-success fw-bold">Đã thanh toán</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-danger fw-bold">Chưa thanh toán</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="text-center">
                            <a href="/api/donhang/chi-tiet/${donHang.id}" class="btn btn-sm btn-outline-primary">🔍 Xem</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- 🔁 Phân trang -->
            <nav>
                <ul class="pagination justify-content-center">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link"
                               href="?page=${i}&keyword=${keyword}&tuNgay=${tuNgay}&denNgay=${denNgay}&trangThai=${trangThai}&minGia=${minGia}&maxGia=${maxGia}&trangThaiThanhToan=${trangThaiThanhToan}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 1000, once: true });

    // Ẩn alert sau 3s
    setTimeout(function () {
        const alertBox = document.getElementById("success-alert");
        if (alertBox) alertBox.classList.add("hidden");
    }, 3000);

    function confirmChange(selectElement) {
        const form = selectElement.form;
        const selectedText = selectElement.options[selectElement.selectedIndex].text;
        const xacNhan = confirm("Bạn có chắc muốn đổi trạng thái đơn hàng thành: " + selectedText + "?");
        if (xacNhan) {
            form.submit();
        } else {
            form.reset();
        }
    }
</script>

</body>
</html>
