package com.example.demo.controller;

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
	}
	
}
