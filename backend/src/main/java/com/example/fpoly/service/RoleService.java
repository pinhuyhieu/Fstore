package com.example.fpoly.service;

import com.example.fpoly.entity.Role;

import java.util.Optional;


public interface  RoleService {
        Role saveRole(Role role);
        Role findByTenVaiTro (String name);
}