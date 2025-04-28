package com.example.fpoly.config;

import com.example.fpoly.jwt.JwtAuthenticationFilter;
import com.example.fpoly.security.UserDetailsServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsServiceImpl userDetailsService;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)) // Sử dụng session
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login", "/register", "/doLogin", "/doRegister", "/cart/**", "/sanphamchitiet/**","/api/cart/detail/").permitAll()
                        .requestMatchers("/WEB-INF/views/**","/api/ghn/wards/**","/api/ghn/districts/**","/api/ghn/provinces/**").permitAll() // Cho phép truy cập JSP
                        .requestMatchers("/css/**", "/js/**", "/uploads/**").permitAll()
                        .requestMatchers("/api/payment/vnpay-return").permitAll()
                        .requestMatchers("/user/**").hasRole("USER")
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .formLogin(login -> login
                        .loginPage("/login")
                        .loginProcessingUrl("/doLogin") // Spring Security xử lý đăng nhập
                        .successHandler(customLoginSuccessHandler()) // Xử lý chuyển hướng sau khi đăng nhập
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )

                .authenticationProvider(authenticationProvider()) // Thêm AuthenticationProvider vào chuỗi bảo mật
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class) // JWT filter
                .exceptionHandling(exception -> exception
                        .accessDeniedHandler(accessDeniedHandler()) // Xử lý lỗi 403
                        .authenticationEntryPoint((request, response, authException) -> {
                            // Nếu là truy cập từ trình duyệt (HTML, JSP), chuyển về trang login
                            if (request.getHeader("Accept") != null && request.getHeader("Accept").contains("text/html")) {
                                response.sendRedirect("/login");
                            } else {
                                // Nếu là API (REST), trả về JSON lỗi
                                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                                response.setContentType("application/json");
                                response.getWriter().write("{\"error\": \"Bạn cần đăng nhập để truy cập tài nguyên này.\"}");
                            }
                        })


                );

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler customLoginSuccessHandler() {
        return (request, response, authentication) -> {
            authentication.getAuthorities().forEach(grantedAuthority -> {
                try {
                    if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
                        response.sendRedirect("/admin/home"); // 🔹 Chuyển hướng admin
                    } else {
                        response.sendRedirect("/sanpham/index"); // 🔹 Chuyển hướng user thường
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        };
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true); // 🔥 BẮT BUỘC
        config.setAllowedOriginPatterns(List.of("http://localhost:3000")); // hoặc domain FE của bạn
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("*")); // nên để rộng
        config.setExposedHeaders(List.of("Set-Cookie")); // giúp client thấy cookie nếu cần

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }


    @Bean
    public AccessDeniedHandler accessDeniedHandler() {
        return (request, response, accessDeniedException) -> {
            response.sendRedirect("/auth/access-denied");
        };
    }

    @Bean
    public HttpFirewall allowDoubleSlashFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true); // Cho phép URL chứa "//"
        return firewall;
    }
}
