package com.example.fpoly.security;

import com.example.fpoly.entity.Role;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private static final Logger logger = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByTenDangNhap(username)
                .orElseThrow(() -> new UsernameNotFoundException("User không tồn tại: " + username));

        // 🔍 Debug thông tin người dùng và vai trò
        logger.info("🔍 User: {}", username);
        logger.info("🔍 Vai trò từ DB:");
        user.getRoles().forEach(role -> logger.info(" - {}", role.getTenVaiTro()));

        // Chuyển đổi vai trò thành GrantedAuthority
        Collection<? extends GrantedAuthority> authorities = getAuthorities(user.getRoles());

        // Tạo UserDetails từ thông tin người dùng
        return new org.springframework.security.core.userdetails.User(
                user.getTenDangNhap(),
                user.getMatKhau(),
                authorities
        );
    }

    // Phương thức để chuyển đổi danh sách roles thành danh sách GrantedAuthority
    private Collection<? extends GrantedAuthority> getAuthorities(Collection<Role> roles) {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getTenVaiTro())) // Thêm tiền tố "ROLE_"
                .collect(Collectors.toList());
    }
}