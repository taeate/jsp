package com.taeate.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int id;
    private String regdate;
    private String updatedate;
    private String loginId;
    private String loginPw; 
    private String name;
    private String authLevel;
    private String nickname;
    private String cellphoneNo;
    private String email;
    private boolean delstatus;
    private String delDate;
}
