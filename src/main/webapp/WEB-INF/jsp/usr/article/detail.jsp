<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<!-- <iframe src="http://localhost:8080/usr/article/doIncreaseHitCount?id=757" frameborder="0"></iframe> -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__doIncreaseHitCount() {
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}
	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	})
</script>

<table border="1" cellspacing="0" cellpadding="5">
	<tr>
		<th>번호</th>
		<td>${article.id}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${article.title}</td>
	</tr>
	<tr>
		<th>작성일자</th>
		<td>${article.regDate}</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${article.extra__writer}</td>
	</tr>
	<tr>
		<th>조회수</th>
		<td><span class="article-detail__hit-count">${article.hit}</span></td>
	</tr>
	<tr>
		<th>게시판 아이디</th>
		<td>${article.boardId}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${article.body}</td>
	</tr>
</table>

<div class="btns">
	<button class="btn" type="button" onclick="history.back()">뒤로 가기</button>
	<c:if test="${article.userCanModify }">
		<a class="btn" href="../article/modify?id=${article.id }">수정</a>
	</c:if>
	<c:if test="${article.userCanDelete }">
		<a class="btn" href="../article/doDelete?id=${article.id }">삭제</a>
	</c:if>
</div>

</body>
</html>