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

	@Select("""
			SELECT IFNULL(SUM(RP.point),0)
			FROM reactionPoint as RP
			WHERE RP.relTypeCode = #{relTypeCode}
			AND RP.relId = #{relId}
			AND RP.memberId = #{loginedMemberId};
			""")
	public int getSumReactionPoint(int loginedMemberId, String relTypeCode, int relId);

	@Insert("""
			INSERT INTO reactionPoint
			SET regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			relTypeCode = #{relTypeCode},
			relId = #{relId},
			`point` = 1;
			""")
	public int increaseReactionPoint(int memberId, String relTypeCode, int relId);

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

}