package com.example.demo.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.URLEncoder;
import java.util.Map;

// 유틸 담당 클래스 Ut
public class Ut {

	public static String jsReplace(String resultCode, String msg, String replaceUri) {

		if (resultCode == null) {
			resultCode = "";
		}
		if (msg == null) {
			msg = "";
		}
		if (replaceUri == null) {
			replaceUri = "/";
		}

		String resultMsg = resultCode + "/" + msg;

		return Ut.f("""
					<script>
						let resultMsg = '%s'.trim();

						if(resultMsg.length > 0){
							alert(resultMsg);
						}
						location.replace('%s');
					</script>
				""", resultMsg, replaceUri);
	}

	public static String jsHistoryBack(String resultCode, String msg) {
		if (resultCode == null) {
			resultCode = "";
		}
		if (msg == null) {
			msg = "";
		}

		String resultMsg = resultCode + "/" + msg;

		return Ut.f("""
					<script>
						let resultMsg = '%s'.trim();

						if(resultMsg.length > 0){
							alert(resultMsg);
						}
						history.back();
					</script>
				""", resultMsg);
	}

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

	// 웹 페이지의 현재 주소(URI)를 "UTF-8"이라는 방식으로 인코딩해주는 역할
	public static String getEncodedCurrentUri(String currentUri) {
		try {
			return URLEncoder.encode(currentUri, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return currentUri;
		}
	}
}