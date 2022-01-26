<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/headerMyp.jsp" %>


<!--오른쪽 : 내용-->
<div class="col-md-8">
	<div class="row">
		<div class="categories right-section">
			<div class="container">
				<h2>회원 정보 수정</h2>
				<br>
				<form role="form" method="post" action="/member/seekMyUpdate">
					<fieldset>
					<div class="mt-4">
						<label class="form-label"></label>
						<input id="userid" class="form-control input-boder-none" name="m_id" type="hidden" value="${member.m_id }">
						<span>${member.m_id }님 안녕하세요!</span>
					</div>
					<div class="mt-4">
						<label class="form-label">이메일</label>
						<input autocomplete="off" id="email" class="form-control input-boder-none" placeholder="Email" name="m_email" value="${member.m_email }">
						<span id="email_check"></span>
					</div>
					<div class="mt-4">
						<label class="form-label">기존 비밀번호</label>
						<input id="oldPw" class="form-control input-boder-none" placeholder="Password" name="oldPw" type="password">
						<span id="op_check"></span>
					</div>
					<div class="mt-4">
						<label class="form-label">새 비밀번호</label>
						<input id="newPw" class="form-control input-boder-none" placeholder="Password" name="m_pw" type="password">
						<span id="pw_check"></span>
						<span id="pw_check2"></span>
					</div>
					<div class="mt-4">
						<label class="form-label">새 비밀번호 확인</label>
						<input id="doubleCheck" class="form-control input-boder-none" placeholder="Password" type="password">
						<span id="double_check"></span>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="d-grid gap-3 login-btn-box mt-5">
						<button id="update-btn" class="btn btn-lg btn-primary btn-block">수정하기</button>
					</div>
                     
					<input type="hidden" id="eResult" value="0">
					<input type="hidden" id="initResult" value="0">
					<input type="hidden" id="newResult" value="0">
					<input type="hidden" id="checkResult" value="0">
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
<!--오른쪽 내용 끝-->
</div>
</div>  
</section>


	
	
	<script type="text/javascript">
	$(document).ready(function(){	
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
				

		//이메일 중복 확인 : 중복되지 않고 유효성 검사가 완료된 경우에만 1
		var eResult = $("#eResult").val();
		//이메일 정규식
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		$("#email").keyup(function(){
			
			var emailVal = $("#email").val(); 
			$.ajax({
				url : "/member/emailCheck",
				type : "POST",
				dataType : "JSON",
				data : {"m_email" : emailVal},
				success : function(data){
					
					if(data == 1) {
						$("#email_check").html("중복된 이메일입니다.").css("color", "red");
						eResult = 0;
					} else {
						if(emailVal.match(emailReg) != null ){
							eResult = 1;
							$("#email_check").html("사용 가능한 이메일입니다.").css("color", "blue");
						} else {
							eResult = 0;
							$("#email_check").html("유효하지 않은 이메일 형식입니다.").css("color", "red");
						}
					}
				}
			});//ajax 끝
		});	//이메일 중복확인 끝
				
		//기존 비밀번호 확인 : DB에 저장된 값과 일치하면 1
		var initResult = $("#initResult").val();
		var loginId = $("#userid").val();		
		$("#oldPw").keyup(function(){
			var oldPw = $("#oldPw").val();
			$.ajax({
				url: "/member/pwCheck",
				type: "POST",
				dataType : "JSON",
				data : {"m_id" : loginId, "old_pw" : oldPw},
				success : function(data){					
					if(data == 1){
						initResult = 1;
						$("#op_check").html("비밀번호가 일치합니다.").css("color", "blue");
					} else {
						initResult = 0;
						$("#op_check").html("비밀번호가 일치하지 않습니다.").css("color", "red");
					}	 
				},
			});//ajax 끝
		}); //기존 비밀번호 확인 끝
		
		
		var newResult = $("#newResult").val();
		//새 비밀번호 유효성 확인
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
		//비밀번호 안내문구 출력
		$("#newPw").focusin(function(){
			$("#pw_check").html("영문/숫자/특수문자 2가지 이상 조합 (8~20자)<br>").css("color", "blue");
			$("#pw_check2").html("&nbsp;3개 이상 연속되거나 동일한 문자/숫자 제외").css("color", "blue");
		});
		
		$("#newPw").keyup(function(){
			
			var pwVal = $("#newPw").val();
			
			if(pwVal.match(pwReg) != null ){
				newResult = 1;
				$("#pw_check").html("");
				//비밀번호 확인
	
			} else {
				newResult = 0;
				$("#pw_check").html("유효하지 않은 비밀번호 형식입니다.").css("color", "red");
				$("#pw_check2").html("");
			}
		});// 새 비밀번호 유효성 확인 끝
		
		//새 비밀번호 확인
		var checkResult = $("#checkResult").val();
		$("#doubleCheck").keyup(function(){
			
			var dcVal = $("#doubleCheck").val();
			var dummy = $("#newPw").val();
			
			if(dcVal === dummy){
				checkResult = 1;
				$("#double_check").html("비밀번호가 일치합니다.").css("color", "blue");
			}else {
				checkResult = 0;
				$("#double_check").html("비밀번호가 일치하지 않습니다.").css("color", "red");
			}				
		}); // 비밀번호 확인 끝
		
		
		//바꿔야함!!!
		$("#update-btn").on("click", function(e){
			e.preventDefault();
			
			if($("#email").val() === "") {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '회원정보수정 오류!', // Alert 제목
					text: '이메일을 입력해주세요!', // Alert 내용
					});
				$("#email").focus();
				return;
			}
			if(eResult === 0) {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '회원정보수정 오류!', // Alert 제목
					text: '이메일을 다시 확인 해주세요!', // Alert 내용
					});
				$("#email").focus();
				return;
			}
			if($("#oldPw").val() === "") {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '회원정보수정 오류!', // Alert 제목
					text: '비밀번호를 입력해주세요!', // Alert 내용
				});
				$("#userpw").focus();
				return;
			}
			if(initResult === 0) {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '회원정보수정 오류!', // Alert 제목
					text: '기존 비밀번호가 일치하지 않습니다!', // Alert 내용
				});
				$("#userpw").focus();
				return;
			}
			if ($("#newPw").val() != $("#doubleCheck").val() || $("#newPw").val().match(pwReg) == null || $("#doubleCheck").val() == null ) {
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '회원정보수정 오류!', // Alert 제목
					text: '입력한 비밀번호를 다시 한 번 확인해주세요!', // Alert 내용
				});
				return;
			}
			if (!eResult || !initResult || !newResult || !checkResult){
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '유효성 검사를 실행해주세요!', // Alert 제목
					text: '안됨요!', // Alert 내용
				});
				return;
			}
			if(eResult && initResult && newResult && checkResult){
				Swal.fire({ 
					icon: 'info', // Alert 타입(success, warning, error)
					title: '회원정보수정 성공!', // Alert 제목
					text: '메인페이지로 이동합니다!', // Alert 내용
				}).then(function(){
					$("form").submit();					
				});

			}
			
			
		 });
		// 회원정보 수정 실행(버튼클릭이벤트)	
			
	}); //document.ready 끝
	</script>

<%@ include file="../includes/footer.jsp" %>