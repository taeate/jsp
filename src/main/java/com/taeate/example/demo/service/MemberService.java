package com.taeate.example.demo.service;

import com.taeate.example.demo.Repository.MemberRepository;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Member;
import com.taeate.example.demo.vo.ResultData;

import org.springframework.stereotype.Service;

@Service
public class MemberService {

    private MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository){
        this.memberRepository = memberRepository;
    }

    public ResultData join(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {
        Member oldmember = getMemberByLoginId(loginId);
        //아이디중복체크
        if (oldmember != null) {
            return ResultData.from("F-7", Ut.f("해당 로그인아이디(%s)는 이미 사용중입니다.", loginId));
        }
        //이름+이메일 중복체크
        oldmember = getMemberByNameandemail(name, email);

        if (oldmember != null) {
            return ResultData.from("F-8", Ut.f("해당 이름(%s)과 이메일(%s)은 이미 사용중입니다.", name,email));
        }

        memberRepository.join(loginId, loginPw, name, nickname, cellphoneNo, email);
        int id = memberRepository.getLastInsertId();

        return ResultData.from("S-1", "회원가입이 완료되었습니다", "id", id);
    }

    private Member getMemberByNameandemail(String name, String email) {
        return memberRepository.getMemberByNameandemail(name,email);
    }

    public Member getMemberByLoginId(String loginId) {
        return memberRepository.getMemberByloginId(loginId);
    }

    public Member getMemberById(int id) {
        return memberRepository.getMemberById(id);
    }

}
