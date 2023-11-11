package com.example.surveysserver.data;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Survey {

    private int id;
    private String imie;
    private String nazwisko;
    private int ocena;
}
