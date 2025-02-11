-- Trigger Trước Khi Xóa Sản Phẩm
CREATE TRIGGER trg_before_delete_SanPham
    ON SanPham INSTEAD OF
DELETE
AS
BEGIN
    SET
NOCOUNT ON;

    -- Kiểm tra nếu sản phẩm có dữ liệu liên quan
    IF
EXISTS (
        SELECT 1 FROM SanPhamChiTiet WHERE SanPhamID IN (SELECT SanPhamID FROM deleted)
        UNION
        SELECT 1 FROM GiamGiaSanPham WHERE SanPhamID IN (SELECT SanPhamID FROM deleted)
        UNION
        SELECT 1 FROM DanhGia WHERE SanPhamID IN (SELECT SanPhamID FROM deleted)
        UNION
        SELECT 1 FROM HinhAnhSanPham WHERE SanPhamID IN (SELECT SanPhamID FROM deleted)
    )
BEGIN
        RAISERROR
('Không thể xóa sản phẩm vì có dữ liệu liên quan.', 16, 1);
ROLLBACK TRANSACTION;
END
ELSE
BEGIN
        -- Xóa sản phẩm nếu không có dữ liệu liên quan
DELETE
FROM SanPham
WHERE SanPhamID IN (SELECT SanPhamID FROM deleted);
END
END;
GO
-- Trigger Tính Lại Tổng Tiền Đơn Hàng
CREATE TRIGGER trg_after_modify_ChiTietDonHang
    ON ChiTietDonHang AFTER INSERT,
UPDATE,
DELETE
    AS
BEGIN
    SET
NOCOUNT ON;

    -- Cập nhật tổng tiền của đơn hàng
UPDATE DonHang
SET TongTien = ISNULL(ct.TongTien, 0) FROM DonHang dh
    INNER JOIN (
        SELECT DonHangID, SUM(SoLuong * Gia) AS TongTien
        FROM ChiTietDonHang
        GROUP BY DonHangID
    ) ct
ON dh.DonHangID = ct.DonHangID
WHERE dh.DonHangID IN (
    SELECT DISTINCT DonHangID FROM inserted
    UNION
    SELECT DISTINCT DonHangID FROM deleted
    );
END;
GO
-- Trigger Sau Khi Cập Nhật DonHang để Ghi Nhận Thanh Toan
CREATE TRIGGER trg_after_update_DonHang
    ON DonHang
    AFTER
UPDATE
    AS
BEGIN
    SET
NOCOUNT ON;

    -- Thêm thanh toán khi DonHang.TrangThai chuyển thành 'DaGiao'
INSERT INTO ThanhToan (DonHangID, PhuongThucID, SoTien)
SELECT i.DonHangID, i.PhuongThucThanhToanID, i.TongTien
FROM inserted i
         INNER JOIN deleted d ON i.DonHangID = d.DonHangID
WHERE d.TrangThai <> 'DaGiao'
  AND i.TrangThai = 'DaGiao';
END
GO
