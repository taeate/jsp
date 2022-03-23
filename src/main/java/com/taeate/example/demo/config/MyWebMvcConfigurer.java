package com.taeate.example.demo.config;

import com.taeate.example.demo.interceptor.BeforeActionInterceptor;
import com.taeate.example.demo.interceptor.NeedLoginInterceptor;
import com.taeate.example.demo.interceptor.NeedLogoutInterceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
    // beforeActionInterceptor 인터셉터 불러오기
    @Autowired
    BeforeActionInterceptor beforeActionInterceptor;
    // NeedloginInterceptor 인터셉터 불러오기
    @Autowired
    NeedLoginInterceptor needLoginInterceptor;
    // NeedloginInterceptor 인터셉터 불러오기
    @Autowired
    NeedLogoutInterceptor needLogoutInterceptor;

    // 이 함수는 인터셉터를 적용하는 역할
    public void addInterceptors(InterceptorRegistry registry){
         registry.addInterceptor(beforeActionInterceptor)
                 .addPathPatterns("/**")
                 .excludePathPatterns("/favicon.ico")
                 .excludePathPatterns("/resource/**")
                 .excludePathPatterns("/error");


        registry.addInterceptor(needLoginInterceptor)
                 .addPathPatterns("/usr/member/myPage")
                 .addPathPatterns("/usr/member/checkPassword")
                 .addPathPatterns("/usr/member/doCheckPassword")
                 .addPathPatterns("/usr/member/modify")
                 .addPathPatterns("/usr/member/doModify")
                 .addPathPatterns("/usr/reply/modify")
                 .addPathPatterns("/usr/reply/doModify")
                 .addPathPatterns("/usr/reply/doWrite")
                 .addPathPatterns("/usr/reply/doDelete")
                 .addPathPatterns("/usr/article/write")
                 .addPathPatterns("/usr/article/dowrite")
                 .addPathPatterns("/usr/article/modify")
                 .addPathPatterns("/usr/article/doModify")
                 .addPathPatterns("/usr/article/doDelete")
                 .addPathPatterns("/usr/reactionPoint/doGoodReaction")
                 .addPathPatterns("/usr/reactionPoint/doBadReaction")
                 .addPathPatterns("/usr/reactionPoint/doCancelGoodReaction")
                 .addPathPatterns("/usr/reactionPoint/doCancelBadReaction"); 

        registry.addInterceptor(needLogoutInterceptor)
                 .addPathPatterns("/usr/member/join")
                 .addPathPatterns("/usr/member/doJoin")
                 .addPathPatterns("/usr/member/getLoginIdDup")
                 .addPathPatterns("/usr/member/login")
                 .addPathPatterns("/usr/member/doLogin")
                 .addPathPatterns("/usr/member/findLoginId")
                 .addPathPatterns("/usr/member/doFindLoginId")
                 .addPathPatterns("/usr/member/findLoginPw")
                 .addPathPatterns("/usr/member/doFindLoginPw");
    }
    
}
