<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<style>
		div.bno {display: none;}
		.form-group {padding-bottom: 2%;}
	</style>

<%@ include file="../../includes/header.jsp"%>
<%@ include file="../../includes/headerMyp.jsp"%>

	
<!-- 오른쪽: 내용 -->
<div class="col-lg-8">
	<div class="row">
		<div class="categories">
			<div class="container">
				<form role="form" action="/member/rpBoard/rpModify" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
					<input type="hidden" name="type" value="<c:out value='${cri.type}' />" />
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}' />" />
					
					<h2>문의하기</h2><br />
					
					<div class="form-group bno">
						<label>글번호</label>
						<input class="form-control" name="rpbno" value="<c:out value='${rpboard.rpbno}' />" readonly />
					</div>
					
					<div class="form-group">
						<label>제목</label>
						<input autocomplete="off" class="form-control" name="rp_title" value="<c:out value='${rpboard.rp_title}' />" />
					</div>
					
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="m_id" value="<c:out value='${rpboard.m_id}' />" readonly />
					</div>
					
					<div class="form-group">
						<label>문의분류</label>
						<select class="form-select" name="rp_list">
							<option>리뷰</option>
							<option>사용자</option>
							<option>기타</option>
						</select>
					</div>
					
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="9" name="rp_content"><c:out value="${rpboard.rp_content}" /></textarea>
					</div>
					
					<div class="form-group" style="display: none;">
						<label>등록일</label>
						<input class="form-control" name="rp_date" value="<fmt:formatDate pattern="yyyy/MM/dd" value='${rpboard.rp_date}' />" readonly />
					</div>
					
					<div class="form-group" style="display: none;">
						<label>수정일</label>
						<input class="form-control" name="rp_update" value="<fmt:formatDate pattern="yyyy/MM/dd" value='${rpboard.rp_update}' />" readonly />
					</div>
					
					<button type="submit" data-oper="rpModify" class="btn btn-outline-secondary">수정</button>
					<!-- <button type="submit" data-oper="rpRemove" class="btn btn-danger">삭제</button> -->
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
		
		var formObj = $("form");
		
		$("button").on("click", function (e) {
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			
			if (operation === "rpRemove") {		// operation === "remove"
				
				formObj.attr("action", "/member/rpBoard/rpRemove");
			
			} else if (operation === "rpList") {	// operation === "list"
				
				/* formObj.attr("action", "/member/rpBoard/rpList").attr("method", "get"); */
				
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();	// 내부 자식태그 모두 삭제
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
			}
			formObj.submit();
			
		});
	</script>

<%@ include file="../../includes/footer.jsp"%>