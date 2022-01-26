<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap core CSS -->
	<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Additional CSS Files -->
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

                <form role="form" method="post" action="/member/seekMemberSignup">
                    <h3>Seek.SignUp</h3>
                    <div class="mt-4">
                        <!-- <label class="need-info">회원ID</label> -->
                        <input autocomplete="off" class="form-control input-boder-none" id="userid" placeholder="아이디를 입력해주세요" name="m_id" autocomplete='off' autofocus />
                        <p id="id_check"></p>
                    </div>
                        
                    <div class="mt-4">
                        <!-- <label class="need-info">이메일</label> -->
                        <input autocomplete="off" class="form-control input-boder-none mail_input" id="email" placeholder="Email을 입력해주세요" name="m_email" autocomplete='off' />
                    </div>
                    <!-- 인증번호 전송 -->
                    <div id="auth-group" class="mt-1">
                   		<input autocomplete="off" class="authNumber" disabled="disabled" style="text-align:left;">
                   		<span class="authSender btn btn-sm btn-primary pull-right">인증번호 전송</span>
	                   	<p id="email_check"></p>
	                    <p id="mailAuth"></p>
                        
                    </div>
                    
                    <div class="mt-4">
                        <!-- <label class="need-info">비밀번호</label> -->
                        <input class="form-control input-boder-none" id="userpw" placeholder="비밀번호를 입력해주세요" name="m_pw" type="password" />
                        <p id="pw_check"></p>
                    </div>
                    
                    <div class="mt-4">
                        <!-- <label class="need-info">비밀번호 확인</label> -->
                        <input class="form-control input-boder-none" id="doubleCheck" placeholder="비밀번호 확인" type="password" />
                        <p id="double_check"></p>
                    </div>									
                        
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        
                    <div class="d-grid gap-3 login-btn-box mt-5">
                        <button id="sign-up-btn" class="btn btn-primary btn-block">회원가입</button>
                    </div>
                    
                    <div class="mt-2" style="text-align:center;">
                        <p id="infoMsg" style="color:red"><c:out value="${check }"/></p>
                    </div>	
                </form>
                <hr>
                <p class="find">
                    <span><a href="/member/seekFindID">아이디 찾기</a></span>
                    <span><a href="/member/seekFindPW">비밀번호 찾기</a></span>
                    <span><a href="/member/seekMemberLogin">로그인</a></span>
                </p>

            </div>
        </div>
    </div>
		



	
<!-- Scripts -->
<!-- Bootstrap core JavaScript -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	
	<script src="/resources/assets/js/isotope.min.js"></script>
	<script src="/resources/assets/js/owl-carousel.js"></script>
	<script src="/resources/assets/js/lightbox.js"></script>
	<script src="/resources/assets/js/tabs.js"></script>
	
	<script src="/resources/assets/js/slick-slider.js"></script>
	<script src="/resources/assets/js/custom.js"></script>
	
	<!-- Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 -->
	<script>
	$(document).ready(function(){
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});		
	});
	</script>
	
	<script>
	
	var code = ""; // 이메일에 전송된 인증번호를 저장할 코드
	
	$(document).ready(function(){
		
		//아이디 중복 확인
		//아이디 정규식 (5~15자 영문+숫자)
		//var idReg = /^[A-za-z0-9]{5,15}/g;
		var idReg = /^(?=.*[a-zA-Z])[-a-zA-Z0-9]{5,15}$/;
		$("#userid").keyup(function(){
			
			//keyup안에서 입력 아이디를 호출하여 실시간으로 결과를 반영할 수 있도록 한다.
			var idVal = $("#userid").val();

			$.ajax({
				url : "/member/idCheck",
				type : "POST",
				dataType : "JSON",
				data : {"m_id" : idVal},
				success : function(data){
					
					/* if(idVal.length == 0){
						$("#id_check").html("");
						return false;
					} */
					
					if(data == 1) {
						$("#id_check").html("중복된 아이디입니다.").css("color", "red");
					} else {
						if(idVal.match(idReg) != null){
							$("#id_check").html("사용 가능한 아이디입니다.").css("color", "blue");
							return true;
						} else {
							$("#id_check").html("아이디는 5~15자 사이 영문 또는 영문+숫자 조합만 가능합니다.").css("color", "red");
							return false;
						}
					}
				}
			}); // ajax 끝	
		}); // 아이디 중복확인 끝

		

		//이메일 중복 확인
		//이메일 정규식
		var emailReg =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;;
		$("#email").keyup(function(){
			
			var emailVal = $("#email").val(); 
			$.ajax({
				url : "/member/emailCheck",
				type : "POST",
				dataType : "JSON",
				data : {"m_email" : emailVal},
				success : function(data){
					
					/* if(emailVal.length == 0){
						$("#email_check").html("");
						return false; 
					}*/
					
					if(data == 1) {
						$("#email_check").html("중복된 이메일입니다.").css("color", "red");
					} else {
						if(emailVal.match(emailReg) != null ){
							$("#email_check").html("사용 가능한 이메일입니다.").css("color", "blue");
							return true;
						} else {
							$("#email_check").html("유효하지 않은 이메일 형식입니다.").css("color", "red");
							return false;
						}
					}
				}
			});//ajax 끝
		});	//이메일 중복확인 끝



		//비밀번호 유효성 확인
		//비밀번호 안내문구 출력
		$("#userpw").focusin(function(){
			$("#pw_check").html("영문/숫자/특수문자 2가지 이상 조합 (8~20자)<br>3개 이상 연속되거나 동일한 문자/숫자 제외").css("color", "blue");
		});
		
		//비밀번호 정규식
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
		$("#userpw").keyup(function(){
			
			var pwVal = $("#userpw").val();
			
			if(pwVal.match(pwReg) != null ){
				$("#pw_check").html("");
				//비밀번호 확인
				
				$("#doubleCheck").keyup(function(){
			
					var dcVal = $("#doubleCheck").val();
					var dummy = $("#userpw").val();
					
					if(dcVal === dummy){
						$("#double_check").html("비밀번호가 일치합니다.").css("color", "blue");
						return true;
					} else {
						$("#double_check").html("비밀번호가 일치하지 않습니다.").css("color", "red");
						return false;
					}	
				}); // 비밀번호 확인 끝
				return true;
			} else {
				$("#pw_check").html("유효하지 않은 비밀번호 형식입니다.").css("color", "red");
				
				$("#doubleCheck").keyup(function(){
					
					var dcVal = $("#doubleCheck").val();
					var dummy = $("#userpw").val();
					
					if(dcVal === dummy){
						$("#double_check").html("유효성 검사를 먼저 해주세요.").css("color", "red");
						return false;
					}
				});
				
				return false;
			}	
		});// 비밀번호 유효성 확인 끝
		
		$("#sign-up-btn").on("click", function(e){
			e.preventDefault();
			if($("#userid").val() === ""){
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '아이디를 입력해주세요', // Alert 내용
				});
        		
        		return;
				$("#userid").focus();
				return;
			} else if($("#email").val() === "") {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '이메일을 입력해주세요', // Alert 내용
				});
        		
        		return;
				$("#email").focus();
				return;
			} else if($("#userpw").val() === "") {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '비밀번호를 입력해주세요', // Alert 내용
				});
        		
        		return;
				$("#userpw").focus();
				return;
			} else if ($("#userpw").val() != $("#doubleCheck").val() || $("#userpw").val().match(pwReg) == null || $("#doubleCheck").val() == null ) {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '회원가입 양식을 다시 확인해주세요', // Alert 내용
				});
				return;
			} else if (!$("#mailAuth").hasClass('true')) {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '인증 실패!', // Alert 제목
					text: '이메일 인증 후 시도해주세요!', // Alert 내용
				});
				return;
			}

			Swal.fire({ 
				icon: 'success', // Alert 타입(success, warning, error)
				title: '회원가입 성공!', // Alert 제목
				text: '로그인 페이지로 이동할게요!', // Alert 내용
			}).then(function(){
				$("form").submit();
			});
    					   
		 });
		//회원가입 실행
		
		$("#toMain").on("click", function(e){
			e.preventDefault();
			location.href = "/main";
		});
		
		
		
		//인증번호 이메일 전송
		$(".authSender").on("click", function(){
						
			var email = $(".mail_input").val(); // 입력한 이메일
			var checkBox = $(".authNumber");
			
			if(email == "") {
				Swal.fire({ 
					icon: 'error', // Alert 타입(success, warning, error)
					title: '이메일 오류!', // Alert 제목
					text: '이메일을 입력해주세요!', // Alert 내용
				});
				return;
			}
			
			let timerInterval
			Swal.fire({
			  icon: 'info', // Alert 타입(success, warning, error)
			  title: '잠시후 이메일로 인증번호가 발송됩니다!',
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
			
			$.ajax({
				type:"GET",
				url:"mailCheck?email=" + email,
				success:function(data){
					console.log("I Am Temperbell :" + data);
					checkBox.attr("disabled", false);
					code = data;
				}
			});
		});
		
		$(".authNumber").keyup(function(){
			
			var inputCode = $(".authNumber").val(); // 입력코드
			var checkResult = $("#mailAuth"); // 비교
			
			if(inputCode == code) {
				checkResult.html("인증번호가 일치합니다.").css("color", "blue");
				$("#email_check").html("");
				checkResult.addClass("true");
			} else {
				checkResult.html("인증번호를 다시 확인해주세요.").css("color", "red");
				checkResult.removeClass("true");
				$("#email_check").html("");
			}
			
		});


			
			
	}); //document.ready 끝
	
	
	


	</script>
</body>
</html>