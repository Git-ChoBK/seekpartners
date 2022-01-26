<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/headerMyp.jsp" %>

        <!--오른쪽 : 내용-->
        <div class="col-lg-8">
			
			<c:if test="${member != null }">
			<div>
				<p><strong>${member.m_id }</strong>님의 회원 탈퇴를 진행합니다 :(</p>
				<p class="mt-5">회원탈퇴를 위해 비밀번호를 입력해주세요</p>
			</div>
			</c:if>
			
			<form role="form" method='post' action="/member/seekMemberDelete">
				<fieldset>								
					<div class="mt-6">
						<input class="form-control" placeholder="비밀번호" name="m_pw" id="userpw" type="password"  value="">
						<c:if test="${msg == false }">
							<p style="color:red;">비밀번호가 일치하지 않습니다.</p>
						</c:if>
					</div>
					<!-- Change this to a button or input when using this as a form -->
					<div class="d-grid gap-3 login-btn-box mt-3">
						<button class="btn btn-warning btn-block" id="memberDelete-btn">회원탈퇴</button>
						<a href="/board/main" class="btn btn-sm pull-right">홈으로</a>
					</div>
					
				</fieldset>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		
		</div>
        <!--오른쪽 내용 끝-->
      </div>
    </div>
    </section>
    

	
	<script type="text/javascript">
	$(document).ready(function(){	
		

		$("#memberDelete-btn").on("click", function(e){
			e.preventDefault();

			if($("#userpw").val() === ""){
				Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '비밀번호 확인!', // Alert 제목
					text: '비밀번호를 입력해주세요 :)', // Alert 내용
				});
				$("#userpw").focus();
				return false;
			}
			   
	    $("form").submit();
	    
	  });
		


			
			
	}); //document.ready 끝
	</script>

<%@ include file="../includes/footer.jsp" %>