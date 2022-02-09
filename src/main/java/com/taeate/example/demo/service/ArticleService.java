package com.taeate.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import com.taeate.example.demo.vo.Article;

import org.springframework.stereotype.Service;

@Service
public class ArticleService {

    // 인스턴스 변수 시작
    private int articlesLastId;
    private List<Article> articles;

    // 인스턴스 변수 끝

    public ArticleService() {
        articlesLastId = 0;
        articles = new ArrayList<>();

        makeTestData();
    }

    public void makeTestData() {
        for (int i = 1; i <= 10; i++) {

            String title = "제목" + 1;
            String body = "내용" + 1;
            writeArticle(title, body);
        }
    }

    // 서비스 메서드 시작
    public Article writeArticle(String title, String body) {

        int id = articlesLastId + 1;
        Article article = new Article(id, title, body);

        articles.add(article);
        articlesLastId = id;

        return article;
    }

    public Article getArticle(int id) {
        for (Article article : articles) {
            if (article.getId() == id) {
                return article;
            }
        }
        return null;
    }

    public void deleteArticle(int id) {
        Article article = getArticle(id);

        articles.remove(article);
    }

    public void ModifyArticle(int id, String title, String body) {
        Article article = getArticle(id);

        article.setTitle(title);
        article.setBody(body);

    }

    public List<Article> getArticles() {
        return articles;
    }

    // 서비스 메서드 끝

}
