package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Article;

@Controller
public class UsrArticleController {

	private List<Article> articles;
	private int lastID = 0;

	public UsrArticleController() {
		articles = new ArrayList<>();

		TestDataCreate();
	}

	private void TestDataCreate() {
		for (int i = 1; i <= 10; i++) {
			String title = "제목" + i;
			String body = "내용" + i;
			Article article = new Article(++lastID, title, body);
			articles.add(article);
		}
		System.out.println("Article List Test Data Created");
	}

	@RequestMapping("/usr/article/doAdd")
	@ResponseBody
	public String doAdd(String title, String body) {

		Article article = new Article(++lastID, title, body);

		articles.add(article);

		return "article 생성됨 : " + article;
	} // /usr/article/doAdd?title=제목&body=내용

	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {

		return articles;
	} // /usr/article/getArticles

	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Iterator<Article> iterator = articles.iterator();
	    while (iterator.hasNext()) {
	        Article article = iterator.next();
	        if (article.getId() == id) {
	            iterator.remove(); // 안전하게 요소 제거
	            return id + "번 글이 삭제되었습니다.";
	        }
	    }

	    return id + "번 글이 없어 삭제되지 않았습니다.";
	} // /usr/article/doDelete?id=1

	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public Object doModify(int id, String title, String body) {

	    Iterator<Article> iterator = articles.iterator();
	    while (iterator.hasNext()) {
	        Article article = iterator.next();
	        if (article.getId() == id) {
	            // Article의 속성을 수정
	            article.setTitle(title);
	            article.setBody(body);
	            return id + "번 글이 수정되었습니다." + article;
	        }
	    }

	    return id + "번 글을 찾을 수 없어 수정되지 않았습니다.";
	} // /usr/article/doModify?id=1&title=새_제목&body=새_내용
}
