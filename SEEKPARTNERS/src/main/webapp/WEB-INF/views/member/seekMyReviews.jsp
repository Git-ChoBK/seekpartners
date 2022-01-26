<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/headerMyp.jsp" %>

<!--오른쪽 : 내용-->
<div class="col-md-8">
	<div class="row">
		<div class="categories right-section">
			<div class="container">
				<h2>내가 쓴 리뷰 보기</h2>
				<br>
				<table class="table table-striped table-bordered table-hover">
					<thead style="text-align: center;">
						<tr>
							<th width="100">지역</th>
							<th width="200">식당이름</th>
							<th width="200">제목</th>
							<th width="100">작성일</th>
						</tr>
					</thead>
					<tbody style="text-align: center;">
					<c:forEach items="${board}" var="board">
						<tr>
							<td><span><c:out value="${board.r_areasplit }"/></span></td>
							<td><span><c:out value="${board.r_shop }"/></span></td>
							<td><span><a class="move" href="/rBoard/rDetails?rbno=<c:out value='${board.rbno}' />"><c:out value="${board.r_title }"/></a></span></td>
							<td><span><fmt:formatDate pattern="MM-dd" value="${board.r_date }"/></span></td>
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
						
					<form id="actionForm" action="/member/seekMyReviews" method="get">
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
	var actionForm = $("#actionForm");
	
	$(".page-item a").on("click", function (e) {
		
		e.preventDefault();
				
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();	// 전송
	});
	</script>

<%@ include file="../includes/footer.jsp" %>