<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
        }

        .text-center {
            text-align: center;
        }

        .fs-3 {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .col-md-4 {
            width: 30%;
            min-width: 250px;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 20px;
            transition: 0.3s;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card i {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .text-decoration-none {
            text-decoration: none;
            color: inherit;
        }

        .text-primary { color: #007bff; }
        .text-warning { color: #ffc107; }
        .text-success { color: #28a745; }

    </style>
</head>
<body>
<section>
    <div class="container">
        <p class="text-center fs-3 mt-4">Admin Dashboard</p>
        <div class="row">

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/sanpham/admin/add" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-square-plus text-primary"></i>
                        <h4>ADD PRODUCT</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/danhmuc/list" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-list text-warning"></i>
                        <h4>ADD CATEGORY</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/mausac/list" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-table-list text-success"></i>
                        <h4>ADD COLOR </h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/size/list" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-box-open text-warning"></i>
                        <h4>ADD SIZE</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/users?type=1" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-circle-user text-primary"></i>
                        <h4>Users</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/add-admin" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-user-plus text-primary"></i>
                        <h4>Add Admin</h4>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin/users?type=2" class="text-decoration-none">
                    <div class="card">
                        <i class="fa-solid fa-circle-user text-primary"></i>
                        <h4>Admin</h4>
                    </div>
                </a>
            </div>

        </div>
    </div>
</section>
</body>
</html>
