package com.taeate.example.demo.Repository;


import java.util.List;

import com.taeate.example.demo.vo.Article;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


@Mapper
public interface ArticleRepository {

    @Insert("insert into article set regDate = now(), updateDate = now(), title = #{title}, `body` = #{body}")
    public void writeArticle(@Param("title") String title, @Param("body") String body);

    @Select("select * from article where id = #{id}")
    public Article getArticle(@Param("id") int id);

    @Delete("delete from article where id = #{id}")
    public void deleteArticle(@Param("id") int id);

    @Update("update article set title = #{title}, `body` = #{body}, updateDate = now() where id = #{id}")
    public void ModifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

    @Select("select * from article order by id DESC") 
    public List<Article> getArticles();

    @Select("select last_insert_id()") 
    public int getLastInsertId();

}
