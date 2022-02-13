package com.taeate.example.demo.Repository;


import java.util.List;

import com.taeate.example.demo.vo.Article;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;


@Mapper
public interface ArticleRepository {


    // 서비스 메서드 시작
    public Article writeArticle(String title, String body);

    @Select("select * from article where id = #{id}")
    public Article getArticle(@Param("id") int id);

    public void deleteArticle(int id);

    public void ModifyArticle(int id, String title, String body);

    public List<Article> getArticles();

}
