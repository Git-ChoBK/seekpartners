	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<style>
		.table {text-align: center;}
		
		.table span {font-size: 14px;}
		.table .white {
			overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: nowrap;
		    max-width: 189px;
		    text-align: left;
	    }
		.pagination {text-align: center;}
		div.pagination > div {width: 100%;}
		div.pagination > div > ul li {margin: 0 .5%;}
		.justify-content-center {margin: 10px 0 15px;}
		div.search a {
			float: right;
		    margin-top: -45px;
		}
		div.search button.search {display: none;}
	</style>

<%@ include file="../../includes/header.jsp"%>
<%@ include file="../../includes/headerAdmin.jsp"%>
	
<!--오른쪽 : 내용-->
<div class="col-md-8">
	<div class="row">
		<div class="categories right-section">
			<div class="container">
				<h2>신고 확인</h2><br />
				<table class="table">
					<thead>
						<tr>
							<!-- <th width="65px">글번호</th> -->
							<th width="65px">작성자</th>
							<th width="320px">제목</th>
							<th width="85px">신고자</th>
							<th width="95px">작성일</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="preport">
					<tbody>
						<tr>
							<%-- <td><span><c:out value="${preport.prebno}" /></span></td> --%>
							<td><span><c:out value="${preport.reporter}" /></span></td>
							<td class="white"><span>
								<a class="move" href="/member/admin/REportDetails?prebno=<c:out value='${preport.prebno}' />&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}">
									<c:out value="${preport.pre_title}" />
								</a>
							</span></td>
							<td class="white"><span><c:out value="${preport.m_id}" /></span></td>
							<td><span><fmt:formatDate pattern="yyyy-MM-dd" value="${preport.pre_date}" /></span></td>
						</tr>
					</tbody>
					</c:forEach>
				</table>
				
				<!--Start pagination----------------------------------------------------------------->
				<div class="col-lg-12 pagination">
					<div>
						<ul class="pagination justify-content-center">
							<c:if test="${pageMaker.prev}">
							<li class="paginate_button page-item previous">
								<a class="page-link" href="${pageMaker.startPage - 1}">이전</a>
							</li>
							</c:if>
							
							<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
								<a class="page-link" href="${num}">${num}</a>
							</li>
							</c:forEach>
							
							<c:if test="${pageMaker.next}">
							<li class="paginate_button page-item next">
								<a class="page-link" href="${pageMaker.endPage + 1}">다음</a>
							</li>
							</c:if>
						</ul>
						
						<div class="search">
							<form id="searchForm" action="/member/admin/REportList" method="get">
								<select name="type">
									<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}" />>제목</option>
									<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}" />>내용</option>
									<option value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}" />>전체</option>
								</select>
								<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}' />" />
								<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}' />" />
								<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}' />" />
								<button class="btn btn-default search">검색</button>
							</form>
						</div>
						
						<form id="actionForm" action="/member/admin/REportList" method="get">
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
							<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}' />" />
							<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}' />" />
						</form>
						
					</div>
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
		
		$(".paginate_button a").on("click", function (e) {
			
			e.preventDefault();
						
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();	// 전송
		});
		
		// Searching
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function (e) {
			e.preventDefault();
			
			if (!searchForm.find("option:selected").val()) {
				//alert("검색종류를 선택하세요");
				return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
				//alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			searchForm.submit();
		});
	</script>

<%@ include file="../../includes/footer.jsp"%>