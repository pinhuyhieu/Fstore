package com.example.fpoly.service.Impl;

import com.example.fpoly.entity.DiaChiNguoiDung;
import com.example.fpoly.entity.User;
import com.example.fpoly.repository.DiaChiNguoiDungRepository;
import com.example.fpoly.service.DiaChiNguoiDungService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DiaChiNguoiDungServiceImpl implements DiaChiNguoiDungService {

    private final DiaChiNguoiDungRepository diaChiRepo;

    @Override
    public List<DiaChiNguoiDung> getAllByUser(User user) {
        return diaChiRepo.findByUser(user);
    }

    @Override
    public Optional<DiaChiNguoiDung> getDiaChiMacDinh(User user) {
        return diaChiRepo.findByUserAndMacDinhTrue(user);
    }

    @Override
    public DiaChiNguoiDung save(DiaChiNguoiDung diaChi) {
        return diaChiRepo.save(diaChi);
    }

    @Override
    public void deleteById(Integer id) {
        diaChiRepo.deleteById(id);
    }
}

