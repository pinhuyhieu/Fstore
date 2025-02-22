package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "hinh_anh_san_pham")
public class HinhAnhSanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "san_pham_id", referencedColumnName = "id")
    private SanPham sanPham;
    @Column(name = "duong_dan")
    private String duongDan;
}
