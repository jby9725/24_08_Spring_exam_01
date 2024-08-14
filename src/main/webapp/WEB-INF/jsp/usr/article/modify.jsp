<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />

<form action="/usr/article/doModify" method="POST" class="max-w-lg mx-auto p-6 bg-white shadow-md rounded">
    <input type="hidden" name="id" value="${article.id}">

    <div class="mb-4">
        <label for="title" class="block text-gray-700 font-bold mb-2">Title:</label>
        <input type="text" id="title" name="title" value="${article.title}" required
            class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-yellow-500">
    </div>

    <div class="mb-4">
        <label for="body" class="block text-gray-700 font-bold mb-2">Body:</label>
        <textarea id="body" name="body" rows="10" required
            class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-yellow-500">${article.body}</textarea>
    </div>

    <div class="flex justify-between items-center">
        <button type="submit" class="bg-yellow-500 text-white font-bold py-2 px-4 rounded hover:bg-yellow-600">Submit</button>
        <a href="/usr/article/list" class="text-gray-700 hover:underline">Cancel</a>
    </div>
</form>


<%@ include file="../common/foot.jspf"%>