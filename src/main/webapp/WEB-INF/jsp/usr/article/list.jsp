<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.styled-table {
	width: 100%;
	border-collapse: collapse;
	border: 2px solid blue;
}

.styled-table th, .styled-table td {
	text-align: center;
	padding: 5px;
	border: 1px solid yellow;
	color: yellow;
}

.styled-table th {
	font-weight: bold;
}

.styled-table a {
	text-decoration: none;
	color: white;
}
</style>

<script>
	function confirmDelete(articleId) {
		if (confirm("삭제하시겠습니까?")) {
			window.location.href = "delete?id=" + articleId;
		}
	}
</script>

<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<div class="mb-4">
	<button onclick="window.location.href='/usr/article/write'"
		class="bg-yellow-500 text-white font-bold py-2 px-4 rounded hover:bg-yellow-600">글 작성</button>
</div>

<div>${articlesCount }개</div>

<table class="styled-table">
	<thead>
		<tr>
			<th>ID</th>
			<th>RegDate</th>
			<th>Title</th>
			<th>Nickname</th>
			<th>Body</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="article" items="${articles}">
			<tr>
				<td>${article.id}</td>
				<td>${article.regDate.substring(0,10)}</td>
				<td>
					<a href="detail?id=${article.id}">${article.title}</a>
				</td>
				<td>${article.extra__writer}</td>
				<td>${article.body}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty articles}">
			<tr>
				<td colspan="4" style="text-align: center;">게시글이 없습니다</td>
			</tr>
		</c:if>
	</tbody>
</table>

<!-- 페이지 수 출력.. -->
<!-- 	동적 페이징 -->
<div class="pagination flex justify-center mt-3">
	<c:set var="paginationLen" value="2" />
	<c:set var="startPage" value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
	<c:set var="endPage" value="${page +  paginationLen  <= pagesCount ? page + paginationLen : pagesCount}" />

	<c:if test="${startPage > 1 }">
		<a class="btn btn-sm" href="?page=1&boardId=${boardId }">1</a>

	</c:if>
	<c:if test="${startPage > 2 }">
		<button class="btn btn-sm btn-disabled">...</button>
	</c:if>

	<c:forEach begin="${startPage }" end="${endPage }" var="i">
		<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }" href="?page=${i }&boardId=${boardId}">${i }</a>
	</c:forEach>

	<c:if test="${endPage < pagesCount - 1 }">
		<button class="btn btn-sm btn-disabled">...</button>
	</c:if>

	<c:if test="${endPage < pagesCount }">
		<a class="btn btn-sm" href="?page=${pagesCount }&boardId=${boardId }">${pagesCount }</a>
	</c:if>
</div>


<!-- 	직관적인 페이징 -->
<div class="pagination flex justify-center mt-3">
	<div class="btn-group">

		<c:forEach begin="1" end="${pagesCount }" var="i">
			<a class="btn btn-sm ${param.page == i ? 'btn-active':''}" href="?page=${i }&boardId=${param.boardId}">${i }</a>
		</c:forEach>
	</div>
</div>

<div>
	<!-- 검색 바 출력.. -->

</div>

<%@ include file="../common/foot.jspf"%>