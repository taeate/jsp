package com.taeate.example.demo.service;

import com.taeate.example.demo.Repository.MemberRepository;
import com.taeate.example.demo.vo.Member;

import org.springframework.stereotype.Service;

@Service
public class MemberService {

    private MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    public int join(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {
        memberRepository.join(loginId, loginPw, name, nickname, cellphoneNo, email);
        return memberRepository.getLastInsertId();
    }

    public Member getMemberById(int id) {
        return memberRepository.getMemberById(id);
    }

}
