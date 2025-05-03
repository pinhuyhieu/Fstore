<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Chỉnh sửa Vai trò Người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f1f4f9;
            font-family: "Segoe UI", sans-serif;
        }

        .container {
            max-width: 800px;
            margin-top: 50px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            padding: 30px;
        }

        .form-label {
            font-weight: 600;
        }

        .btn i {
            margin-right: 4px;
        }

        .alert {
            transition: all 0.5s ease-in-out;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4 fw-bold" data-aos="fade-down">Chỉnh sửa Vai trò Người dùng</h2>

    <!-- Thông báo -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert" data-aos="zoom-in">
            <i class="bi bi-check-circle-fill"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert" data-aos="zoom-in">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card" data-aos="fade-up">
        <form method="post" action="${pageContext.request.contextPath}/admin/update-roles">
            <input type="hidden" name="userId" value="${user.id}" />

            <div class="mb-3">
                <label class="form-label">Tên người dùng:</label>
                <p class="form-control-plaintext fw-semibold">${user.hoTen}</p>
            </div>

            <div class="mb-3">
                <label class="form-label">Chọn Vai Trò:</label>
                <div>
                    <c:forEach var="role" items="${roles}">
                        <div class="form-check" data-aos="fade-left" data-aos-delay="100">
                            <input class="form-check-input" type="radio" name="roleId" value="${role.id}"
                                   id="role-${role.id}"
                                   <c:if test="${user.roles.contains(role)}">checked</c:if>>
                            <label class="form-check-label" for="role-${role.id}">
                                    ${role.tenVaiTro}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <button type="submit" class="btn btn-success me-2" data-aos="fade-right" data-aos-delay="300">
                <i class="bi bi-save"></i> Cập nhật vai trò
            </button>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary" data-aos="fade-right" data-aos-delay="400">
                <i class="bi bi-arrow-left-circle"></i> Quay lại
            </a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({
        duration: 800,
        once: true
    });
</script>
</body>
</html>
