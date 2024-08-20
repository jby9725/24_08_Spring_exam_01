package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleRepository {

//	@Select("SELECT * FROM article ORDER BY id DESC")
	public List<Article> getArticles();

	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id}
				""")
	public Article getArticleById(int id);

	@Select("""
			SELECT A.* , M.nickname AS extra__writer
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			WHERE A.id = #{id}
			""")
	public Article getForPrintArticle(int id);

	@Select("""
			<script>
				SELECT A.* , M.nickname AS extra__writer
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE 1
				<if test="boardId != 0">
					AND boardId = #{boardId}
				</if>
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{limitTake}
				</if>
				</script>
			""")
	public List<Article> getForPrintArticles(int boardId, int limitFrom, int limitTake);
//	@Select("""
//			SELECT A.* , M.nickname AS extra__writer
//			FROM article AS A
//			INNER JOIN `member` AS M
//			ON A.memberId = M.id
//			WHERE A.boardId = #{boardId}
//			ORDER BY A.id DESC
//			LIMIT #{page}, #{pageSize}
//			""")
//	public List<Article> getForPrintArticles(int boardId, int page, int pageSize);

	@Select("""
			<script>
				SELECT COUNT(*) AS cnt
				FROM article
				WHERE 1
				<if test="boardId != 0">
					AND boardId = #{boardId}
				</if>
				ORDER BY id DESC;
			</script>
			""")
	public int getArticleCount(int boardId);
	
//	@Insert("INSERT INTO article SET regDate = NOW(), updateDate = NOW(), title = #{title}, `body` = #{body}")
	public void writeArticle(int memberId, String title, String body, String boardId);

	@Delete("DELETE FROM article WHERE id = #{id}")
	public void deleteArticle(int id);

//	@Update("UPDATE article SET updateDate = NOW(), title = #{title}, `body` = #{body} WHERE id = #{id}")
	public void modifyArticle(int id, String title, String body);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();
}