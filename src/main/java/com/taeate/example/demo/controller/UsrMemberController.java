package com.taeate.example.demo.controller;

import javax.servlet.http.HttpSession;

import com.taeate.example.demo.service.MemberService;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Member;
import com.taeate.example.demo.vo.ResultData;
import com.taeate.example.demo.vo.Rq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrMemberController {
    @Autowired
    private MemberService memberService;
    private Rq rq;

    public UsrMemberController(MemberService memberService, Rq rq){
        this.memberService = memberService;
        this.rq = rq;
    }

     @RequestMapping("/usr/member/dojoin")
    @ResponseBody
    public ResultData dojoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {

        if (Ut.empty(loginId)) {
            return ResultData.from("F-1", "loginId(을)를 입력해주세요.");
        }
        if (Ut.empty(loginPw)) {
            return ResultData.from("F-2","loginPw(을)를 입력해주세요.");
        }
        if (Ut.empty(name)) {
            return ResultData.from("F-3","name(을)를 입력해주세요.");
        }
        if (Ut.empty(nickname)) {
            return ResultData.from("F-4","nickname(을)를 입력해주세요.");
        }
        if (Ut.empty(cellphoneNo)) {
            return ResultData.from("F-5","cellphoneNo(을)를 입력해주세요.");
        }
        if (Ut.empty(email) ) {
            return ResultData.from("F-6","email(을)를 입력해주세요.");
        }

        ResultData joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);

        if (joinRd.isFail()) {
            return joinRd;
        }
        
        Member member = memberService.getMemberById((int)joinRd.getData1());

        return ResultData.newData(joinRd, "member", member);
        
    }

    @RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		

		if (!rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그아웃 상태입니다.");
		}

		rq.logout();

		return rq.jsReplace("로그아웃 되었습니다.", "/");
	}


    @RequestMapping("/usr/member/login")
	public String showLogin(HttpSession httpSession) {
		return "usr/member/login";
    }



    @RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
	

		if (rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그인되었습니다.");
		}

		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("loginId(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return rq.jsHistoryBack("존재하지 않은 로그인아이디 입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

		rq.login(member);

		return rq.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), "/");
	}

    @RequestMapping("/usr/member/myPage")
	public String showmyPage(String loginId, String loginPw) {

        return "usr/member/myPage";
	}

    @RequestMapping("/usr/member/checkPassword")
	public String showcheckPassword() {

        return "usr/member/checkPassword";
	}


}
