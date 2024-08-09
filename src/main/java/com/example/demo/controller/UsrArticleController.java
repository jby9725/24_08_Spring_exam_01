package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Article;

@Controller
public class UsrArticleController {

	private List<Article> articles;
	private int lastID = 0;
	
	public UsrArticleController () {
		articles = new ArrayList<>();
	}
	
	@RequestMapping("/usr/article/doAdd")
	@ResponseBody
	public String addArticle(String title, String body) {
		
		Article article = new Article(++lastID, title, body);
		
		articles.add(article);
		
		return "article 생성됨 : " + article;
	} // /usr/article/doAdd?title=제목&body=내용

	@RequestMapping("/usr/article/getArticles")
	@ResponseBody
	public List<Article> getArticles() {
		
		return articles;
	} // /usr/article/getArticles
}
