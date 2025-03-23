package com.example.fpoly.controller;

import com.example.fpoly.entity.ThanhToan;
import com.example.fpoly.service.ThanhToanService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/thanh-toan")
@RequiredArgsConstructor
public class ThanhToanController {

    private final ThanhToanService thanhToanService;

    @GetMapping("/{maGiaoDich}")
    public Optional<ThanhToan> getByMaGiaoDich(@PathVariable String maGiaoDich) {
        return thanhToanService.findByMaGiaoDich(maGiaoDich);
    }
}
