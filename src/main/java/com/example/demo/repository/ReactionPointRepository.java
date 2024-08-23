package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;

@Mapper
public interface ReactionPointRepository {

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(), updateDate = NOW(),
			memberId = #{memberId},
			relId = #{relId},
			relTypeCode = #{relTypeCode},
			`point` = #{point};
			""")
	public void addReactionPoint();
	
	@Delete("""
			DELETE FROM reactionPoint
			WHERE memberId = #{memberId} AND relId = #{relId} AND relTypeCode = #{relTypeCode};
			""")
	public void removeReactionPoint();
	
	@Update("""
			UPDATE reactionPoint
			set updateDate = NOW(),
			`point` = #{point}
			WHERE memberId = #{memberId} AND relId = #{relId} AND relTypeCode = #{relTypeCode};
			""")
	public void updateReactionPoint();
	
	
	@Update("""
			UPDATE article
			SET updateDate = NOW(),
			title = #{title},
			`body` = #{body}
			WHERE id = #{id}
			""")
	public void modifyArticle(int id, String title, String body);

	@Select("""
			SELECT A.*, M.nickname AS extra__writer,
			IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
			IFNULL(SUM(IF(RP.point &gt; 0,RP.point,0)),0) AS extra__goodReactionPoint,
			IFNULL(SUM(IF(RP.point &lt; 0,RP.point,0)),0) AS extra__badReactionPoint
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			LEFT JOIN reactionPoint AS RP
			ON A.id = RP.relId AND RP.relTypeCode = 'article'
			WHERE A.id = #{id}
				""")
	public Article getForPrintArticle(int id);

	@Select("""
			SELECT *
			FROM article
			WHERE id = #{id}
				""")
	public Article getArticleById(int id);

	@Select("""
			<script>
				SELECT A.* , M.nickname AS extra__writer, SUM(IFNULL(R.point, 0)) AS `like`
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				LEFT JOIN reactionPoint R
				ON R.relTypeCode = 'article' AND A.id = R.relId
				WHERE 1
				<if test="boardId != 0">
					AND boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'nickname'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				GROUP BY A.id
				ORDER BY A.id DESC
				<if test="limitFrom >= 0">
					LIMIT #{limitFrom}, #{limitTake}
				</if>
				</script>
			""")
	public List<Article> getForPrintArticles(int boardId, int limitFrom, int limitTake, String searchKeywordTypeCode, String searchKeyword);

	@Select("""
			SELECT A.* , M.nickname AS extra__writer
			FROM article AS A
			INNER JOIN `member` AS M
			ON A.memberId = M.id
			ORDER BY A.id DESC
			""")
	public List<Article> getArticles();

	@Select("SELECT LAST_INSERT_ID();")
	public int getLastInsertId();

	@Select("""
			<script>
				SELECT COUNT(*) , M.nickname AS extra__writer
				FROM article AS A
				INNER JOIN `member` AS M
				ON A.memberId = M.id
				WHERE 1
				<if test="boardId != 0">
					AND A.boardId = #{boardId}
				</if>
				<if test="searchKeyword != ''">
					<choose>
						<when test="searchKeywordTypeCode == 'title'">
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'body'">
							AND A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<when test="searchKeywordTypeCode == 'nickname'">
							AND M.nickname LIKE CONCAT('%', #{searchKeyword}, '%')
						</when>
						<otherwise>
							AND A.title LIKE CONCAT('%', #{searchKeyword}, '%')
							OR A.`body` LIKE CONCAT('%', #{searchKeyword}, '%')
						</otherwise>
					</choose>
				</if>
				ORDER BY A.id DESC;
			</script>
			""")
	public int getArticleCount(int boardId, String searchKeywordTypeCode, String searchKeyword);

	@Update("""
			UPDATE article
			SET hit = hit + 1
			WHERE id = #{id}
			""")
	public int increaseHitCount(int id);

	@Select("""
			SELECT hit
			FROM article
			WHERE id = #{id}
			""")
	public int getArticleHitCount(int id);

	@Update("""
			UPDATE article
			SET `like` = `like` + 1
			WHERE id = #{id}
			""")
	public int increaseLikeCount(int id);

	@Select("""
			SELECT `like`
			FROM article
			WHERE id = #{id}
			""")
	public int getArticleLikeCount(int id);
}