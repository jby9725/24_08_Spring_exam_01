<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>One Article</title>
</head>
<body>
    <h1>Article Detail</h1>

	<hr />

    <table border="1" cellspacing="0" cellpadding="5">
        <tr>
            <th>ID</th>
            <td>${article.id}</td>
        </tr>
        <tr>
            <th>Title</th>
            <td>${article.title}</td>
        </tr>
        <tr>
            <th>Registration Date</th>
            <td>${article.regDate}</td>
        </tr>
        <tr>
            <th>Content</th>
            <td>${article.body}</td>
        </tr>
        <tr>
            <th>Member ID</th>
            <td>${article.memberId}</td>
        </tr>
    </table>

    <br>
    <a href="../article/list">Back to List</a>
</body>
</html>