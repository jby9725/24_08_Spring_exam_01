package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrHomeController {
	
	@RequestMapping("/usr/home/getArticle")
	@ResponseBody
	public String getArticle() {
		
//		Article article = new Article(1, "제목", "내용");
//		
		return "Hello";
	} // /getArticle

}
