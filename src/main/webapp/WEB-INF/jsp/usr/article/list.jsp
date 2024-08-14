<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LIST"></c:set>

<style>
.styled-table {
	width: 100%;
	border-collapse: collapse;
	background-color: black;
	border: 2px solid yellow;
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

<c:set var="pageTitle" value="LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

	<table class="styled-table" >
		<thead>
			<tr>
				<th>ID</th>
				<th>RegDate</th>
				<th>Title</th>
				<th>Nickname</th>
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
				</tr>
			</c:forEach>
		</tbody>
	</table>

<%@ include file="../common/foot.jspf"%>