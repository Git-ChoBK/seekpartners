<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../../includes/header.jsp"%>
<%@ include file="../../includes/headerMyp.jsp"%>
	
<!--오른쪽 : 내용-->
<div class="col-lg-8">
	<div class="row">
		<div class="categories">
			<div class="container">
				<form role="form" action="/member/rpBoard/rpRegister" method="post">
					<h2>문의하기</h2><br />
					
					<div class="form-group">
						<label>제목</label>
						<input autocomplete="off" class="form-control" name="rp_title" />
					</div>
					
					<div class="form-group" style="display:none;">
						<label>작성자</label>
						<input type="text" name="m_id" value="${member}" readonly>
						<!-- <input class="form-control" name="m_id" /> -->
					</div>
					
					<div class="form-group mt-3">
						<label>문의분류</label>
						<select class="form-select" name="rp_list">
							<option>리뷰</option>
							<option>사용자</option>
							<option>기타</option>
						</select>
					</div>
					
					<div class="form-group mt-3">
						<label>본문</label>
						<textarea class="form-control" rows="3" name="rp_content"></textarea>
					</div>
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button class="btn btn-primary pull-right mt-5">등록</button>
				</form>
			</div>
		</div>
	</div>
</div>
<!--오른쪽 내용 끝-->
				
				
</div>
</div>
</section>
	
	<!-- Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 -->
	<script>
		$(document).ready(function(){
			
			$("button").on("click", function(e){
				
				e.preventDefault();
				
				if($("input[name='rp_title']").val()=="") {
					Swal.fire({ 
						icon: 'warning', // Alert 타입(success, warning, error)
						title: '필수 입력 항목 확인!', // Alert 제목
						text: '제목을 입력해주세요', // Alert 내용
					});
	 	 			return;
				}
				if($("select[name='rp_list']").val()=="") {
					Swal.fire({ 
						icon: 'warning', // Alert 타입(success, warning, error)
						title: '필수 입력 항목 확인!', // Alert 제목
						text: '분류를 선택해주세요', // Alert 내용
					});
	 	 			return;
				}
				if($("textarea[name='rp_content']").val()=="") {
					Swal.fire({ 
						icon: 'warning', // Alert 타입(success, warning, error)
						title: '필수 입력 항목 확인!', // Alert 제목
						text: '제목을 입력해주세요', // Alert 내용
					});
	 	 			return;
				}
				
				
				$("form").submit();
				
			});
			
			
			
			
			
		});
	</script>

<%@ include file="../../includes/footer.jsp"%>