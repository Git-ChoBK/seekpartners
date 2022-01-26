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
				<h2>신고하기</h2><br />
				
				<div class="form-group bno">
					<label>글 번호</label>
					<input class="form-control" name="prebno" value="<c:out value='${preport.prebno}' />" readonly />
				</div>
				
				<div class="form-group">
					<label>제목</label>
					<input class="form-control" name="pre_title" value="<c:out value='${preport.pre_title}' />" readonly />
				</div>
				
				<div class="form-group">
					<label>신고 받은 ID</label>
					<input class="form-control" name="m_id" value="<c:out value='${preport.m_id}' />" readonly />
				</div>
					
				<div class="form-group">
					<label>문의분류</label>
					<select class="form-select" name="pre_list" disabled>
						<option>광고</option>
						<option>도배</option>
						<option>음란물</option>
						<option>개인정보침해</option>
						<option>저작권침해</option>
						<option>기타</option>
					</select>
				</div>
				
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="9" name="pre_content" readonly><c:out value="${preport.pre_content}" /></textarea>
				</div>
				
				<sec:authentication property="principal" var="prin"/>
				<c:if test="${prin.username eq preport.reporter }">
					<button data-oper="modify" class="btn mt-3 btn btn-outline-secondary">수정</button>
					<button data-oper="remove" class="btn mt-3 btn btn-outline-secondary">삭제</button>
					<button data-oper="list" class="btn mt-3 btn-outline-secondary">목록</button>
				</c:if>
				
				<form id="operForm" action="/member/pReport/pRModify" method="get">
					<input type="hidden" id="prebno" name="prebno" value="<c:out value='${preport.prebno}' />" />
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
		
		var operForm = $("#operForm");
		var formObj = $("form");
		
		$("button[data-oper='modify']").on("click",function (e) {
			$("#token").remove();
			operForm.attr("action", "/member/pReport/pRModify").submit();
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
						formObj.attr("action", "/member/pReport/pRRemove").attr("method", "post").submit();
					})
				}
			})
		});
		
		$("button[data-oper='list']").on("click", function (e) {
			operForm.find("#prebno").remove();
			$("#token").remove();
			operForm.attr("action", "pRList");
			operForm.submit();
		});
		
	</script>

<%@ include file="../../includes/footer.jsp"%>