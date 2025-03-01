package com.example.fpoly.service;

import com.example.fpoly.entity.MauSac;

import java.util.List;

public interface MauSacService {
    List<MauSac> getAll();
    MauSac getById(Integer id);
    MauSac save(MauSac mauSac);
    MauSac update(Integer id, MauSac mauSac);
    void delete(Integer id);
    List<MauSac> getAvailableColorsBySanPhamId(Integer sanPhamId) ;
}
