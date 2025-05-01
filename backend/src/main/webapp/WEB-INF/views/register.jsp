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
            padding: 12px 12px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            width: 450px;
            max-width: 90%;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-3px);
        }

        .logo {
            font-size: 20px;
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
            font-size: 14px;
            margin-bottom: 6px;
            color: #333;
        }

        label {
            font-weight: 600;
            display: block;
            margin: 4px 0 2px;
            color: #555;
            text-align: left;
            font-size: 12px;
        }

        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 6px;
            margin: 3px 0 6px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 12px;
            outline: none;
        }

        /* Thêm hiệu ứng khi hover vào các input */
        input[type="text"]:hover, input[type="password"]:hover, input[type="email"]:hover {
            border-color: #0984e3;  /* Màu sắc của viền khi hover */
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2), -4px -4px 8px rgba(9, 132, 227, 0.1);  /* Hiệu ứng đổ bóng */
        }

        /* Thêm hiệu ứng khi focus vào các input */
        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
            border-color: #0984e3;  /* Màu sắc của viền khi focus */
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4), -4px -4px 12px rgba(9, 132, 227, 0.2);  /* Hiệu ứng đổ bóng */
        }

        /* Thêm hiệu ứng khi hover vào các select */
        select:hover {
            border-color: #0984e3;  /* Màu sắc của viền khi hover */
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2), -4px -4px 8px rgba(9, 132, 227, 0.1);  /* Hiệu ứng đổ bóng */
        }

        /* Thêm hiệu ứng khi focus vào các select */
        select:focus {
            border-color: #0984e3;  /* Màu sắc của viền khi focus */
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4), -4px -4px 12px rgba(9, 132, 227, 0.2);  /* Hiệu ứng đổ bóng */
        }


        button {
            width: 100%;
            padding: 6px;
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
            margin-top: 5px;
            color: #0984e3;
            text-decoration: none;
            font-size: 11px;
        }

        a:hover {
            text-decoration: underline;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-top {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .form-top .form-group {
            width: calc(50% - 10px);
        }

        .form-bottom {
            margin-top: 20px;
        }

        .form-bottom .form-group {
            width: 100%;
        }
        .custom-alert {
            background-color: #ffe8e6;
            border: 1px solid #ff7675;
            color: #d63031;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 13px;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            margin-bottom: 12px;
            box-shadow: 0 4px 8px rgba(255, 118, 117, 0.2);
        }

        .custom-alert .alert-icon {
            font-size: 16px;
            margin-right: 8px;
        }

        .custom-alert .alert-text {
            flex: 1;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"], select {
            width: 100%;
            padding: 6px;
            margin: 3px 0 6px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 12px;
            outline: none;
        }

        input[type="tel"]:hover, input[type="text"]:hover, input[type="password"]:hover, input[type="email"]:hover {
            border-color: #0984e3;
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2), -4px -4px 8px rgba(9, 132, 227, 0.1);
        }

        input[type="tel"]:focus, input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
            border-color: #0984e3;
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4), -4px -4px 12px rgba(9, 132, 227, 0.2);
        }

        select:hover, select:focus {
            border-color: #0984e3;
            box-shadow: 0px 4px 8px rgba(9, 132, 227, 0.2), -4px -4px 8px rgba(9, 132, 227, 0.1);
        }

        select:focus {
            box-shadow: 0px 4px 12px rgba(9, 132, 227, 0.4), -4px -4px 12px rgba(9, 132, 227, 0.2);
        }
    </style>

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

            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Email không hợp lệ! Vui lòng nhập đúng định dạng.");
                return false;
            }

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
        <div class="custom-alert">
            <span class="alert-icon">⚠</span>
            <span class="alert-text">${error}</span>
        </div>
    </c:if>


    <form action="/doRegister" method="post" onsubmit="return validateForm();" novalidate>
        <div class="form-container">
            <!-- Phần 1: Thông tin cá nhân -->
            <div class="form-top">
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
                    <input type="tel" id="soDienThoai" name="soDienThoai" pattern="[0-9]{10,11}" oninput="this.value=this.value.replace(/[^0-9]/g, '')" maxlength="11">
                </div>
            </div>

            <!-- Phần 2: Thông tin địa chỉ -->
            <div class="form-top">
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
            </div>

            <!-- Phần dưới cùng: Mật khẩu + nút Đăng ký -->
            <div class="form-bottom">
                <div class="form-group">
                    <label for="matKhau">Mật khẩu:</label>
                    <input type="password" id="matKhau" name="matKhau">
                </div>

                <button type="submit">Đăng Ký</button>
            </div>
        </div>
    </form>

    <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
</div>

<script>
    $(document).ready(function () {
        $.ajax({
            url: '/api/ghn/provinces',
            method: 'GET',
            success: function (data) {
                var tinhThanhSelect = $('#tinhThanh');
                tinhThanhSelect.empty();
                tinhThanhSelect.append('<option value="">Chọn Tỉnh/Thành phố</option>');
                if (data && data.data) {
                    data.data.forEach(function (province) {
                        tinhThanhSelect.append('<option value="' + province.ProvinceID + '">' + province.ProvinceName + '</option>');
                    });
                }
            },
            error: function () {
                alert("Lỗi khi lấy danh sách tỉnh/thành phố.");
            }
        });

        $('#tinhThanh').change(function () {
            var provinceId = $(this).val();
            if (!provinceId) {
                alert("Vui lòng chọn Tỉnh/Thành phố");
                return;
            }

            $.ajax({
                url: '/api/ghn/districts/' + provinceId,
                method: 'GET',
                success: function (data) {
                    var quanHuyenSelect = $('#quanHuyen');
                    quanHuyenSelect.empty();
                    quanHuyenSelect.append('<option value="">Chọn Quận/Huyện</option>');
                    data.data.forEach(function (district) {
                        quanHuyenSelect.append('<option value="' + district.DistrictID + '">' + district.DistrictName + '</option>');
                    });
                },
                error: function () {
                    alert("Lỗi khi lấy danh sách quận/huyện.");
                }
            });
        });

        $('#quanHuyen').change(function () {
            var districtId = $(this).val();
            if (!districtId) {
                return;
            }

            $.ajax({
                url: '/api/ghn/wards/' + districtId,
                method: 'GET',
                success: function (data) {
                    var phuongXaSelect = $('#phuongXa');
                    phuongXaSelect.empty();
                    phuongXaSelect.append('<option value="">Chọn Phường/Xã</option>');
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
