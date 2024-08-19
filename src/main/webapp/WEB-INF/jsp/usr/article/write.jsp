<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />
<!-- 이제부터 내용.. -->

<section class="mt-24 text-xl px-4">
	<div class="mx-auto">
		<form action="../article/doWrite" method="POST">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>

					<tr>
						<th>게시판</th>
						<td style="text-align: center;">
							<select name="boardId">
								<option value="" selected disabled>게시판을 선택해주세요.</option>
								<option value="1">공지사항</option>
								<option value="2">자유</option>
								<option value="3">질의응답</option>
							</select>
						</td>

					</tr>

					<tr>
						<th>제목</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="title" autocomplete="off"
								type="text" placeholder="제목을 입력해주세요." />
						</td>

					</tr>
					<tr>
						<th>내용</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="body" autocomplete="off"
								type="text" placeholder="내용을 입력해주세요." />
						</td>

					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<button class="btn btn-primary">작성</button>
							<!-- 						<input class="btn btn-primary" -->
							<!-- 							type="submit" value="작성" />  -->
						</td>

					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
		</div>
	</div>
</section>

<!-- <form action="/usr/article/doWrite" method="POST" class="max-w-lg mx-auto p-6 bg-white shadow-md rounded"> -->
<!-- 	<div class="mb-4"> -->
<!-- 		<label for="title" class="block text-gray-700 font-bold mb-2">Title:</label> -->
<!-- 		<input type="text" id="title" name="title" required -->
<!-- 			class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-yellow-500"> -->
<!-- 	</div> -->

<!-- 	<div class="mb-4"> -->
<!-- 		<label for="body" class="block text-gray-700 font-bold mb-2">Body:</label> -->
<!-- 		<textarea id="body" name="body" rows="10" required -->
<!-- 			class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-yellow-500"></textarea> -->
<!-- 	</div> -->

<!-- 	<div class="flex justify-between items-center"> -->
<!-- 		<button type="submit" class="bg-yellow-500 text-white font-bold py-2 px-4 rounded hover:bg-yellow-600">Submit</button> -->
<!-- 		<a href="/usr/article/list" class="text-gray-700 hover:underline">Cancel</a> -->
<!-- 	</div> -->
<!-- </form> -->

<!-- 여기까지 내용 끝.. -->
<%@ include file="../common/foot.jspf"%>