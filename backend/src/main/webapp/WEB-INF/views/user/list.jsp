<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Người dùng</title>
</head>
<body>

<h2>Danh sách Người dùng</h2>

<!-- Hiển thị thông báo nếu có -->
<c:if test="${not empty successMessage}">
    <p style="color: green;">${successMessage}</p>
</c:if>
<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>

<!-- Hiển thị danh sách người dùng -->
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Email</th>
        <th>Vai trò</th>
        <th>Chỉnh sửa</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id}</td>
            <td>${user.hoTen}</td>
            <td>${user.email}</td>
            <td>
                <c:forEach var="role" items="${user.roles}">
                    ${role.tenVaiTro} <br/>
                </c:forEach>
            </td>
            <td><a href="/admin/edit-roles/${user.id}">Chỉnh sửa Vai trò</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
