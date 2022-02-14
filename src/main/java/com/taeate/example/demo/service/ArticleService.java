package com.taeate.example.demo.service;

import java.util.List;

import com.taeate.example.demo.Repository.ArticleRepository;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Article;
import com.taeate.example.demo.vo.ResultData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {
    @Autowired
    private ArticleRepository articleRepository;

    public ArticleService(ArticleRepository articleRepository){
        this.articleRepository = articleRepository;
    }

    public ResultData writeArticle(String title, String body) {
        articleRepository.writeArticle(title, body);
        int id = articleRepository.getLastInsertId();

        return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), id);
    }

    public Article getArticle(int id) {
        return articleRepository.getArticle(id);
    }

    public List<Article> getArticles() {
        return articleRepository.getArticles();
    }

    public void ModifyArticle(int id, String title, String body) {
        articleRepository.ModifyArticle(id, title, body);
    }

    public void deleteArticle(int id) {
        articleRepository.deleteArticle(id);
    }
}