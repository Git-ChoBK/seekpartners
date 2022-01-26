	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../../includes/header.jsp"%>
<%@ include file="../../includes/headerAdmin.jsp"%>
	
<!-- 오른쪽: 내용 -->
<div class="col-md-8">
	<div class="row">
		<div class="categories right-section">
			<div class="container">
				<!-- 추가 -->
				<h2>신고확인</h2><br />
				
				<div class="form-group bno" style="display:none;">
					<input type="hidden" class="form-control" name="prebno" value="<c:out value='${relist.prebno}' />" readonly />
				</div>
				
				<div class="form-group mt-3">
					<label>제목</label>
					<input class="form-control" name="pre_title" value="<c:out value='${relist.pre_title}' />" readonly />
				</div>
				
				<div class="form-group mt-3">
					<label>작성자</label>
					<input class="form-control" name="m_id" value="<c:out value='${relist.m_id}' />" readonly />
				</div>
					
				<div class="form-group mt-3">
					<label>신고받은 아이디</label>
					<input class="form-control" name="reporter" value="<c:out value='${relist.reporter}' />" readonly />
				</div>
				
				<div class="form-group mt-3">
					<label>내용</label>
					<textarea class="form-control" rows="9" name="pre_content" readonly><c:out value="${relist.pre_content}" /></textarea>
				</div>
				<div>
					<button data-oper="remove" class="btn mt-3 btn btn-outline-secondary">삭제</button>
					<button data-oper="list" class="btn mt-3 btn-outline-secondary"><a href="/member/admin/REportList">목록</a></button>
					<button data-oper="rboardremove" class="btn mt-3 btn btn-outline-secondary">게시글 삭제</button>
					<a class="btn btn-outline-info pull-right mt-3" href="/pBoard/pDetails?pbno=<c:out value='${relist.pbno}' />">게시글 이동</a>
				</div>
				
				<form id="operForm" action="/member/admin/REportList" method="get">
					<input type="hidden" id="prebno" name="prebno" value="<c:out value='${relist.prebno}' />" />
					<input type="hidden" id="pbno" name="pbno" value="<c:out value='${relist.pbno}' />" />
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}' />" />
					<input type="hidden" name="type" value="<c:out value='${cri.type}' />" />
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
						formObj.attr("action", "/member/admin/reremove").attr("method", "post").submit();
					})
				}
			})
		});
		
		$("button[data-oper='rboardremove']").on("click",function (e) {
			
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
						formObj.attr("action", "/member/admin/targetRemove").attr("method", "post").submit();
					})
				}
			})
		});
		
		
	</script>
<%@ include file="../../includes/footer.jsp"%>