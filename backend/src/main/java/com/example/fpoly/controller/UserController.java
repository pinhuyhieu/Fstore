package com.example.fpoly.controller;

import com.example.fpoly.entity.Role;
import com.example.fpoly.entity.User;
import com.example.fpoly.service.UserService;
import com.example.fpoly.repository.RoleRepository;
import com.example.fpoly.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class UserController {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final UserService userService;

    // 🔹 Lấy danh sách người dùng
    @GetMapping("/users")
    public String getUsers(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "user/list";  // Trang hiển thị danh sách người dùng
    }

    // 🔹 Lấy danh sách các vai trò
    @GetMapping("/roles")
    public String getRoles(Model model) {
        List<Role> roles = roleRepository.findAll();
        model.addAttribute("roles", roles);
        return "user/roles";  // Trang hiển thị danh sách vai trò
    }

    // 🔹 Trang chỉnh sửa vai trò người dùng
    @GetMapping("/edit-roles/{userId}")
    public String getEditRolesPage(@PathVariable Integer userId, Model model) {
        // Lấy người dùng và các vai trò
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("❌ Người dùng không tồn tại"));
        List<Role> roles = roleRepository.findAll();

        // Thêm người dùng và vai trò vào model
        model.addAttribute("user", user);
        model.addAttribute("roles", roles);
        return "user/editUserRoles"; // Trả về trang chỉnh sửa vai trò người dùng
    }

    // 🔹 Cập nhật vai trò cho người dùng
    @PostMapping("/update-roles")
    public String updateUserRoles(@RequestParam("userId") Integer userId,
                                  @RequestParam("roleId") Integer roleId,  // Chỉ nhận một roleId
                                  RedirectAttributes redirectAttributes) {
        try {
            // Cập nhật vai trò cho người dùng
            userService.updateUserRoles(userId, roleId);  // Gọi service để cập nhật vai trò
            redirectAttributes.addFlashAttribute("successMessage", "✅ Cập nhật vai trò thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "❌ Lỗi khi cập nhật vai trò!");
        }
        return "redirect:/admin/users";  // Quay lại danh sách người dùng
    }

}
