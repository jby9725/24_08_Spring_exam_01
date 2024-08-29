<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN"></c:set>
<%@ include file="../common/head.jspf"%>

<hr />
<!-- 이제부터 내용.. -->

<script>
    $(document).ready(function() {
        $('form').on('submit', function(event) {
            console.log("폼 제출 이벤트 발생"); // 디버깅용 로그

            // 비밀번호와 비밀번호 확인 비교
            var loginPw = $('#loginPw').val();
            var loginPwConfirm = $('#loginPwConfirm').val();

            if (loginPw !== loginPwConfirm) {
                alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                event.preventDefault(); // 폼 제출 막기
                return;
            }

            // 휴대폰 번호 형식 유효성 검사 (숫자만 포함되어 있는지 확인)
            var cellphoneNum = $('#cellphoneNum').val();
            var phonePattern = /^[0-9]+$/;

            if (!phonePattern.test(cellphoneNum)) {
                alert('휴대폰 번호는 숫자만 입력해야 합니다.');
                event.preventDefault(); // 폼 제출 막기
                return;
            }

            // 추가적인 유효성 검사가 필요한 경우 여기에 추가
            console.log("유효성 검사 통과"); // 디버깅용 로그
        });
    });
</script>


<div class="max-w-md mx-auto mt-10 p-6 bg-white shadow-lg rounded-lg">
	<h2 class="text-2xl font-bold mb-6 text-center">회원가입</h2>
	<form action="/usr/member/doJoin" method="POST" class="space-y-4">
		<div>
			<label for="loginId" class="block text-sm font-medium text-gray-700">아이디</label>
			<input type="text" id="loginId" name="loginId" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="loginPw" class="block text-sm font-medium text-gray-700">비밀번호</label>
			<input type="text" id="loginPw" name="loginPw" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="loginPwConfirm" class="block text-sm font-medium text-gray-700">비밀번호 확인</label>
			<input type="text" id="loginPwConfirm" name="loginPwConfirm" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="name" class="block text-sm font-medium text-gray-700">이름</label>
			<input type="text" id="name" name="name" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="nickname" class="block text-sm font-medium text-gray-700">닉네임</label>
			<input type="text" id="nickname" name="nickname" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="cellphoneNum" class="block text-sm font-medium text-gray-700">휴대폰 번호</label>
			<input type="text" id="cellphoneNum" name="cellphoneNum" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div>
			<label for="email" class="block text-sm font-medium text-gray-700">이메일</label>
			<input type="email" id="email" name="email" required
				class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-yellow-500 focus:border-yellow-500 sm:text-sm">
		</div>
		<div class="flex justify-between items-center mt-6">
			<button type="submit" class="bg-yellow-500 text-white font-bold py-2 px-4 rounded hover:bg-yellow-600">회원가입
			</button>
			<a href="/usr/member/login" class="btn text-sm text-yellow-500 hover:underline">로그인 페이지로</a>
		</div>
	</form>
</div>

<!-- 여기까지 내용 끝.. -->
<%@ include file="../common/foot.jspf"%>