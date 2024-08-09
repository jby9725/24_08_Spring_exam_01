package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.vo.Article;

@Service
public class ArticleService {

	public List<Article> articles;
	private int lastID;

	public ArticleService() {
		lastID = 0;
		articles = new ArrayList<>();

		TestDataCreate();
	}

	public void TestDataCreate() {
		for (int i = 1; i <= 10; i++) {
			String title = "제목" + i;
			String body = "내용" + i;
			Article article = new Article(++lastID, title, body);
			articles.add(article);
		}
		System.out.println("Article List Test Data Created");
	}

	public Article getArticleById(int id) {
		Iterator<Article> iterator = articles.iterator();
		while (iterator.hasNext()) {
			Article article = iterator.next();
			if (article.getId() == id) {
				return article;
			}
		}
		return null;
	}
	
	public Article writeArticle(String title, String body) {
		int id = lastID + 1;
		Article article = new Article(id, title, body);
		articles.add(article);
		lastID++;
		return article;
	}

	public void deleteArticle(int id) {
		Article article = getArticleById(id);
		articles.remove(article);
	}

	public void modifyArticle(int id, String title, String body) {
		Article article = getArticleById(id);
		article.setTitle(title);
		article.setBody(body);
	}
}
