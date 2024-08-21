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

		// 사용자가 처음 들어오는 게시물인지 확인하는 작업.
		// 브라우저 내 로컬 저장소에 있는 정보를 토대로 조회수를 증가/방치 한다.  
		const localStorageKey = 'article__' + params.id + '__alreadyOnView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);

		// 조회수 증가(부분 새로고침으로)
		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}
	
	function ArticleDetail__doIncreaseLikeCount() {
		// 사용자가 처음 들어오는 게시물인지 확인하는 작업2
		// 브라우저 내 로컬 저장소에 있는 정보를 토대로 좋아요를 증가/방치 한다.  
		const localStorageKey = 'article__' + params.id + '__alreadyOnLike';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		
		localStorage.setItem(localStorageKey, true);

		// 좋아요 증가(부분 새로고침으로)
		$.get('../article/doIncreaseLikeCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__like-count').empty().html(data.data1);
		}, 'json')
	} 
	
	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 1000);
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
		<td>
			<span class="article-detail__hit-count">${article.hit}</span>
		</td>
	</tr>
	<tr>
	</tr>
	<tr>
		<th>게시판 번호</th>
		<td>${article.boardId}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${article.body}</td>
	</tr>
</table>

<div class="btns flex flex-col items-center space-y-4">
		<!-- 좋아요 버튼 추가 -->
<!--   <button class="btn btn-accent " onclick="ArticleDetail__doIncreaseLikeCount()" type="button"> -->
<!--     <svg -->
<!--     xmlns="http://www.w3.org/2000/svg" -->
<!--     class="h-6 w-6" -->
<!--     fill="none" -->
<!--     viewBox="0 0 24 24" -->
<!--     stroke="currentColor"> -->
<!--     <path -->
<!--       stroke-linecap="round" -->
<!--       stroke-linejoin="round" -->
<!--       stroke-width="2" -->
<!--       d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" /> -->
<!--   </svg> -->
<!--     좋아요 -->
<!--   </button> -->
  
  <!-- 뒤로 가기, 수정, 삭제 버튼들 -->
  <div class="space-y-2">
    <button class="btn" type="button " onclick="history.back()">뒤로 가기</button>
    <c:if test="${article.userCanModify }">
      <a class="btn" href="../article/modify?id=${article.id }">수정</a>
    </c:if>
    <c:if test="${article.userCanDelete }">
      <a class="btn" href="../article/doDelete?id=${article.id }">삭제</a>
    </c:if>
  </div>
</div>

</body>
</html>