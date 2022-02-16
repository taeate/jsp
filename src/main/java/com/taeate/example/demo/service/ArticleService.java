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

    public ResultData writeArticle(int MemberId, String title, String body) {
        articleRepository.writeArticle(MemberId,title, body);
        int id = articleRepository.getLastInsertId();

        return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
    }

    public Article getArticle(int id) {
        return articleRepository.getArticle(id);
    }

    public List<Article> getArticles() {
        return articleRepository.getArticles();
    }

    public ResultData ModifyArticle(int id, String title, String body) {
        articleRepository.modifyArticle(id, title, body);

        Article article = getArticle(id);

        return ResultData.from("S-1", Ut.f("%d번 게시물을 수정하였습니다.", id), "article", article);
    }

    public void deleteArticle(int id) {
        articleRepository.deleteArticle(id);
    }

    public ResultData actorCanModify(int actorId, Article article) {
        if (article == null){
            return ResultData.from("F-1", "권한이 없습니다.");
        }

        if (article.getMemberId() != actorId ){
            return ResultData.from("F-2", "권한이 없습니다.");
        }
    return ResultData.from("S-1", "수정가능합니다.");
    }
}