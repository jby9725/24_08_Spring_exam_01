<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<form action="/usr/article/doModify" method="POST">
	<input type="hidden" name="id" value="${article.id}">

	<div>
		<label for="title">Title:</label>
		<input type="text" id="title" name="title" value="${article.title}" required>
	</div>

	<div>
		<label for="body">Body:</label>
		<textarea id="body" name="body" rows="10" cols="30" required>${article.body}</textarea>
	</div>

	<div>
		<button type="submit">Submit</button>
		<a href="/usr/article/list">Cancel</a>
	</div>
</form>

<%@ include file="../common/foot.jspf"%>