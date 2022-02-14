package com.taeate.example.demo.controller;

import com.taeate.example.demo.service.MemberService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrMemberController {
    @Autowired
    private MemberService memberService;

    @RequestMapping("/usr/member/dojoin")
    @ResponseBody
    public String dojoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {

        memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);

        return "성공";
    }


}
