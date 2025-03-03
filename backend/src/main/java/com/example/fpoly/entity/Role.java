package com.example.fpoly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "vai_tro") // Tên bảng trong database
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ten_vai_tro", nullable = false, unique = true)
    private String tenVaiTro; // Ví dụ: ROLE_ADMIN, ROLE_USER

    @ManyToMany(mappedBy = "roles") // Quan hệ nhiều-nhiều với User
    private Set<User> users;
}