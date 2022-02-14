package com.taeate.example.demo.controller;

import java.util.List;

import com.taeate.example.demo.service.ArticleService;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Article;
import com.taeate.example.demo.vo.ResultData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrArticleController {
    @Autowired
    private ArticleService articleService;

    // 액션메서드 시작
    @RequestMapping("/usr/article/doAdd")
    @ResponseBody
    public ResultData doAdd(String title, String body) {

        if ( Ut.empty(title)){
            return ResultData.from("F-1", "title(을)를 입력해주세요");
        }
        
        if ( Ut.empty(body)){
            return ResultData.from("F-1", "body(을)를 입력해주세요");
        }

       ResultData writeArticleRd = articleService.writeArticle(title, body);
       int id = (int)writeArticleRd.getData1();

       Article article = articleService.getArticle(id);

       return ResultData.from(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), article);
    }

    @RequestMapping("/usr/article/doDelete")
    @ResponseBody
    public String doDelete(int id) {
        Article article = articleService.getArticle(id);

        if (article == null) {
            return id + "번 게시물이 존재하지 않습니다.";
        }
        articleService.deleteArticle(id);
        return id + "번 게시물을 삭제하였습니다.";
    }

    @RequestMapping("/usr/article/doModify")
    @ResponseBody
    public String doModify(int id, String title, String body) {
        Article article = articleService.getArticle(id);

        if (article == null) {
            return id + "번 게시물이 존재하지 않습니다.";
        }
        articleService.ModifyArticle(id, title, body);
        return id + "번 게시물을 수정하였습니다.";
    }

    // 액션메서드 끝
    @RequestMapping("/usr/article/getArticles")
    @ResponseBody
    public List<Article> getArticles() {
        return articleService.getArticles();
    }

    @RequestMapping("/usr/article/getArticle")
    @ResponseBody
    public ResultData getArticle(int id) {
        Article article = articleService.getArticle(id);

        if (article == null) {

            return ResultData.from("F-1", Ut.f("%d번 게시물이 존재하지 않습니다.", id));
        }
        return ResultData.from("S-1", Ut.f("%d번 게시물입니다.", id), article);
    }

}
