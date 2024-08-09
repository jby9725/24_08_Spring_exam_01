package com.example.demo.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.repository.ArticleRepository;
import com.example.demo.vo.Article;

@Service
public class ArticleService {

	private ArticleRepository articleRepository;
	
	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository; 
		TestDataCreate();
	}

	public void TestDataCreate() {
		for (int i = 1; i <= 10; i++) {
			String title = "제목" + i;
			String body = "내용" + i;

			articleRepository.writeArticle(title, body);
		}
		System.out.println("Article List Test Data Created");
	}

	public List<Article> getArticles() {
		return articleRepository.getArticles();
	}

	public Article getArticleById(int id) {
		
		return articleRepository.getArticleById(id);
	}

	public int writeArticle(String title, String body) {
		articleRepository.writeArticle(title, body);
		return articleRepository.getLastInsertId();
	}

	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
	}

}
