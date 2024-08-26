package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.util.Ut;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrReactionPointController {

	@Autowired
	private Rq rq;

	@Autowired
	private ReactionPointService reactionPointService;

	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public Object doGoodReaction(String relTypeCode, int relId, String replaceUri) {


		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		// 현재 유저의 리액션의 상태 받아옴
		int usersReaction = (int) usersReactionRd.getData1();

		// 리액션이 좋아요가 이미 되어있다면?
		if (usersReaction == 1) {
			ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			return Ut.jsReplace("S-1", "좋아요 취소", replaceUri);
			// 리액션이 싫어요가 이미 되어있다면?
		} else if (usersReaction == -1) {
			// 싫어요 취소
			ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			// 다시 좋아요
			rd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			return Ut.jsReplace("S-2", "싫어요 했었음", replaceUri);
		}

		// 이미 되어있는 행동이 없으면 정상적으로 좋아요 실행
		ResultData reactionRd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		if (reactionRd.isFail()) {
			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
		}

		return Ut.jsReplace(reactionRd.getResultCode(), reactionRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public Object doBadReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		// 현재 유저의 리액션의 상태 받아옴
		int usersReaction = (int) usersReactionRd.getData1();

		// 리액션이 싫어요가 이미 되어있다면?
		if (usersReaction == -1) {
			// 싫어요 취소
			ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			return Ut.jsReplace("S-1", "싫어요 취소", replaceUri);
		// 리액션이 좋아요가 이미 되어있다면?
		} else if (usersReaction == 1) {
			// 좋아요 취소하고
			ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			// 싫어요 다시 하기
			rd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
			return Ut.jsReplace("S-2", "좋아요 했었음", replaceUri);
		}

		// 이미 되어있는 행동이 없으면 정상적으로 싫어요 실행
		ResultData reactionRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		if (reactionRd.isFail()) {
			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
		}

		return Ut.jsReplace(reactionRd.getResultCode(), reactionRd.getMsg(), replaceUri);
	}
}