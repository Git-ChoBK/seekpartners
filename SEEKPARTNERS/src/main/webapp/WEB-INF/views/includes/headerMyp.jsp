<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section class="mypageform" id="mypage">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="section-heading">
					<h2>마이페이지</h2>
				</div>
			</div>
			<!--왼쪽 : 메뉴-->
			<div class="col-md-4 left-inforamtion">
				<div class="categories">
					<h4>내 정보 수정</h4>
					<ul>
						<li><a href="/member/seekMyUpdate">회원 정보 수정</a></li>
						<br>
						<li><a href="/member/seekMemberDelete">회원 탈퇴</a></li>
					</ul>
					<br>
					<h4>내 활동</h4>
					<ul>
					<!-- 수정 ------------------------------------------------>
					<sec:authentication property="principal" var="prin"/>	
                	<li><a href="/score/my/<c:out value="${prin.username}"/>">내 평가</a></li>             
                	<!-- 수정 ----------->   
						<br>
						<li><a href="/member/seekMyAct">식구 찾기</a></li>
						<br>
						<li><a href="/member/seekMyReviews">리뷰 보기</a></li>
						<br>
					</ul>
					<br>
					<h4>고객센터</h4>
					<ul>
						<li><a href="/member/rpBoard/rpList">문의하기</a></li>
						<br>
						<li><a href="/member/pReport/pRList">신고내역</a></li>
					</ul>
				</div>
			</div>
			<!--왼쪽 메뉴 끝-->
    