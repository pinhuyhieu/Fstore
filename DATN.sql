-- ================================================
-- 1. Tạo Cơ Sở Dữ Liệu và Chuyển Sử Dụng
-- ================================================
-- Nếu cơ sở dữ liệu đã tồn tại, bạn có thể xóa nó trước khi tạo lại
IF
EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'QuanLyBanQuanAo')
BEGIN
    DROP
DATABASE QuanLyBanQuanAo;
END
GO

-- Tạo cơ sở dữ liệu QuanLyBanQuanAo
CREATE
DATABASE QuanLyBanQuanAo;
GO

-- Sử dụng cơ sở dữ liệu QuanLyBanQuanAo
USE QuanLyBanQuanAo;
GO

-- ================================================
-- 2. Tạo Các Bảng Chính và Bảng Phụ
-- ================================================

-- a. Bảng PhuongThucThanhToan (Payment Methods)
CREATE TABLE PhuongThucThanhToan
(
    PhuongThucID  INT IDENTITY(1,1) PRIMARY KEY,
    TenPhuongThuc NVARCHAR(100) NOT NULL
);
GO

-- b. Bảng DanhMuc (Categories)
CREATE TABLE DanhMuc
(
    DanhMucID  INT IDENTITY(1,1) PRIMARY KEY,
    TenDanhMuc NVARCHAR(255) NOT NULL,
    MoTa       NVARCHAR( MAX),
    NgayTao    DATETIME DEFAULT GETDATE()
);
GO

-- c. Bảng Size
CREATE TABLE Size
(
    SizeID  INT IDENTITY(1,1) PRIMARY KEY,
    TenSize NVARCHAR(50) NOT NULL
);
GO

-- d. Bảng MauSac (Colors)
CREATE TABLE MauSac
(
    MauSacID  INT IDENTITY(1,1) PRIMARY KEY,
    TenMauSac NVARCHAR(50) NOT NULL
);
GO

-- e. Bảng SanPham (Products)
CREATE TABLE SanPham
(
    SanPhamID  INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(255) NOT NULL,
    MoTa       NVARCHAR( MAX),
    DanhMucID  INT            NOT NULL,
    GiaBan     DECIMAL(10, 2) NOT NULL,
    SoLuongTon INT            NOT NULL,
    NgayTao    DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DanhMucID) REFERENCES DanhMuc (DanhMucID)
);
GO

-- f. Bảng SanPhamChiTiet (Product Details/Variants)
CREATE TABLE SanPhamChiTiet
(
    SanPhamChiTietID INT IDENTITY(1,1) PRIMARY KEY,
    SanPhamID        INT            NOT NULL,
    SizeID           INT            NOT NULL,
    MauSacID         INT            NOT NULL,
    Gia              DECIMAL(10, 2) NOT NULL,
    SoLuongTon       INT            NOT NULL,
    FOREIGN KEY (SanPhamID) REFERENCES SanPham (SanPhamID)
        ON DELETE CASCADE,
    FOREIGN KEY (SizeID) REFERENCES Size (SizeID)
        ON DELETE CASCADE,
    FOREIGN KEY (MauSacID) REFERENCES MauSac (MauSacID)

);
GO

-- g. Bảng NguoiDung (Users)
CREATE TABLE NguoiDung
(
    NguoiDungID INT IDENTITY(1,1) PRIMARY KEY,
    Ten         NVARCHAR(255) NOT NULL,
    Email       NVARCHAR(255) NOT NULL UNIQUE,
    MatKhau     NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(20),
    DiaChi      NVARCHAR( MAX),
    NgayTao     DATETIME DEFAULT GETDATE()
);
GO

-- h. Bảng DiaChiNguoiDung (User Addresses)
CREATE TABLE DiaChiNguoiDung
(
    DiaChiID    INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT NOT NULL,
    TenDiaChi   NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(20),
    DiaChi      NVARCHAR( MAX) NOT NULL,
    FOREIGN KEY (NguoiDungID) REFERENCES NguoiDung (NguoiDungID)
        ON DELETE CASCADE
);
GO

-- i. Bảng KhuyenMai (Promotions)
CREATE TABLE KhuyenMai
(
    KhuyenMaiID  INT IDENTITY(1,1) PRIMARY KEY,
    TenKhuyenMai NVARCHAR(255) NOT NULL,
    MoTa         NVARCHAR( MAX),
    GiaTri       DECIMAL(10, 2),
    NgayBatDau   DATETIME,
    NgayKetThuc  DATETIME
);
GO

-- j. Bảng GiamGiaSanPham (Discounts on Products)
CREATE TABLE GiamGiaSanPham
(
    GiamGiaSanPhamID INT IDENTITY(1,1) PRIMARY KEY,
    KhuyenMaiID      INT NOT NULL,
    SanPhamID        INT NOT NULL,
    FOREIGN KEY (KhuyenMaiID) REFERENCES KhuyenMai (KhuyenMaiID)
        ON DELETE CASCADE,
    FOREIGN KEY (SanPhamID) REFERENCES SanPham (SanPhamID)

);
GO

-- k. Bảng HinhAnhSanPham (Product Images)
CREATE TABLE HinhAnhSanPham
(
    HinhAnhID INT IDENTITY(1,1) PRIMARY KEY,
    SanPhamID INT NOT NULL,
    DuongDan  NVARCHAR(255) NOT NULL,
    FOREIGN KEY (SanPhamID) REFERENCES SanPham (SanPhamID)

);
GO

-- l. Bảng DonHang (Orders)
CREATE TABLE DonHang
(
    DonHangID             INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID           INT            NOT NULL,
    NgayDat               DATETIME DEFAULT GETDATE(),
    TongTien              DECIMAL(10, 2) NOT NULL,
    TrangThai             NVARCHAR(50) NOT NULL DEFAULT 'ChoXuLy',
    TenNguoiNhan          NVARCHAR(255) NOT NULL,
    SoDienThoaiNguoiNhan  NVARCHAR(20) NOT NULL,
    DiaChiGiaoHang        NVARCHAR( MAX) NOT NULL,
    PhuongThucThanhToanID INT,
    FOREIGN KEY (NguoiDungID) REFERENCES NguoiDung (NguoiDungID)
        ON DELETE CASCADE,
    FOREIGN KEY (PhuongThucThanhToanID) REFERENCES PhuongThucThanhToan (PhuongThucID)
        ON DELETE SET NULL
);
GO

-- m. Bảng ChiTietDonHang (Order Details)
CREATE TABLE ChiTietDonHang
(
    ChiTietDonHangID INT IDENTITY(1,1) PRIMARY KEY,
    DonHangID        INT            NOT NULL,
    SanPhamChiTietID INT            NOT NULL,
    SoLuong          INT            NOT NULL,
    Gia              DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (DonHangID) REFERENCES DonHang (DonHangID)
        ON DELETE CASCADE,
    FOREIGN KEY (SanPhamChiTietID) REFERENCES SanPhamChiTiet (SanPhamChiTietID)
        ON DELETE CASCADE
);
GO

-- n. Bảng ThanhToan (Payments)
CREATE TABLE ThanhToan
(
    ThanhToanID   INT IDENTITY(1,1) PRIMARY KEY,
    DonHangID     INT            NOT NULL,
    PhuongThucID  INT            NOT NULL,
    SoTien        DECIMAL(10, 2) NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DonHangID) REFERENCES DonHang (DonHangID)
        ON DELETE CASCADE,
    FOREIGN KEY (PhuongThucID) REFERENCES PhuongThucThanhToan (PhuongThucID)
        ON DELETE CASCADE
);
GO

-- o. Bảng DanhGia (Reviews)
CREATE TABLE DanhGia
(
    DanhGiaID   INT IDENTITY(1,1) PRIMARY KEY,
    SanPhamID   INT NOT NULL,
    NguoiDungID INT NOT NULL,
    SoSao       INT CHECK (SoSao BETWEEN 1 AND 5),
    NoiDung     NVARCHAR( MAX),
    NgayDanhGia DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (SanPhamID) REFERENCES SanPham (SanPhamID)
        ON DELETE CASCADE,
    FOREIGN KEY (NguoiDungID) REFERENCES NguoiDung (NguoiDungID)

);
GO

-- ================================================
-- 3. Tạo Các Chỉ Mục (Indexes)
-- ================================================

-- a. Chỉ Mục trên Bảng SanPham
CREATE
INDEX idx_sanpham_danhmucid ON SanPham(DanhMucID);
GO

CREATE
INDEX idx_sanpham_tensp ON SanPham(TenSanPham);
GO

-- b. Chỉ Mục trên Bảng SanPhamChiTiet
CREATE
INDEX idx_sanphamchitiet_sanphamid ON SanPhamChiTiet(SanPhamID);
GO

CREATE
INDEX idx_sanphamchitiet_sizeid ON SanPhamChiTiet(SizeID);
GO

CREATE
INDEX idx_sanphamchitiet_mausacid ON SanPhamChiTiet(MauSacID);
GO

-- Tạo chỉ mục phức hợp nếu cần thiết
CREATE
INDEX idx_sanphamchitiet_size_mausac ON SanPhamChiTiet(SizeID, MauSacID);
GO

-- c. Chỉ Mục trên Bảng DonHang
CREATE
INDEX idx_donhang_nguoidungid ON DonHang(NguoiDungID);
GO

CREATE
INDEX idx_donhang_trangthai ON DonHang(TrangThai);
GO

-- d. Chỉ Mục trên Bảng ChiTietDonHang
CREATE
INDEX idx_chitietdonhang_donhangid ON ChiTietDonHang(DonHangID);
GO

CREATE
INDEX idx_chitietdonhang_sanphamchitietid ON ChiTietDonHang(SanPhamChiTietID);
GO

-- e. Chỉ Mục trên Bảng NguoiDung
-- Email đã được chỉ định UNIQUE, không cần tạo chỉ mục thêm
-- Nếu cần tìm kiếm theo tên
CREATE
INDEX idx_nguoidung_ten ON NguoiDung(Ten);
GO

-- f. Chỉ Mục trên Bảng DanhMuc
CREATE
INDEX idx_danhmuc_tendanhmuc ON DanhMuc(TenDanhMuc);
GO

-- g. Chỉ Mục trên Bảng DanhGia
CREATE
INDEX idx_danhgia_sanphamid ON DanhGia(SanPhamID);
GO

CREATE
INDEX idx_danhgia_nguoidungid ON DanhGia(NguoiDungID);
GO

CREATE
INDEX idx_danhgia_sosao ON DanhGia(SoSao);
GO

-- h. Chỉ Mục trên Bảng HinhAnhSanPham
CREATE
INDEX idx_hinhanhsanpham_sanphamid ON HinhAnhSanPham(SanPhamID);
GO

-- i. Chỉ Mục trên Bảng PhuongThucThanhToan và ThanhToan
CREATE
INDEX idx_phuongthucthanhtoan_ten ON PhuongThucThanhToan(TenPhuongThuc);
GO

CREATE
INDEX idx_thanhtoan_donhangid ON ThanhToan(DonHangID);
GO

CREATE
INDEX idx_thanhtoan_phuongthucid ON ThanhToan(PhuongThucID);
GO

CREATE
INDEX idx_diachinguoidung_diachiid ON DiaChiNguoiDung(NguoiDungID);
GO

-- ================================================
-- 4. Thêm Dữ Liệu Mẫu (Sample Data)
-- ================================================

-- a. Thêm Dữ Liệu vào PhuongThucThanhToan
INSERT INTO PhuongThucThanhToan (TenPhuongThuc) VALUES
('Thanh Toán Khi Nhận Hàng'),  -- Cash on Delivery
('Chuyển Khoản Ngân Hàng'),      -- Bank Transfer
('Thanh Toán Qua Thẻ Visa/MasterCard'), -- Credit Card
('Thanh Toán Qua Ví Momo');      -- Momo Wallet
GO

-- b. Thêm Dữ Liệu vào DanhMuc
INSERT INTO DanhMuc (TenDanhMuc, MoTa) VALUES
('Áo Nam', 'Các loại áo dành cho nam giới'),
('Áo Nữ', 'Các loại áo dành cho nữ giới'),
('Quần Nam', 'Các loại quần dành cho nam giới'),
('Quần Nữ', 'Các loại quần dành cho nữ giới');
GO

-- c. Thêm Dữ Liệu vào Size
INSERT INTO Size (TenSize) VALUES
('S'),
('M'),
('L'),
('XL'),
('XXL');
GO

-- d. Thêm Dữ Liệu vào MauSac
INSERT INTO MauSac (TenMauSac) VALUES
('Đỏ'),
('Xanh'),
('Đen'),
('Trắng'),
('Vàng'),
('Hồng');
GO

-- e. Thêm Dữ Liệu vào SanPham
INSERT INTO SanPham (TenSanPham, MoTa, DanhMucID, GiaBan, SoLuongTon) VALUES
('Áo Thun Nam', 'Áo thun cotton chất lượng cao dành cho nam giới.', 1, 200000.00, 50),
('Áo Sơ Mi Nữ', 'Áo sơ mi lụa mềm mại cho nữ giới.', 2, 350000.00, 30),
('Quần Jeans Nam', 'Quần jeans nam phong cách cổ điển.', 3, 500000.00, 40),
('Quần Short Nữ', 'Quần short nữ nhẹ nhàng, thoáng mát.', 4, 250000.00, 25);
GO

-- f. Thêm Dữ Liệu vào SanPhamChiTiet
INSERT INTO SanPhamChiTiet (SanPhamID, SizeID, MauSacID, Gia, SoLuongTon) VALUES
-- Variants for 'Áo Thun Nam' (SanPhamID = 1)
(1, 1, 3, 200000.00, 10), -- Size S, Màu Đen
(1, 2, 2, 200000.00, 15), -- Size M, Màu Xanh
(1, 3, 1, 200000.00, 10), -- Size L, Màu Đỏ

-- Variants for 'Áo Sơ Mi Nữ' (SanPhamID = 2)
(2, 2, 4, 350000.00, 10), -- Size M, Màu Trắng
(2, 3, 5, 350000.00, 10), -- Size L, Màu Vàng

-- Variants for 'Quần Jeans Nam' (SanPhamID = 3)
(3, 3, 3, 500000.00, 20), -- Size L, Màu Đen
(3, 4, 2, 500000.00, 20), -- Size XL, Màu Xanh

-- Variants for 'Quần Short Nữ' (SanPhamID = 4)
(4, 1, 6, 250000.00, 10), -- Size S, Màu Hồng
(4, 2, 4, 250000.00, 15); -- Size M, Màu Trắng
GO

-- g. Thêm Dữ Liệu vào NguoiDung
-- Lưu ý: Mật khẩu nên được mã hóa trong ứng dụng. Dưới đây chỉ là ví dụ với mật khẩu chưa mã hóa.
INSERT INTO NguoiDung (Ten, Email, MatKhau, SoDienThoai, DiaChi) VALUES
('Nguyen Van A', 'nguyenvana@example.com', 'hashed_password_1', '0909123456', '123 Đường ABC, Quận 1, TP.HCM'),
('Tran Thi B', 'tranthib@example.com', 'hashed_password_2', '0909987654', '456 Đường XYZ, Quận 3, TP.HCM'),
('Le Van C', 'levanc@example.com', 'hashed_password_3', '0912345678', '789 Đường DEF, Quận 5, TP.HCM');
GO

-- h. Thêm Dữ Liệu vào DiaChiNguoiDung
INSERT INTO DiaChiNguoiDung (NguoiDungID, TenDiaChi, SoDienThoai, DiaChi) VALUES
(1, 'Nhà riêng', '0909123456', '123 Đường ABC, Quận 1, TP.HCM'),
(2, 'Văn phòng', '0909987654', '456 Đường XYZ, Quận 3, TP.HCM'),
(3, 'Nhà riêng', '0912345678', '789 Đường DEF, Quận 5, TP.HCM');
GO

-- i. Thêm Dữ Liệu vào KhuyenMai
INSERT INTO KhuyenMai (TenKhuyenMai, MoTa, GiaTri, NgayBatDau, NgayKetThuc) VALUES
('Giảm Giá Mùa Xuân', 'Giảm 10% cho tất cả sản phẩm mùa xuân.', 10.00, '2024-03-01', '2024-05-31'),
('Khuyến Mãi Đặc Biệt', 'Mua 2 tặng 1 cho các sản phẩm áo.', 0.00, '2024-06-01', '2024-06-30');
GO

-- j. Thêm Dữ Liệu vào GiamGiaSanPham
INSERT INTO GiamGiaSanPham (KhuyenMaiID, SanPhamID) VALUES
(1, 1), -- Áo Thun Nam thuộc Khuyến Mãi Mùa Xuân
(1, 2), -- Áo Sơ Mi Nữ thuộc Khuyến Mãi Mùa Xuân
(2, 1), -- Áo Thun Nam thuộc Khuyến Mãi Đặc Biệt
(2, 2); -- Áo Sơ Mi Nữ thuộc Khuyến Mãi Đặc Biệt
GO

-- k. Thêm Dữ Liệu vào HinhAnhSanPham
INSERT INTO HinhAnhSanPham (SanPhamID, DuongDan) VALUES
(1, 'images/sanpham/ao_thun_nam_1.jpg'),
(1, 'images/sanpham/ao_thun_nam_2.jpg'),
(2, 'images/sanpham/ao_somi_nu_1.jpg'),
(3, 'images/sanpham/quan_jeans_nam_1.jpg'),
(4, 'images/sanpham/quan_short_nu_1.jpg');
GO

-- l. Thêm Dữ Liệu vào DonHang
INSERT INTO DonHang (NguoiDungID, TongTien, TrangThai, TenNguoiNhan, SoDienThoaiNguoiNhan, DiaChiGiaoHang, PhuongThucThanhToanID) VALUES
(1, 700000.00, 'ChoXuLy', 'Nguyen Van A', '0909123456', '123 Đường ABC, Quận 1, TP.HCM', 1),
(2, 500000.00, 'DangXuLy', 'Tran Thi B', '0909987654', '456 Đường XYZ, Quận 3, TP.HCM', 2),
(3, 450000.00, 'DaGiao', 'Le Van C', '0912345678', '789 Đường DEF, Quận 5, TP.HCM', 3);
GO

-- m. Thêm Dữ Liệu vào ChiTietDonHang
INSERT INTO ChiTietDonHang (DonHangID, SanPhamChiTietID, SoLuong, Gia) VALUES
-- Chi tiết cho DonHangID = 1
(1, 1, 2, 200000.00), -- 2 x Áo Thun Nam (Size S, Màu Đen)
(1, 2, 1, 350000.00), -- 1 x Áo Sơ Mi Nữ (Size M, Màu Trắng)

-- Chi tiết cho DonHangID = 2
(2, 3, 1, 500000.00), -- 1 x Quần Jeans Nam (Size L, Màu Đen)

-- Chi tiết cho DonHangID = 3
(3, 4, 1, 250000.00), -- 1 x Quần Short Nữ (Size S, Màu Hồng)
(3, 5, 1, 200000.00); -- 1 x Áo Thun Nam (Size M, Màu Xanh)
GO

-- n. Thêm Dữ Liệu vào ThanhToan
INSERT INTO ThanhToan (DonHangID, PhuongThucID, SoTien) VALUES
(1, 1, 700000.00), -- Đơn hàng 1 thanh toán bằng Cash on Delivery
(2, 2, 500000.00), -- Đơn hàng 2 thanh toán bằng Bank Transfer
(3, 3, 450000.00); -- Đơn hàng 3 thanh toán bằng Credit Card
GO

-- o. Thêm Dữ Liệu vào DanhGia
INSERT INTO DanhGia (SanPhamID, NguoiDungID, SoSao, NoiDung) VALUES
(1, 1, 5, 'Sản phẩm chất lượng, rất hài lòng!'),
(2, 2, 4, 'Áo đẹp, phù hợp với mùa hè.'),
(3, 3, 3, 'Quần ổn nhưng có thể cải thiện chất liệu.');
GO

-- ================================================
-- 5. Kiểm Tra Dữ Liệu Sau Khi Thêm
-- ================================================

-- a. Kiểm Tra Các Bảng
SELECT 'PhuongThucThanhToan' AS BANG, *
FROM PhuongThucThanhToan;
GO

SELECT 'DanhMuc' AS BANG, *
FROM DanhMuc;
GO

SELECT 'Size' AS BANG, *
FROM Size;
GO

SELECT 'MauSac' AS BANG, *
FROM MauSac;
GO

SELECT 'SanPham' AS BANG, *
FROM SanPham;
GO

SELECT 'SanPhamChiTiet' AS BANG, *
FROM SanPhamChiTiet;
GO

SELECT 'NguoiDung' AS BANG, *
FROM NguoiDung;
GO

SELECT 'DiaChiNguoiDung' AS BANG, *
FROM DiaChiNguoiDung;
GO

SELECT 'KhuyenMai' AS BANG, *
FROM KhuyenMai;
GO

SELECT 'GiamGiaSanPham' AS BANG, *
FROM GiamGiaSanPham;
GO

SELECT 'HinhAnhSanPham' AS BANG, *
FROM HinhAnhSanPham;
GO

SELECT 'DonHang' AS BANG, *
FROM DonHang;
GO

SELECT 'ChiTietDonHang' AS BANG, *
FROM ChiTietDonHang;
GO

SELECT 'ThanhToan' AS BANG, *
FROM ThanhToan;
GO

SELECT 'DanhGia' AS BANG, *
FROM DanhGia;
GO