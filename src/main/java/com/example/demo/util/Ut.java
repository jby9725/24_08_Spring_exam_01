package com.example.demo.util;

import java.lang.reflect.Array;
import java.util.Map;

// 유틸 담당 클래스 Ut
public class Ut {

	// String null, 공백 검사
	public static boolean isEmptyOrNull(String str) {
		return str == null || str.trim().length() == 0;
	}

	// 어떤 것이든 비어있는지 검사
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}
		if (obj instanceof String) {
			return ((String) obj).trim().length() == 0;
		}

		if (obj instanceof Map) {
			return ((Map<?, ?>) obj).isEmpty();
		}

		if (obj.getClass().isArray()) {
			return Array.getLength(obj) == 0;
		}

		return false;
	}

	// 화면에 보여주기 편한 형태로 바꿔서 출력
	public static String f(String format, Object... args) {

		return String.format(format, args);
	}
}