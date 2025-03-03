package com.example.fpoly.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor

public class AuthRequest {
    private String tenDangNhap;
    private String matKhau;
}
