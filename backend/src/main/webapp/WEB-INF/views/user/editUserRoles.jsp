<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Vai trò Người dùng</title>
</head>
<body>

<h2>Chỉnh sửa Vai trò Người dùng</h2>

<!-- Hiển thị thông báo nếu có -->
<c:if test="${not empty successMessage}">
    <p style="color: green;">${successMessage}</p>
</c:if>
<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>

<form action="${pageContext.request.contextPath}/user/update-roles" method="post">
    <input type="hidden" name="userId" value="${user.id}" />

    <h3>Tên người dùng:</h3>
    <p>${user.hoTen}</p>

    <h3>Chọn Vai Trò:</h3>
    <c:forEach var="role" items="${roles}">
        <label>
            <!-- Sử dụng radio button cho phép chọn một vai trò duy nhất -->
            <input type="radio" name="roleId" value="${role.id}"
                   <c:if test="${user.roles.contains(role)}">checked</c:if> /> ${role.tenVaiTro}
        </label><br/>
    </c:forEach>

    <button type="submit">Cập nhật vai trò</button>
</form>

</body>
</html>
