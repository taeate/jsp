package com.taeate.example.demo.Repository;


import java.util.List;

import com.taeate.example.demo.vo.Article;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;



@Mapper
public interface ArticleRepository {

    public void writeArticle(@Param("memberId") int memberId, @Param("title") String title, @Param("body") String body);

    public Article getArticle(@Param("id") int id);

    public void deleteArticle(@Param("id") int id);

    public void ModifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

    public List<Article> getArticles();

    public int getLastInsertId();

}
