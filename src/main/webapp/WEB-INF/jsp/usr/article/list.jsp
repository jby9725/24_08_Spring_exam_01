<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
				<th style="text-align: center;">ID</th>
				<th style="text-align: center;">RegDate</th>
				<th style="text-align: center;">Title</th>
				<th style="text-align: center;">Member ID</th>
				<th style="text-align: center;">수정</th>
				<th style="text-align: center;">삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="article" items="${articles}">
				<tr>
					<td style="text-align: center;">${article.id}</td>
					<td style="text-align: center;">${article.regDate.substring(0,10)}</td>
					<td style="text-align: center;">
						<a href="detail?id=${article.id}">${article.title}</a>
					</td>
					<td style="text-align: center;">${article.memberId}</td>
					<td style="text-align: center;"><a href="modify?id=${article.id}">수정</a></td>
					<td style="text-align: center;">
						<a href="javascript:void(0);" onclick="confirmDelete(${article.id});">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>