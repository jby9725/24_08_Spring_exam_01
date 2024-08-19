package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrArticleController {
	
	@Autowired
	private Rq rq;

	@Autowired
	private ArticleService articleService;

// 서비스 메서드 (내부에서 동작)
	//

// 액션 메서드 (외부와 통신)
	@RequestMapping("/usr/article/write")
	public String writeArticle(HttpServletRequest req) {
		
		return "/usr/article/write";
	}
	
	@RequestMapping("/usr/article/list")
	public String showArticleList(Model model) {

		List<Article> articles = articleService.getArticles();
		model.addAttribute("articles", articles);

		return "/usr/article/list";
	}

	@RequestMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		model.addAttribute("article", article);

		return "usr/article/detail";
	}

	@RequestMapping("/usr/article/modify")
	public String articleModify(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		model.addAttribute("article", article);

		return "/usr/article/modify";
	}

	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public ResultData<List<Article>> getArticles() {
		List<Article> articles = articleService.getArticles();
		return ResultData.from("S-1", Ut.f("Article List"), "게시글 목록", articles);
	} // /usr/article/getArticles

	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public ResultData<Article> getArticle(int id) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
//			return id + "번 글이 없습니다.";
			return ResultData.from("F-1", Ut.f("%d번 게시글은 없습니다.", "게시글 없음", id));
		}

//		return id + "번 글 : " + article;
		return ResultData.from("S-1", Ut.f("%d번 게시글 입니다", id), "게시글 하나", article);
	} // /usr/article/getArticle?id=1

	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpServletRequest req, String title, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		if (Ut.isEmptyOrNull(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), title, body);

		// 위 rd가 올바르게 생성이 되었다면 data1 부분에 id값이 들어가있다.
		int id = (int) writeArticleRd.getData1();

		Article article = articleService.getArticleById(id);

		return Ut.jsReplace(writeArticleRd.getResultCode(), writeArticleRd.getMsg(), "../article/detail?id=" + id);
	}

	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 삭제
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		// 유무 체크
		Article article = articleService.getArticleById(id);

		if (article == null) {
//			return id + "번 글이 없어 삭제되지 않았습니다.";
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글이 없어 삭제되지 않았습니다.", id));
		}

		// 권한 체크
		ResultData userCanDeleteRd = articleService.userCanDelete(rq.getLoginedMemberId(), article);

		if (userCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
		}

		if (userCanDeleteRd.isSuccess()) {
			articleService.deleteArticle(id);
		}

		return Ut.jsReplace(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg(), "../article/list");

	} // /usr/article/doDelete?id=1

	// 로그인 체크 -> 유무 체크 -> 권한 체크 -> 수정
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String title, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		// 수정되기 전 게시글
		Article article = articleService.getArticleById(id);

		// 게시글 유무 체크
		if (article == null) {
//			return ResultData.from("F-1", Ut.f("%d번 글을 찾을 수 없어 수정되지 않았습니다.", id));
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 글을 찾을 수 없어 수정되지 않았습니다.", id));
		}

		// 권한 체크
		ResultData userCanModifyRd = articleService.userCanModify(rq.getLoginedMemberId(), article);

		if (userCanModifyRd.isFail()) {
			return Ut.jsHistoryBack("F-2", Ut.f("%d번 글을 수정할 권한이 없습니다.", id));
//			return userCanModifyRd;
		}

		// 수정
		if (userCanModifyRd.isSuccess()) {
			articleService.modifyArticle(id, title, body);
		}

		// 수정된 게시글 다시 불러옴
		article = articleService.getArticleById(id);

//		return ResultData.from(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg(), "수정 된 게시글", article);
//		return Ut.jsHistoryBack("S-1", Ut.f("%d번 글을 수정하였습니다.", id));
		return Ut.jsReplace(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg(), "../article/list");
	} // /usr/article/doModify?id=1&title=새_제목&body=새_내용
}
