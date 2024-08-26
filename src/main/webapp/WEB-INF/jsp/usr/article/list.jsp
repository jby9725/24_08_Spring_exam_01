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
	border: 1px solid blue;
	color: black;
}

.styled-table th {
	font-weight: bold;
}

.styled-table a {
	text-decoration: none;
	color: red;
}
</style>

<c:set var="pageTitle" value="${board.code } LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<div class="mb-4">
	<button onclick="window.location.href='/usr/article/write'"
		class="bg-blue-500 text-white font-bold py-2 px-4 rounded hover:bg-blue-600">글 작성</button>
</div>

<div class="flex-grow"></div>
<!-- 			<form action="../article/list"> -->
<form action="">
	<input type="hidden" name="boardId" value="${param.boardId }" />
	<div class="flex">
		<select class="select select-sm select-bordered
						max-w-xs" name="searchKeywordTypeCode"
			data-value="${param.searchKeywordTypeCode } ">
			<option value="title">title</option>
			<option value="body">body</option>
			<option value="title,body">title+body</option>
			<option value="nickname">nicnkname</option>
		</select>
		<label class="ml-3 input input-bordered input-sm flex items-center gap-2">
			<input type="text" placeholder="Search" name="searchKeyword" value="${param.searchKeyword }" />
			<button type="submit">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="h-4 w-4 opacity-70">
    <path fill-rule="evenodd"
						d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
						clip-rule="evenodd" />
  </svg>
			</button>
		</label>
	</div>
</form>
</div>

<div>${articlesCount }개</div>

<hr />


<table class="table-auto w-full bg-white shadow-lg rounded-lg overflow-hidden">
    <thead class="bg-gray-100">
        <tr>
            <th class="p-4 text-left">ID</th>
            <th class="p-4 text-left">RegDate</th>
            <th class="p-4 text-left">Title</th>
            <th class="p-4 text-left">Nickname</th>
            <th class="p-4 text-left">Body</th>
            <th class="p-4 text-left">Sum</th>
            <th class="p-4 text-left">Like</th>
            <th class="p-4 text-left">Bad</th>
            <th class="p-4 text-left">Hit</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="article" items="${articles}">
            <tr class="border-b hover:bg-gray-50">
                <td class="p-4">${article.id}</td>
                <td class="p-4">${article.regDate.substring(0,10)}</td>
                <td class="p-4">
                    <a href="detail?id=${article.id}" class="text-blue-500 hover:underline">${article.title}</a>
                </td>
                <td class="p-4">${article.extra__writer}</td>
                <td class="p-4">${article.body}</td>
                <td class="p-4">${article.extra__sumReactionPoint}</td>
                <td class="p-4">${article.goodReactionPoint}</td>
                <td class="p-4">${article.badReactionPoint}</td>
                <td class="p-4">${article.hit}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty articles}">
            <tr>
                <td colspan="7" class="text-center p-4 text-gray-500">게시글이 없습니다</td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- 페이지 수 출력.. -->
<!-- 	동적 페이징 -->
<div class="pagination flex justify-center mt-3">
	<c:set var="paginationLen" value="3" />
	<c:set var="startPage" value="${page -  paginationLen  >= 1 ? page - paginationLen : 1}" />
	<c:set var="endPage" value="${page +  paginationLen  <= pagesCount ? page + paginationLen : pagesCount}" />

	<c:set var="baseUri" value="?boardId=${boardId }" />
	<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
	<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

	<c:if test="${startPage > 1 }">
		<a class="btn btn-sm" href="${ baseUri}&page=1">1</a>

	</c:if>
	<c:if test="${startPage > 2 }">
		<button class="btn btn-sm btn-disabled">...</button>
	</c:if>

	<c:forEach begin="${startPage }" end="${endPage }" var="i">
		<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }" href="${ baseUri}&page=${i }">${i }</a>
	</c:forEach>

	<c:if test="${endPage < pagesCount - 1 }">
		<button class="btn btn-sm btn-disabled">...</button>
	</c:if>

	<c:if test="${endPage < pagesCount }">
		<a class="btn btn-sm" href="${ baseUri}&page=${pagesCount }">${pagesCount }</a>
	</c:if>
</div>


<!-- 	직관적인 페이징 -->
<div class="pagination flex justify-center mt-3">
	<div class="btn-group">

		<c:forEach begin="1" end="${pagesCount }" var="i">
			<a class="btn btn-sm ${param.page == i ? 'btn-active':''}" href="${ baseUri}&page=${i }">${i }</a>
		</c:forEach>
	</div>
</div>

<%@ include file="../common/foot.jspf"%>