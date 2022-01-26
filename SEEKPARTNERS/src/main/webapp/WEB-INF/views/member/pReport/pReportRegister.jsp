<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

	<style>
		body {
			min-height: 100vh;
			background-color: rgba(30, 30, 30, 0.4);;
		}
		.con1 {margin-top: 90px;}
		label {margin-bottom: 5px;}
		div.custom-checkbox {margin-bottom: 15px;}
		
		.input-form {
			max-width: 680px;
			margin-top: 80px;
			padding: 32px;
			background: #fff;
			-webkit-border-radius: 10px;
			-moz-border-radius: 10px;
			border-radius: 10px;
			-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		}
		
		.div-content {
			width: 60% !important;
    		padding: 5% 5% 3% !important;
		}
		
		button[type="submit"] {
			background-color: #00ADB5;
			border: none;
		}
		button[type="submit"]:hover {
			background-color: #126E82;
		}
		
		/* input[name='pre_writer'] {display: none;} */
	</style>
	
<%@ include file="../../includes/header.jsp" %>
	
	<div class="container con1">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto div-content">
				<h4 class="mb-3">게시글 신고하기</h4><br />
				
				<form role="form" action="/member/pReport/pReportRegister" method="post" class="report-form">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" id="token" />
					<input type="hidden" name="pbno" value='${list.pbno}' />
					
					<div class="mb-3">
						<label>해당 게시글 작성자</label>	<!-- 신고받는사람 -->
						<input type="text" name="m_id" class="form-control" value="${list.m_id}" readonly />
						
					</div>
					
					<!-- 신고하는사람 -->
					<input type="hidden" name="reporter" class="form-control" value="<sec:authentication property='principal.username' />" readonly />
					
					<div class="mb-3">
						<label>게시글 제목</label>
						<input type="text" name="pre_title" class="form-control" value="${list.p_title}" readonly />
					</div>
					
					<div class="mb-3">
						<label>신고내용</label>
						<textarea rows="5" cols="80" name="pre_content" class="form-control" placeholder="내용을 입력해 주세요"></textarea>
					</div>
					
					<div class="mb-3">
						<label>게시글 신고 사유</label>
						<select name="pre_list" class="form-control" id="reason" required>
							<option value="">-- 선택하세요 --</option>
							<option value="1">광고</option>
							<option value="2">도배</option>
							<option value="3">음란물</option>
							<option value="4">개인정보침해</option>
							<option value="5">저작권침해</option>
							<option value="6">기타</option>
						</select>
					</div>
					
					<div class="mb-3">
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />
						게시글 신고 날짜: <c:out value="${today}" />
					</div>
					
					<hr class="mb-4" />
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="aggrement" required />
						<label class="custom-control-label" for="aggrement">신고에 필요한 개인정보 수집 및 이용에 동의합니다.</label>
					</div>
					
					<div class="mb-4">
						<button class="btn btn-primary btn-lg btn-block">신고하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
		/* Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 */
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		/* select box 체크했는지 확인 */
		if (!$('#reason').val*()) {
			e.preventDefault();
			
			if (selectCHECK.val() == "" {
				alert("분류선택");
				return;
			})
			
			$("form").submit();
		}
		
		
		var textareaCHECK = $("textarea[name='pre_content']");
		
		/* textarea가 비었는지 체크 */		
		$("button").on("click", function(e) {
			e.preventDefault();
			
			if (textareaCHECK.val() == "") {
				alert("내용입력");
				return;
			}
			
			// token을 지움
			//$("#token").remove();
			
			$("form").submit();
			
		});
		
	</script>
	
<%@ include file="../../includes/footer.jsp" %>