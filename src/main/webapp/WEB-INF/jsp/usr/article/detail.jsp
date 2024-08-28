<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<!-- <iframe src="http://localhost:8080/usr/article/doIncreaseHitCount?id=757" frameborder="0"></iframe> -->
<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	
	params.memberId = parseInt('${loginedMemberId}')
	
	console.log(params);
	console.log(params.id);
	console.log(params.memberId);
	
// 	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp ? 'true' : 'false'};
//     var isAlreadyAddBadRp = ${isAlreadyAddBadRp ? 'true' : 'false'};
	var isAlreadyAddGoodRp = $
	{
		isAlreadyAddGoodRp
	};
	var isAlreadyAddBadRp = $
	{
		isAlreadyAddBadRp
	};
</script>

<script>
	// 조회수
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

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 1000);
	})
</script>

<!-- 좋아요 싫어요 버튼	-->
<script>
	function checkRP() {
		if (isAlreadyAddGoodRp == true) {
			$('#likeButton').toggleClass('btn-outline');
		} else if (isAlreadyAddBadRp == true) {
			$('#DislikeButton').toggleClass('btn-outline');
		} else {
			return;
		}
	}
function doGoodReaction(articleId) {
	if(isNaN(params.memberId) == true){
		if(confirm('로그인 창으로 이동하시겠습니까??')){
				console.log(window.location.href);
				console.log(encodeURIComponent(window.location.href));
			var currentUri = encodeURIComponent(window.location.href);
			window.location.href = '../member/login?afterLoginUri=' + currentUri;
		}
		return;
	}
	
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var likeCountC = $('.likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					var DislikeCountC = $('.DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);
			}
			
		});
	}
function doBadReaction(articleId) {
	
	if(isNaN(params.memberId) == true){
		if(confirm('로그인 창으로 이동하시겠습니까?')){
				console.log(window.location.href);
				console.log(encodeURIComponent(window.location.href));
			var currentUri = encodeURIComponent(window.location.href);
			window.location.href = '../member/login?afterLoginUri=' + currentUri;
			// 로그인 페이지에 원래 페이지의 정보를 포함시켜서 보냄
		}
		return;
	}
	
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var likeCountC = $('.likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					var DislikeCountC = $('.DislikeCount');
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
						
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						likeCountC.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						DislikeCountC.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}
	$(function() {
		checkRP();
	});
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
		<th>좋아요</th>
		<td id="likeCount" style="text-align: center;">${article.goodReactionPoint}</td>
	</tr>
	<tr>
		<th>싫어요</th>
		<td id="DislikeCount" style="text-align: center;">${article.badReactionPoint}</td>
	</tr>
	<!-- 	<tr> -->
	<!-- 		<th>좋아요 / 싫어요</th> -->
	<%-- 		<td>LIKE ${article.goodReactionPoint} / DISLIKE ${article.badReactionPoint}</td> --%>
	<!-- 	</tr> -->
	<tr>
		<th>게시판 번호</th>
		<td>${article.boardId}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${article.body}</td>
	</tr>
</table>

<div class="btns flex flex-col space-y-4">
	<!-- 좋아요와 싫어요 버튼을 한 줄에 배치 -->

	<div class="flex justyfy-center space-x-4">

		<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">
			👍 LIKE
			<span class="likeCount">${article.goodReactionPoint}</span>
		</button>
		<button id="DislikeButton" class="btn btn-outline btn-error" onclick="doBadReaction(${param.id})">
			👎 DISLIKE
			<span class="DislikeCount">${article.badReactionPoint}</span>
		</button>

	</div>

	<!-- 	<div class="flex justify-center space-x-4"> -->

	<!-- 		<button type="button" class="btn btn-outline btn-success article-detail__like-count" -->
	<%-- 			onclick="window.location.href='/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.currentUri}'"> --%>
	<%-- 			👍(●'◡'●) ${article.goodReactionPoint}</button> --%>

	<%-- 		<%-- 		<a href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" --%>

	<%-- 		<%-- 			class="btn btn-outline btn-success"> 👍(●'◡'●) ${article.goodReactionPoint}</a> --%>

	<%-- 		<a href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" --%>
	<%-- 			class="btn btn-outline btn-error">👎(╬▔皿▔)╯ ${article.badReactionPoint}</a> --%>

	<!-- 	</div> -->

	<!-- 뒤로 가기, 수정, 삭제 버튼들 -->
	<div class="flex justify-center space-x-4 mt-4">
		<button class="btn" type="button" onclick="history.back()">뒤로 가기</button>
		<c:if test="${article.userCanModify }">
			<a class="btn" href="../article/modify?id=${article.id }">수정</a>
		</c:if>
		<c:if test="${article.userCanDelete }">
			<a class="btn" href="../article/doDelete?id=${article.id }">삭제</a>
		</c:if>
	</div>
</div>


<%@ include file="../common/foot.jspf"%>