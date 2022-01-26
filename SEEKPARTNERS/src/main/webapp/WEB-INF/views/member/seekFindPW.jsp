<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<link rel="stylesheet" href="/resources/assets/css/fontawesome.css">
	<link rel="stylesheet" href="/resources/assets/css/first-default.css">
	<link rel="stylesheet" href="/resources/assets/css/owl.css">
	<link rel="stylesheet" href="/resources/assets/css/lightbox.css">

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	<title>SEEK.PARTNERs</title>
</head>

<body>

  
		<!-- start header header-sticky  ----------------------------------------------------------------------------->
		<header class="header-area header-sticky background-header">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<nav class="main-nav">
							<!-- Logo Start  ----------------------------------------------------------------------------->
							<a href="/main" class="logo">Seek.Partner</a>
							<!-- Logo End -->
							
							<!-- Menu Start  ----------------------------------------------------------------------------->
							<ul class="nav">
								<li class="scroll-to-section">
									<a href="/main" class="active">Home</a>
								</li>
								<li class="has-sub">
									<a href="javascript:void(0)">회원정보관리</a>
									<ul class="sub-menu">
										<li><a href="/member/seekMyUpdate">회원정보수정</a></li>
										<li><a href="/member/seekMemberDelete">회원탈퇴</a></li>
									</ul>
								</li>
								
								<li class="has-sub">
									<a href="javascript:void(0)">내 활동</a>
									<ul class="sub-menu">
										<li><a href="rs-list.html">내 평가</a></li>
										<li><a href="/member/seekMyAct">식구 찾기</a></li>
										<li><a href="/member/seekMyReview">리뷰 보기</a></li>
									</ul>
								</li>
								
								<li class="has-sub">
									<a href="javascript:void(0)">문의/신고</a>
									<ul class="sub-menu">
										<li><a href="rs-list.html">문의/신고</a></li>
									</ul>
								</li>
								
								<!-- 로그인 한 유저일 때 마이페이지와 로그아웃 활성화 -->
								<sec:authorize access="isAuthenticated()">
								<li><a href="/member/seekMyPage">마이페이지</a></li>
								<li><a href="/member/seekMemberLogout">로그아웃</a></li>
								</sec:authorize>
								
								<!-- 로그인하지 않은 유저일 때 로그인과 회원가입 활성화 -->
								<sec:authorize access="isAnonymous()">
								<li><a href="/member/seekMemberLogin">로그인</a></li>
								<li><a href="/member/seekMemberSignup">회원가입</a></li>
								</sec:authorize>
								
							</ul>
							<a class='menu-trigger'>
								<span>Menu</span>
							</a>
							<!-- Menu End -->
						</nav>
					</div>
				</div>
			</div>
		</header>
		<!-- end header-sticky -->
		

	<div id="logcon">
		<div id="login">
			<div id="login-form" >
				<form role="form" method="post" action="/member/seekFindPW">
					<h3>Find.Password</h3>
					
					<div class="mt-4">
						<!-- <label class="form-label need-info">아이디</label> -->
						<input class="form-control input-boder-none" placeholder="아이디를 입력해주세요" id="m_id" name="m_id"  autofocus />
					</div>
					<div class="mt-4">
						<!-- <label class="form-label need-info">이메일</label> -->
						<input class="form-control input-boder-none" placeholder="이메일을 입력해주세요" id="m_email" name="m_email" />
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="d-grid gap-3 login-btn-box mt-5">
						<button id="btnC" class="btn btn-primary mt-3 btn-block">비밀번호 찾기</button>
						<%-- <input value='<c:out value="${result }" />' readonly>
						<input value="${result }" readonly> --%>
					</div>
					
				</form>
                <hr>
                <p class="find">
                    <span><a href="/member/seekFindID">아이디 찾기</a></span>
                    <span><a href="/member/seekMemberLogin">로그인</a></span>
                    <span><a href="/member/seekMemberSignup">회원가입</a></span>
                </p>

            </div>
        </div>
    </div>
		
	
<!-- Scripts -->
<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	
	<script src="../resources/assets/js/isotope.min.js"></script>
	<script src="../resources/assets/js/owl-carousel.js"></script>
	<script src="../resources/assets/js/lightbox.js"></script>
	<script src="../resources/assets/js/tabs.js"></script>
	<script src="../resources/assets/js/slick-slider.js"></script>
	<script src="../resources/assets/js/custom.js"></script>
	
	<script>
	$(document).ready(function(){
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});		
	});
	</script>
	
	
	<script type="text/javascript">
	
	$(function(){
		$("#btnC").on("click", function(e){
			
			e.preventDefault();
			
			$.ajax({
				url : "/member/seekFindPW",
				type : "POST",
				dataType : "JSON",
				data : {
					m_id : $("#m_id").val(),
					m_email : $("#m_email").val()
				},
				success : function(data) {
					console.log("I Am Temperbell : "+data);
				 	if($("#m_id").val() == "") {
						Swal.fire({ 
							icon: 'warning', // Alert 타입(success, warning, error)
							title: '필수 입력 항목 확인!', // Alert 제목
							text: '아이디를 입력해주세요', // Alert 내용
						});
		 	 			return;
		 	 		} 
		 			
		 			if($("#m_email").val() == "") {
		 				Swal.fire({ 
							icon: 'warning', // Alert 타입(success, warning, error)
							title: '필수 입력 항목 확인!', // Alert 제목
							text: '이메일을 입력해주세요', // Alert 내용
						});
		 	 			return;	
		 	 		}
					
					if(data == 0) {
						Swal.fire({ 
							icon: 'error', // Alert 타입(success, warning, error)
							title: '앗...!', // Alert 제목
							text: '일치하는 회원 정보가 없어요 :o', // Alert 내용
						});
						return;
						
					}
					if(data == 1) {
						
						let timerInterval
						Swal.fire({
						  icon: 'info', // Alert 타입(success, warning, error)
						  title: '잠시후 이메일로 임시비밀번호가 발송됩니다!',
						  html: '창을 닫지 말고 잠시만 기다려주세요 :)',
						  timer: 3500,
						  timerProgressBar: true,
						  didOpen: () => {
						    Swal.showLoading()
						    const b = Swal.getHtmlContainer().querySelector('b')
						    timerInterval = setInterval(() => {
						      /* b.textContent = Swal.getTimerLeft() */
						    }, 100)
						  },
						  willClose: () => {
						    clearInterval(timerInterval)
						  }
						}).then((result) => {
						  /* Read more about handling dismissals below */
						  if (result.dismiss === Swal.DismissReason.timer) {
						  }
						})
						return true;
					}
				},
			}); // ajax 통신 끝
		});
	})
	
	

 	$(document).ready(function(){

		$("#toMain").on("click", function(e){
			e.preventDefault();
			location.href = "/main";
		});
		
		$("#toSign").on("click", function(e){
			e.preventDefault();
			location.href = "/member/seekMemberSignup";
		});
		

	});
	</script>
</body>
</html>