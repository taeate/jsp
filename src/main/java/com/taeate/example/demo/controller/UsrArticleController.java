package com.taeate.example.demo.controller;

import java.util.List;

import com.taeate.example.demo.service.ArticleService;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Article;
import com.taeate.example.demo.vo.ResultData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {
    @Autowired
    private ArticleService articleService;

    // 액션메서드 시작
    @RequestMapping("/usr/article/doAdd")
    @ResponseBody
    public ResultData doAdd(HttpSession httpSession,String title, String body) {
        boolean isLogined = false;

        int loginedMemberId = 0;

        if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
            loginedMemberId = (int)httpSession.getAttribute("loginedMemberId");
		}
        if (isLogined == false){
            return ResultData.from("F-3", "로그인후 이용해주세요.");
        }

        if ( Ut.empty(title)){
            return ResultData.from("F-1", "title(을)를 입력해주세요");
        }
        
        if ( Ut.empty(body)){
            return ResultData.from("F-2", "body(을)를 입력해주세요");
        }

       ResultData writeArticleRd = articleService.writeArticle(loginedMemberId,title, body);
       int id = (int)writeArticleRd.getData1();

       Article article = articleService.getArticle(id);

       return ResultData.newData(writeArticleRd, "article", article);
    }

    @RequestMapping("/usr/article/doDelete")
    @ResponseBody
    public ResultData doDelete(HttpSession httpSession, int id) {
        boolean isLogined = false;
        int loginedMemberId = 0;
        

        if (httpSession.getAttribute("loginedMemberId") != null){
            isLogined = true;
            loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
        }

        if (isLogined == false) {
            return ResultData.from("F-A", "로그인 후 이용해주세요.");
        }

        Article article = articleService.getArticle(id);

        if (article.getMemberId() != loginedMemberId) {
            return ResultData.from("F-2", "권한이 없습니다.");
        }
        if (article == null) {
            ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
        }

        articleService.deleteArticle(id);

        return ResultData.from("S-1", Ut.f("%d번 게시물을 삭제하였습니다.", id), "id", id);
    }

    @RequestMapping("/usr/article/doModify")
    @ResponseBody
    public ResultData doModify(HttpSession httpSession, int id, String title, String body) {
        boolean isLogined = false;
        int loginedMemberId = 0;

        if (httpSession.getAttribute("loginedMemberId") != null){
            isLogined = true;
            loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
        }
        if (isLogined == false){
            return ResultData.from("F-A", "로그인 후 이용해주세요.");
        }

		Article article = articleService.getArticle(id);

        if (article == null) {
            ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
        }

        ResultData actorCanModifyRd = articleService.actorCanModify(loginedMemberId,article);

        if ( actorCanModifyRd.isFail()){
            return actorCanModifyRd;
        }

        return articleService.ModifyArticle(id, title, body);
        
    }

    // 액션메서드 끝
    @RequestMapping("/usr/article/list")
    public String showList(Model model) {
        List<Article> articles = articleService.getArticles();

        model.addAttribute("articles", articles);

       return "usr/article/list";
    }

    @RequestMapping("/usr/article/getArticle")
    @ResponseBody
    public ResultData getArticle(int id) {
        Article article = articleService.getArticle(id);

        if (article == null) {

            return ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
        }
        return ResultData.from("S-1", Ut.f("%d번 게시물입니다.", id), "article", article);
    }

}
