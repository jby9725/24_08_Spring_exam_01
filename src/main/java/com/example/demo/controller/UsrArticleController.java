package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.vo.Article;

@Controller
public class UsrArticleController {

	@Autowired
	private ArticleService articleService;
	
// 서비스 메서드 (내부에서 동작)
	//

// 액션 메서드 (외부와 통신)
	@RequestMapping("/usr/article/doAdd")
	@ResponseBody
	public String doAdd(String title, String body) {

		int id = articleService.writeArticle(title, body);
		Article article = articleService.getArticleById(id);
		
		return "article 생성됨 : " + article;
	} // /usr/article/doAdd?title=제목&body=내용

	
	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {

		return articleService.getArticles();
	} // /usr/article/getArticles

	
	@RequestMapping("/usr/article/getArticle")
	@ResponseBody
	public Object getArticle(int id) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return id + "번 글이 없습니다.";
		}

		return id + "번 글 : " + article;
	} // /usr/article/getArticle?id=1
	
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return id + "번 글이 없어 삭제되지 않았습니다.";
		}

		articleService.deleteArticle(id);

		return id + "번 글이 삭제되었습니다.";

	} // /usr/article/doDelete?id=1

	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return id + "번 글을 찾을 수 없어 수정되지 않았습니다.";
		}

		articleService.modifyArticle(id, title, body);
		
		return id + "번 글이 수정되었습니다.\n" + article;

	} // /usr/article/doModify?id=1&title=새_제목&body=새_내용
}
