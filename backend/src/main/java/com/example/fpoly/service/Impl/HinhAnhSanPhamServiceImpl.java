package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.HinhAnhSanPham;
import com.example.fpoly.entity.SanPham;
import com.example.fpoly.repository.HinhAnhSanPhamRepository;
import com.example.fpoly.repository.SanPhamRepository;
import com.example.fpoly.service.HinhAnhSanPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
public class HinhAnhSanPhamServiceImpl implements HinhAnhSanPhamService {

    @Autowired
    private HinhAnhSanPhamRepository hinhAnhSanPhamRepository;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    private final String UPLOAD_DIR = "uploads/";

    @Override
    public void uploadImage(MultipartFile file, Integer sanPhamId) {
        if (file.isEmpty()) {
            throw new RuntimeException("File không được rỗng!");
        }

        try {
            // Tạo thư mục nếu chưa tồn tại
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Tạo tên file duy nhất để tránh trùng lặp
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR, fileName);

            // Lưu file vào thư mục
            Files.write(filePath, file.getBytes());

            // Lấy sản phẩm theo ID
            SanPham sanPham = sanPhamRepository.findById(sanPhamId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID: " + sanPhamId));

            // Lưu đường dẫn vào database (lưu đường dẫn dưới dạng URL hợp lệ)
            HinhAnhSanPham hinhAnh = new HinhAnhSanPham();
            hinhAnh.setSanPham(sanPham);
            hinhAnh.setDuongDan("uploads/" + fileName); // Lưu đường dẫn để hiển thị đúng trên giao diện

            hinhAnhSanPhamRepository.save(hinhAnh);
        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi lưu file: " + e.getMessage());
        }
    }

    @Override
    public void deleteImage(Integer id) {
        HinhAnhSanPham hinhAnh = hinhAnhSanPhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy hình ảnh với ID: " + id));

        // Xóa file trên server
        Path filePath = Paths.get(hinhAnh.getDuongDan().substring(1)); // Bỏ dấu `/` ở đầu để lấy đường dẫn thật
        File file = filePath.toFile();

        if (file.exists() && file.delete()) {
            System.out.println("Đã xóa file: " + filePath);
        } else {
            System.out.println("Không thể xóa file hoặc file không tồn tại: " + filePath);
        }

        // Xóa bản ghi trong database
        hinhAnhSanPhamRepository.deleteById(id);
    }

    @Override
    public List<HinhAnhSanPham> getImagesBySanPhamId(Integer sanPhamId) {
        return hinhAnhSanPhamRepository.findBySanPhamId(sanPhamId);
    }
}
