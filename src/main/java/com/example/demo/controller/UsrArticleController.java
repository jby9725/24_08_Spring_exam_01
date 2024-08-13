package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {

	@Autowired
	private ArticleService articleService;

// 서비스 메서드 (내부에서 동작)
	//

// 액션 메서드 (외부와 통신)
	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public ResultData<List<Article>> getArticles() {
		List<Article> articles = articleService.getArticles();
		return ResultData.from("S-1", "Article List", articles);
	} // /usr/article/getArticles

	
	
	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public ResultData<Article> getArticle(int id) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
//			return id + "번 글이 없습니다.";
			return ResultData.from("F-1", Ut.f("%d번 게시글은 없습니다.", id));
		}

//		return id + "번 글 : " + article;
		return ResultData.from("S-1", Ut.f("%d번 게시글 입니다", id), article);
	} // /usr/article/getArticle?id=1

	
	
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData<Article> doWrite(HttpSession httpSession, String title, String body) {

		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 하고 써");
		}

		if (Ut.isEmptyOrNull(title)) {
			return ResultData.from("F-1", "제목을 입력해주세요.");
		}
		if (Ut.isEmptyOrNull(body)) {
			return ResultData.from("F-2", "내용을 입력해주세요.");
		}

		ResultData writeArticleRd = articleService.writeArticle(loginedMemberId, title, body);

		// 위 rd가 올바르게 생성이 되었다면 data1 부분에 id값이 들어가있다.
		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticleById(id);

		return ResultData.newData(writeArticleRd, article);

	} // /usr/article/doWrite?title=제목&body=내용
	
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public ResultData<Integer> doDelete(HttpSession httpSession, int id) {

		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 하고 써");
		}
		
		Article article = articleService.getArticleById(id);

		if (article == null) {
//			return id + "번 글이 없어 삭제되지 않았습니다.";
			return ResultData.from("F-1", Ut.f("%d번 글이 없어 삭제되지 않았습니다.", id), id);
		}

		articleService.deleteArticle(id);

//		return id + "번 글이 삭제되었습니다.";
		return ResultData.from("S-1", Ut.f("%d번 글이 삭제되었습니다.", id), id);

	} // /usr/article/doDelete?id=1

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public ResultData<Article> doModify(HttpSession httpSession, int id, String title, String body) {

		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-A", "로그인 하고 써");
		}
		
		// 수정되기 전 게시글
		Article article = articleService.getArticleById(id);

		if (article == null) {
			return ResultData.from("F-1", Ut.f("%d번 글을 찾을 수 없어 수정되지 않았습니다.", id));
		}

		articleService.modifyArticle(id, title, body);

		// 수정된 게시글 다시 불러옴
		article = articleService.getArticleById(id);

		return ResultData.from("S-1", Ut.f("%d번 게시글을 수정했습니다.", id), article);

	} // /usr/article/doModify?id=1&title=새_제목&body=새_내용
}
