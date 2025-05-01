<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- AOS CSS -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <style>
        body {
            background-color: #f2f6fc;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .dashboard-section {
            padding: 80px 0;
        }

        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 40px;
            text-align: center;
        }

        .card-dashboard {
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
            padding: 30px 20px;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
        }

        .card-dashboard:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .card-dashboard i {
            font-size: 2.8rem;
            margin-bottom: 15px;
        }

        .card-dashboard h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        a.text-decoration-none {
            text-decoration: none !important;
            color: inherit;
        }
    </style>
</head>
<body>



<section class="dashboard-section">
    <div class="container">
        <h2 class="dashboard-title" data-aos="fade-down">Admin Dashboard</h2>
        <div class="row g-4">

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-square-plus text-primary"></i>
                        <h4>SẢN PHẨM</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/admin/danhmuc/list" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-list text-warning"></i>
                        <h4>DANH MỤC</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/admin/mausac/list" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-table-list text-success"></i>
                        <h4>MÀU SẮC</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/admin/size/list" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-box-open text-warning"></i>
                        <h4>KÍCH THƯỚC</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/api/donhang/admin/list" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-circle-user text-primary"></i>
                        <h4>ĐƠN HÀNG</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/admin/ma-giam-gia" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-user-plus text-success"></i>
                        <h4>MÃ GIẢM GIÁ</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4" data-aos="zoom-in">
                <a href="${pageContext.request.contextPath}/admin/users?type=2" class="text-decoration-none">
                    <div class="card-dashboard">
                        <i class="fa-solid fa-circle-user text-danger"></i>
                        <h4>ADMIN</h4>
                    </div>
                </a>
            </div>

        </div>
    </div>
</section>



<!-- JS Libraries -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 1000,
        once: true
    });
</script>
</body>
</html>
