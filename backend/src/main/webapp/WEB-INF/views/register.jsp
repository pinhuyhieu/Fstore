
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - Fstore</title>
    <style>
        body {
            background: linear-gradient(135deg, #74b9ff, #0984e3);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 15px 15px; /* Giảm padding để thu nhỏ chiều dài */
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            width: 280px;  /* Thu nhỏ form */
            text-align: center;
            transition: transform 0.3s ease;

        }

        .container:hover {
            transform: translateY(-3px);
        }

        .logo {
            font-size: 20px;  /* Giảm kích thước logo */
            font-weight: bold;
            color: #0984e3;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-block;
            padding-bottom: 2px;
        }

        .logo::after {
            content: "";
            display: block;
            width: 40%;
            height: 2px;
            background-color: #0984e3;
            margin: 4px auto 0;
            border-radius: 2px;
        }

        h2 {
            font-size: 14px; /* Thu nhỏ tiêu đề */
            margin-bottom: 6px;
            color: #333;
        }

        label {
            font-weight: 600;
            display: block;
            margin: 4px 0 2px; /* Giảm margin giữa các label */
            color: #555;
            text-align: left;
            font-size: 12px;
        }

        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 6px;  /* Giảm padding để nhỏ hơn */
            margin: 3px 0 6px;  /* Giảm khoảng cách */
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 12px;
            outline: none;
        }

        input[type="text"]:hover, input[type="password"]:hover {
            border-color: #0984e3;
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2),
            -4px -4px 8px rgba(9, 132, 227, 0.1);
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #0984e3;
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4),
            -4px -4px 12px rgba(9, 132, 227, 0.2);
        }


        button {
            width: 100%;
            padding: 6px; /* Giảm kích thước nút */
            background-color: #0984e3;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 13px;
            font-weight: bold;
            margin-top: 6px;
        }

        button:hover {
            background-color: #74b9ff;
            transform: translateY(-2px);
        }

        p, a {
            margin-top: 5px; /* Giảm margin dưới cùng */
            color: #0984e3;
            text-decoration: none;
            font-size: 11px;
        }

        a:hover {
            text-decoration: underline;
        }

        .form-group {
            margin-bottom: 5px; /* Giảm khoảng cách giữa các input  */
            text-align: left;
        }
    </style>
    <!-- Thêm vào trong <head> hoặc trước </body> -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function validateForm() {
            const hoTen = document.getElementById("hoTen").value.trim();
            const tenDangNhap = document.getElementById("tenDangNhap").value.trim();
            const email = document.getElementById("email").value.trim();
            const soDienThoai = document.getElementById("soDienThoai").value.trim();
            const diaChi = document.getElementById("diaChi").value.trim();
            const matKhau = document.getElementById("matKhau").value.trim();

            if (hoTen === "" || tenDangNhap === "" || diaChi === "" || email === "" || matKhau === "") {
                alert("Vui lòng nhập đầy đủ thông tin bắt buộc!");
                return false;
            }

            // Kiểm tra định dạng email
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Email không hợp lệ! Vui lòng nhập đúng định dạng.");
                return false;
            }

            // Kiểm tra định dạng số điện thoại (tùy chọn)
            const phonePattern = /^[0-9]{10,11}$/;
            if (soDienThoai !== "" && !phonePattern.test(soDienThoai)) {
                alert("Số điện thoại không hợp lệ! Vui lòng nhập 10-11 chữ số.");
                return false;
            }

            return true;
        }
    </script>

</head>
<body>

<div class="container">
    <div class="logo">Fstore</div>
    <h2>Đăng Ký Tài Khoản</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/doRegister" method="post" onsubmit="return validateForm();" novalidate>
        <div class="form-group">
            <label for="hoTen">Họ và tên:</label>
            <input type="text" id="hoTen" name="hoTen">
        </div>

        <div class="form-group">
            <label for="tenDangNhap">Tên đăng nhập:</label>
            <input type="text" id="tenDangNhap" name="tenDangNhap">
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email">
        </div>

        <div class="form-group">
            <label for="soDienThoai">Số điện thoại:</label>
            <input type="text" id="soDienThoai" name="soDienThoai">
        </div>

        <div class="form-group">
            <label for="tinhThanh">Tỉnh/Thành phố:</label>
            <select id="tinhThanh" name="tenTinhThanh" required></select>
        </div>

        <div class="form-group">
            <label for="quanHuyen">Quận/Huyện:</label>
            <select id="quanHuyen" name="tenQuanHuyen" required></select>
        </div>

        <div class="form-group">
            <label for="phuongXa">Phường/Xã:</label>
            <select id="phuongXa" name="tenPhuongXa" required></select>
        </div>

        <div class="form-group">
            <label for="diaChiChiTiet">Địa chỉ chi tiết (số nhà, đường...):</label>
            <input type="text" id="diaChiChiTiet" name="diaChiChiTiet">
        </div>

        <div class="form-group">
            <label for="matKhau">Mật khẩu:</label>
            <input type="password" id="matKhau" name="matKhau">
        </div>

        <button type="submit">Đăng Ký</button>
    </form>

    <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
</div>
<script>
    $(document).ready(function () {
        // Lấy Tỉnh/Thành phố khi trang được tải
        $.ajax({
            url: '/api/ghn/provinces',  // API lấy danh sách Tỉnh/Thành phố
            method: 'GET',
            success: function (data) {
                console.log('Dữ liệu tỉnh thành:', data);  // Kiểm tra dữ liệu trả về
                var tinhThanhSelect = $('#tinhThanh');
                tinhThanhSelect.empty();  // Xóa các tùy chọn cũ
                tinhThanhSelect.append('<option value="">Chọn Tỉnh/Thành phố</option>');  // Thêm lựa chọn mặc định

                // Kiểm tra nếu không có data hoặc data.data
                if (data && data.data) {
                    data.data.forEach(function (province) {
                        tinhThanhSelect.append('<option value="' + province.ProvinceID  + '">' + province.ProvinceName  + '</option>');
                    });
                } else {
                    alert("Không có dữ liệu tỉnh/thành phố.");
                }
            },
            error: function () {
                alert("Lỗi khi lấy danh sách tỉnh/thành phố.");
            }
        });

        // Lấy danh sách Quận/Huyện khi người dùng chọn Tỉnh/Thành phố
        $('#tinhThanh').change(function () {
            var provinceId = $(this).val();  // Lấy giá trị provinceId từ dropdown

            // Kiểm tra xem provinceId có hợp lệ không (không phải "undefined" hoặc rỗng)
            if (!provinceId) {
                alert("Vui lòng chọn Tỉnh/Thành phố");
                return;  // Không thực hiện AJAX nếu không chọn Tỉnh
            }

            $.ajax({
                url: '/api/ghn/districts/' + provinceId,  // Gọi API để lấy Quận/Huyện theo provinceId
                method: 'GET',
                success: function (data) {
                    console.log('Dữ liệu tỉnh thành:', data);
                    var quanHuyenSelect = $('#quanHuyen');
                    quanHuyenSelect.empty(); // Xóa các tùy chọn cũ
                    quanHuyenSelect.append('<option value="">Chọn Quận/Huyện</option>');  // Thêm lựa chọn mặc định

                    // Duyệt qua dữ liệu và thêm các quận huyện vào dropdown
                    data.data.forEach(function (district) {
                        quanHuyenSelect.append('<option value="' + district.DistrictID + '">' + district.DistrictName + '</option>');
                    });
                },
                error: function () {
                    alert("Lỗi khi lấy danh sách quận/huyện.");
                }
            });
        });

        // Lấy danh sách Phường/Xã khi người dùng chọn Quận/Huyện
        $('#quanHuyen').change(function () {
            var districtId = $(this).val();  // Lấy giá trị districtId từ dropdown

            // Kiểm tra xem districtId có hợp lệ không
            if (!districtId) {
                return;  // Không thực hiện AJAX nếu không chọn Quận/Huyện
            }

            $.ajax({
                url: '/api/ghn/wards/' + districtId,  // Gọi API để lấy Phường/Xã theo districtId
                method: 'GET',
                success: function (data) {
                    console.log('Dữ liệu tỉnh thành:', data);
                    var phuongXaSelect = $('#phuongXa');
                    phuongXaSelect.empty(); // Xóa các tùy chọn cũ
                    phuongXaSelect.append('<option value="">Chọn Phường/Xã</option>');  // Thêm lựa chọn mặc định

                    // Duyệt qua dữ liệu và thêm các phường xã vào dropdown
                    data.data.forEach(function (ward) {
                        phuongXaSelect.append('<option value="' + ward.WardCode + '">' + ward.WardName + '</option>');
                    });
                },
                error: function () {
                    alert("Lỗi khi lấy danh sách phường/xã.");
                }

            });
        });
    });


</script>


</body>
</html>