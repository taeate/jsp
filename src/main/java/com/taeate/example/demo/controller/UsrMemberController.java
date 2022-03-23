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
import org.springframework.web.bind.annotation.RequestParam;
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
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		
		rq.logout();

	

		return rq.jsReplace("로그아웃 되었습니다.", afterLogoutUri);
	}


    @RequestMapping("/usr/member/login")
	public String showLogin(HttpSession httpSession) {
		return "usr/member/login";
    }



    @RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {
	

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

		return rq.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), afterLoginUri);
	}


    @RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(String memberModifyAuthKey ,String name , String loginPw, String nickname , String email, String cellphoneNo ) {
		
		if ( Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBack("memberModifyAuthKey(이)가 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);

		if ( checkMemberModifyAuthKeyRd.isFail() ) {
			return rq.jsHistoryBack(checkMemberModifyAuthKeyRd.getMsg());
		}


		if (Ut.empty(name)) {
			return rq. jsHistoryBack("name(을)를 입력해주세요.");
		}
        if (Ut.empty(loginPw)) {
			loginPw = null;
		}
        if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("nickname(을)를 입력해주세요.");
		}
        if (Ut.empty(email)) {
			return rq.jsHistoryBack("email(을)를 입력해주세요.");
		}
        if (Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("전화번호(을)를 입력해주세요.");
		}

        ResultData modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPw, name, nickname, email, cellphoneNo);

		return rq.jsReplace(modifyRd.getMsg(), "/");
	}


    @RequestMapping("/usr/member/myPage")
	public String showmyPage(String loginId, String loginPw) {

        return "usr/member/myPage";
	}

    @RequestMapping("/usr/member/checkPassword")
	public String showcheckPassword() {

        return "usr/member/checkPassword";
	}

    @RequestMapping("/usr/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPw, String replaceUri) {
	 
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("loginPw(을)를 입력해주세요.");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}

        if (replaceUri.equals("../member/modify")) {
            String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());

            replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
        }

		return rq.jsReplace("", replaceUri);
	}

    @RequestMapping("/usr/member/modify")
	public String showModify(String memberModifyAuthKey) {
		if ( Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackJsOnView("memberModifyAuthKey(이)가 필요합니다.");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);

		if ( checkMemberModifyAuthKeyRd.isFail() ) {
			return rq.historyBackJsOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "usr/member/modify";
	}
}
