package com.taeate.example.demo.service;

import java.util.List;

import com.taeate.example.demo.Repository.ArticleRepository;
import com.taeate.example.demo.vo.Article;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ArticleService {
    @Autowired
    private ArticleRepository articleRepository;

    public ArticleService(ArticleRepository articleRepository){
        this.articleRepository = articleRepository;
    }

    public Article writeArticle(String title, String body) {
        return articleRepository.writeArticle(title, body);
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