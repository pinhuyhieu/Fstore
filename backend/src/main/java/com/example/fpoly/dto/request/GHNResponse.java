package com.example.fpoly.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class GHNResponse<T> {
    private int code;
    private String message;
    private List<T> data;
}
