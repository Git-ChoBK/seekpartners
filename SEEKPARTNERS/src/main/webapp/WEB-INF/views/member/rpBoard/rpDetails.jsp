<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<style>
		div.bno {display: none;}
		.form-group {padding: 2% 0;}
	</style>

<%@ include file="../../includes/header.jsp"%>
<%@ include file="../../includes/headerMyp.jsp"%>

	
<!-- 오른쪽: 내용 -->
<div class="col-lg-8">
	<div class="row">
		<div class="categories">
			<div class="container">
				<!-- 추가 -->
				<h2>문의하기</h2><br />
				
				<div class="form-group bno">
					<label>rpbno</label>
					<input class="form-control" name="rpbno" value="<c:out value='${rpboard.rpbno}' />" readonly />
				</div>
				
				<div class="form-group">
					<label>제목</label>
					<input class="form-control" name="rp_title" value="<c:out value='${rpboard.rp_title}' />" readonly />
				</div>
				
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="m_id" value="<c:out value='${rpboard.m_id}' />" readonly />
				</div>
					
				<div class="form-group">
					<label>문의분류</label>
					<select class="form-select" name="rp_list" disabled>
						<option>리뷰</option>
						<option>사용자</option>
						<option>기타</option>
					</select>
				</div>
				
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="9" name="rp_content" readonly><c:out value="${rpboard.rp_content}" /></textarea>
				</div>
				
				<c:if test="${prin.username eq rp_board.m_id }">
					<button data-oper="modify" class="btn mt-3 btn btn-outline-secondary">수정</button>
					<button data-oper="remove" class="btn mt-3 btn btn-outline-secondary">삭제</button>
					<button data-oper="list" class="btn mt-3 btn-outline-secondary">목록</button>
				</c:if>
				
				<form id="operForm" action="/member/rpBoard/rpModify" method="get">
					<input type="hidden" id="rpbno" name="rpbno" value="<c:out value='${rpboard.rpbno}' />" />
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}' />" />
					<input type="hidden" name="type" value="<c:out value='${cri.type}' />" />
					<input type="hidden" id="token" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 오른쪽 내용 끝 -->
				
				
</div>
</div>
</section>
	
	<!-- Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 -->
	<script>
		/* $(document).ready(function(){
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr, options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});		
		}); */
		
		var operForm = $("#operForm");
		var formObj = $("form");
		
		$("button[data-oper='modify']").on("click",function (e) {
			$("#token").remove();
			operForm.attr("action", "/member/rpBoard/rpModify").submit();
		});
		
		$("button[data-oper='remove']").on("click",function (e) {
	
			e.preventDefault();
			Swal.fire({
			  title: '삭제하시겠어요?',
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '삭제할게요',
			  cancelButtonText: '잠깐!',
			}).then((result) => {
				if (!result.isConfirmed) {
					return;
				} else {
					Swal.fire('성공!', '게시글이 정상적으로 지워졌어요:)', 'success').then(function() {
						formObj.attr("action", "/member/rpBoard/rpRemove").attr("method", "post").submit();
					})
				}
			})
		});
		
		$("button[data-oper='list']").on("click", function (e) {
			operForm.find("#rpbno").remove();
			$("#token").remove();
			operForm.attr("action", "rpList");
			operForm.submit();
		});
		
	</script>

<%@ include file="../../includes/footer.jsp"%>