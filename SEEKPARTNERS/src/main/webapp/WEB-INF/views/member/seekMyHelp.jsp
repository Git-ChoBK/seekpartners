<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%> --%>

<%@ include file="../includes/header.jsp"%>
<%@ include file="../includes/headerMyp.jsp"%>
	
<!--오른쪽 : 내용-->
<div class="col-lg-8">
	<div class="row">
		<div class="categories">
			<div class="container mt-3">
				<h2><a href="/member/spBoard/spList">문의하기</a></h2>
				<br />
				<p>비동기방식으로 통신할 영역</p>
				<table class="table">
					<thead>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr class="table-info">
							<td>1</td>
							<td>Example Title</td>
							<td>USER</td>
							<td>2021-22-22</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="categories">
			<div class="container mt-3">
				<h2><a href="/member/rpBoard/rpList">신고 하기</a></h2>
				<br />
				<p>비동기방식으로 통신할 영역</p>

				<table class="table">
					<thead>
						<!-- <tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr> -->
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<!-- <tr class="table-info">
							<td>1</td>
							<td>Example Title</td>
							<td>USER</td>
							<td>2021-22-22</td>
						</tr> -->
						<c:forEach items="${list}" var="rpboard">
						<tbody>
							<tr>
								<td><c:out value="${rpboard.rpbno}" /></td>
								<td><c:out value="${rpboard.rp_list}" /></td>
								<td>
									<a class="move" href="rpDetails?rpbno=<c:out value='${rpboard.rpbno}' />&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}">
										<c:out value="${rpboard.rp_title}" />
									</a>
								</td>
								<td><c:out value="${rpboard.m_id}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${rpboard.rp_date}" /></td>
							</tr>
						</tbody>
						</c:forEach>
					</tbody>
				</table>
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
		$(document).ready(function () {
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr, options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});		
		});
	</script>

<%@ include file="../includes/footer.jsp"%>