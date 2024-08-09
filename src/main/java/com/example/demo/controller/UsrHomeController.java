package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UsrHomeController {
	
	private int count;
	
	public UsrHomeController() {
		count = 0;
	}
	
	@RequestMapping("/usr/home/main")
	@ResponseBody
	public String showMain() {
		return "Hi! Hello~!";
	}
	
	@RequestMapping("/usr/home/main2")
	@ResponseBody
	public String showMain2() {
		return "잘가세요!";
	}
	
	@RequestMapping("/usr/home/main3")
	@ResponseBody
	public int showMain3() {
		return 1+2;
	}
	
	@RequestMapping("/usr/home/getCount")
	@ResponseBody
	public int showMain4() {
		return count++;
	}

	@RequestMapping("/usr/home/setCountZero")
	@ResponseBody
	public String setCountZero() {
		count = 0;
		return "count 0 초기화";
	}

	@RequestMapping("/usr/home/setCountValue")
	@ResponseBody
	public String setCountValue(int value) {
		count = value;
		return "count "+ value +"(으)로 초기화";
	} // setCountValue?value=10
	
	@RequestMapping("/usr/home/getInt")
	@ResponseBody
	public String getInt(int value) {
		return "getInt value : " + value;
	} // /getInt?value=1
	
	@RequestMapping("/usr/home/getString")
	@ResponseBody
	public String getString(String value) {
		return "getString value : " + value;
	} // /getString?value=str
	
	@RequestMapping("/usr/home/getDouble")
	@ResponseBody
	public String getDouble(double value) {
		return "getDouble value : " + value;
	} // /getDouble?value=1.2

	@RequestMapping("/usr/home/getBoolean")
	@ResponseBody
	public String getBoolean(boolean value) {
		return "getBoolean value : " + value;
	} // /getBoolean?value=true

	///////////
	
	@RequestMapping("/usr/home/getMap")
	@ResponseBody
	public Map<String, Object> getMap() {
		
		Map<String, Object> map = new HashMap<>();
		map.put("철수나이", 11);
		map.put("영희나이", 12);
		
		return map;
	} // /getMap

	@RequestMapping("/usr/home/getList")
	@ResponseBody
	public List<String> getList() {
		
		List<String> list = new ArrayList<>();
		list.add("영수 나이");
		list.add("길동 나이");
		
		return list;
	} // /getList

	@RequestMapping("/usr/home/getArticle")
	@ResponseBody
	public Article getArticle() {
		
		Article article = new Article(1, "제목", "내용");
		
		return article;
	} // /getArticle

}
