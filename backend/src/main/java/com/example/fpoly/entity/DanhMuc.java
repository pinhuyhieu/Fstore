package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "danh_muc")
public class DanhMuc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "ten_danh_muc")
    private String tenDanhMuc;
    @Column(name = "mo_ta")
    private String moTa;
    @Column(name = "ngay_tao", insertable = false, updatable = false)
    private LocalDateTime ngayTao;
}
