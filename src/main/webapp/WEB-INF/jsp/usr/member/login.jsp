<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>
<hr />


<form action="/usr/member/doLogin" method="post" class="max-w-md mx-auto mt-10 p-6 bg-white rounded-lg shadow-lg">
	<div class="mb-4">
		<label for="loginId" class="block text-sm font-medium text-gray-700">ID</label>
		<input type="text" id="loginId" name="loginId" required
			class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
	</div>
	<div class="mb-6">
		<label for="loginPw" class="block text-sm font-medium text-gray-700">Password</label>
		<input type="text" id="loginPw" name="loginPw" required
			class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
	</div>
	<div>
		<button type="submit"
			class="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">Login</button>
	</div>
</form>

<div class="btns">
	<button type="button" onclick="history.back()">뒤로가기</button>
</div>


<%@ include file="../common/foot.jspf"%>