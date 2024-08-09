package com.example.demo.repository;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Component;

import com.example.demo.vo.Article;

@Component
public class ArticleRepository {

	public static List<Article> articles;
	private static int lastID;

	public ArticleRepository() {
		lastID = 0;
		articles = new ArrayList<>();
	}

	public List<Article> getArticles() {
		return articles;
	}

	public Article writeArticle(String title, String body) {
		int id = lastID + 1;
		Article article = new Article(id, title, body);
		articles.add(article);
		lastID++;
		return article;
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
