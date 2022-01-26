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
		<div class="categories right-section">
			<div class="container">
				<h2>문의하기</h2><br />
				<div class="pull-right" style="padding-bottom: 12px;">
					<a href="/member/rpBoard/rpRegister" class="btn btn-primary">문의글 작성</a>
				</div>
				<table class="table table-striped table-bordered table-hover mt-2">
					<thead style="text-align: center;">
						<tr>
							<th width="65px">글번호</th>
							<th width="65px">분류</th>
							<th width="320px">제목</th>
							<th width="85px">작성자</th>
							<th width="95px">작성일</th>
						</tr>
					</thead>
					<tbody style="text-align: center;">
					<c:forEach items="${list}" var="rpboard">
						<tr class="tr_1">
							<td><span><c:out value="${rpboard.rpbno}" /></span></td>
							<td><span><c:out value="${rpboard.rp_list}" /></span></td>
							<td class="white"><span>
								<a class="move" href="rpDetails?rpbno=<c:out value='${rpboard.rpbno}' />&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}">
								
									<c:out value="${rpboard.rp_title}" />
								</a>
							</span></td>
							<td class="white"><span><c:out value="${rpboard.m_id}" /></span></td>
							<td><span><fmt:formatDate pattern="yyyy-MM-dd" value="${rpboard.rp_date}" /></span></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				
				<!--Start pagination----------------------------------------------------------------->
				<div class="panel-footer">
					<ul class="pagination pull-right">
						<c:if test="${pageMaker.prev}">
						<li class="page-item">
							<a class="page-link" href="${pageMaker.startPage - 1}"> < </a>
						</li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
							<a class="page-link" href="${num}">${num}</a>
						</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
						<li class="page-item">
							<a class="page-link" href="${pageMaker.endPage + 1}"> > </a>
						</li>
						</c:if>
					</ul>
					
					
					<form id="actionForm" action="/member/rpBoard/rpList" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					</form>
				</div>
				<!-- end pagination ------------------------------------------------------------------->
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
		/* $(document).ready(function() {
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});		
		}); */
		
		history.replaceState({}, null, null);	// 마지막 null값은 모든 히스토리 초기화시킴
		
		// pagination
		var actionForm = $("#actionForm");
		
		$(".page-item a").on("click", function (e) {
			
			e.preventDefault();
			
			console.log("클릭함");
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();	// 전송
		});

	</script>

<%@ include file="../../includes/footer.jsp"%>