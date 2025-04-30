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
@Table(name = "nguoi_dung_vai_tro") // Tên bảng trong database
public class NguoiDungVaiTro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "nguoi_dung_id", referencedColumnName = "id", nullable = false)
    private User user; // Liên kết với bảng User

    @ManyToOne
    @JoinColumn(name = "vai_tro_id", referencedColumnName = "id", nullable = false)
    private Role role; // Liên kết với bảng Role
}
