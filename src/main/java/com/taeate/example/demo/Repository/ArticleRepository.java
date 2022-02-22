package com.taeate.example.demo.Repository;


import java.util.List;

import com.taeate.example.demo.vo.Article;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;



@Mapper
public interface ArticleRepository {
	public void writeArticle(@Param("memberId") int memberId, @Param("title") String title, @Param("body") String body);

	public Article getArticle(@Param("id") int id);

	public void deleteArticle(@Param("id") int id);

	public void modifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

	@Select("""
        select A.*,
		M.nickname AS extra__writerName
		from article AS A
		left join member AS M
		on A.memberId = M.id
        order by A.id DESC

	""")
	public List<Article> getArticles();

	public int getLastInsertId();
}