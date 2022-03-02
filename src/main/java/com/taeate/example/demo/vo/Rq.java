package com.taeate.example.demo.vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.Getter;

public class Rq {
    @Getter
    private boolean islogined;
    @Getter
    private int loginedMemberId;

    public Rq(HttpServletRequest req) {
        HttpSession httpSession = req.getSession();
        boolean isLogined = false;

        int loginedMemberId = 0;

        if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
            loginedMemberId = (int)httpSession.getAttribute("loginedMemberId");
		}
        this.islogined = isLogined;
        this.loginedMemberId = loginedMemberId;
    }

    public boolean isLogined() {
        return false;
    }

}
