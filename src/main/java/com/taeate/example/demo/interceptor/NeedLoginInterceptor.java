package com.taeate.example.demo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.taeate.example.demo.vo.Rq;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {
	private Rq rq;
	public NeedLoginInterceptor(Rq rq) {
		this.rq = rq;
	}

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		if (!rq.isLogined()) {
			String afterLoginUri = rq.getEncodedCurrentUri();
			rq.printReplaceJs("로그인 후 이용해주세요.", "../member/login?afterLoginUrl=" + afterLoginUri);
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}