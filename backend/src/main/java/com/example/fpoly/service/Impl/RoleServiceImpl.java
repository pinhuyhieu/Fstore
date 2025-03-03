package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.Role;
import com.example.fpoly.repository.RoleRepository;
import com.example.fpoly.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;


    @Override
    public Role saveRole(Role role) {
        return roleRepository.save(role);
    }

    @Override
    public Role findByTenVaiTro(String tenVaiTro) {
        return roleRepository.findBytenVaiTro(tenVaiTro)
                .orElseThrow(() -> new RuntimeException("Role not found: " + tenVaiTro));
    }
}
