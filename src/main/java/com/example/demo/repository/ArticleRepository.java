package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleRepository {

	// SELECT *
//	@Select("SELECT * FROM article ORDER BY id DESC")
	public List<Article> getArticles();

	// SELECT *
//	@Select("SELECT * FROM article WHERE id = #{id}")
	public Article getArticleById(int id);

	// INSERT INTO
//	@Insert("INSERT INTO article SET regDate = NOW(), updateDate = NOW(), title = #{title}, `body` = #{body}")
	public void writeArticle(int memberId, String title, String body);

	// DELETE FROM
	@Delete("DELETE FROM article WHERE id = #{id}")
	public void deleteArticle(int id);

	// UPDATE article
//	@Update("UPDATE article SET updateDate = NOW(), title = #{title}, `body` = #{body} WHERE id = #{id}")
	public void modifyArticle(int id, String title, String body);

	// SELECT LAST_INSERT_ID()
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();
}
