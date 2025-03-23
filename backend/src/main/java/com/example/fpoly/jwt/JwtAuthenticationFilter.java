package com.example.fpoly.jwt;

import com.example.fpoly.security.JwtUtil;
import com.example.fpoly.security.UserDetailsServiceImpl;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(JwtAuthenticationFilter.class);

    private final JwtUtil jwtUtil;
    private final UserDetailsServiceImpl userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        try {
            String requestPath = request.getServletPath();
            logger.info("🔍 Request Path: {}", requestPath);

            // ✅ Bỏ qua kiểm tra JWT cho API đăng nhập, đăng ký
            if (requestPath.startsWith("/login") || requestPath.startsWith("/doLogin") ||requestPath.startsWith("/api/payment/vnpay-return") ||
                    requestPath.startsWith("/register") || requestPath.startsWith("/doRegister") || requestPath.startsWith("/favicon.ico"))

            {
                logger.info("✅ Bỏ qua JWT kiểm tra cho: {}", requestPath);
                filterChain.doFilter(request, response);
                return;
            }

            // 🔹 Lấy token từ request header
            String token = extractToken(request);
            if (token == null) {
                logger.warn("❌ Không tìm thấy Token hoặc sai định dạng");
                filterChain.doFilter(request, response);
                return;
            }

            logger.info("🔹 Token nhận được: {}", token);

            // 🔹 Lấy username từ token
            String username = jwtUtil.extractUsername(token);
            logger.info("🔹 Username từ Token: {}", username);

            // ✅ Kiểm tra nếu user chưa được xác thực
            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UserDetails userDetails = userDetailsService.loadUserByUsername(username);
                logger.info("✅ User tìm thấy: {}", userDetails.getUsername());

                if (jwtUtil.validateToken(token, userDetails)) {
                    UsernamePasswordAuthenticationToken authenticationToken =
                            new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                    logger.info("✅ Xác thực thành công: {}", userDetails.getUsername());
                } else {
                    logger.warn("❌ Token không hợp lệ");
                }
            }

            filterChain.doFilter(request, response);
        } catch (ExpiredJwtException e) {
            logger.error("JWT Token đã hết hạn: {}", e.getMessage());
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("JWT Token đã hết hạn: " + e.getMessage());
        } catch (MalformedJwtException | SignatureException e) {
            logger.error("JWT Token không hợp lệ: {}", e.getMessage());
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("JWT Token không hợp lệ: " + e.getMessage());
        } catch (Exception e) {
            logger.error("JWT authentication error: {}", e.getMessage());
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("JWT authentication error: " + e.getMessage());
        }
    }

    private String extractToken(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }
        return null;
    }
}