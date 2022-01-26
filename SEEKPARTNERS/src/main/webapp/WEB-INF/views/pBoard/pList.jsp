<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
	
		<!-- start search bar ------------------------------------------------------------------------->
		<section class="searchbar">
			<h1><i class="icofont-restaurant"></i>SEEK.PARNTER</h1>
			<form id="searchForm" action="/pBoard/pList" method="get">
                <div class="container">
					<div class="input-group mb-3 searching">
						<select name="type" style="display: none;">
							<option value="TAM">제목 or 지역 or 메뉴</option>
						</select>
						<input autocomplete="off" class="form-control search-box over" type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}' />"/>
						 <!-- aria-label="test" aria-describedby="button-addon2" -->
						<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}' />" />
						<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}' />" />
						<button id="button-addon2" class="btn"><i class="fa fa-search"></i></button>
					</div>
				</div>
            </form>
        </section>
        <!-- end search bar -->
        
        <!--Start filter (해시태그)--------------------------------------------------------------------->
		<div class="col-lg-12">
			<div class="filters">
				<ul>
		          <li>All</li>
		          <li>치킨</li>
		          <li>피자</li>
		          <li>분식</li>
		          <li>한식</li>
		          <li>일식/돈까스</li>
		          <li>중식</li>
		          <li>양식</li>
		          <li>찜/탕</li>
		          <li>디저트</li>
		          <li>야식</li>
		          <li>비건</li>
		          <li>아시안</li>
		          <li>기타</li>
				</ul>
			</div>
		</div>
		<!--end filter----------------------------------------------------------------------->

		<!--Start section partner-list ------------------------------------------------------------------------->
		<section class="list-page" id="partner-list">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
											
						<!-- Start partner-list ------------------------------------------------------------------>
						<!-- <div class="row"> -->
						<div class="col-12 mt-5">
							<div class="row">
								<!--show-item-col 반복-->
								<c:forEach items="${pList}" var="pInfo">
									<div class="col-4 show-item-col all soon">
										<div class="card-shape-item">
											<div class="row">
												<div class="col-4">
													<div class="date pboard_date">
														<c:if test="${pInfo.status eq 'W' }">
														<span class="badge gather-at-list waiting">모집중</span>
														</c:if>
														<c:if test="${pInfo.status eq 'C' }">
														<span class="badge gather-at-list complete">모집완료</span>
														</c:if>
														<h6>
															<fmt:formatDate pattern="MM" value="${pInfo.p_time }"/>월
															<span><fmt:formatDate pattern="dd" value="${pInfo.p_time }"/></span>
															<span><fmt:formatDate pattern="HH:ss" value="${pInfo.p_time }"/></span>
														</h6>
													</div>
												</div>
												<div class="col-8 pd-info">
													<div class="6">
														<h4 id="needCheck" class="partner-cat seek-split">[<c:out value="${pInfo.p_areasplit}"/>]</h4>													
													</div>
													<div class="6">
														<h4 id="alterCheck" class="partner-cat mt-2">[<c:out value="${pInfo.p_menu}"/>]</h4>													
													</div>
													<div class="row mt-2">
														<div class="col-6">
															<c:out value="${pInfo.p_total }"/><i class="icofont-won-true"></i>
														</div>
														<div class="col-6">
															<i class="icofont-ui-user-group" style="font-size: 20px;"></i><c:out value="${pInfo.p_maxmember }"/>
														</div>
													</div>	
												</div>	
											</div>
											<div class="row">
												<div class="party-title">
													<h4>
														<a href='pDetails?pbno=<c:out value="${pInfo.pbno}"/>&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}'>
															<c:out value="${pInfo.p_title }"/>
														</a>
													</h4>
												</div>
											</div>
											
											
											
											
											
									</div>
								</div>
								</c:forEach>
								<!--show-item-col 반복-->
							</div>
							
						</div>
						<!-- </div> -->
						<!--end partner-list-------------------------------------------------------------------->
						
						<!--Start pagination----------------------------------------------------------------->
						<div class="col-lg-12">
							<div class="pagination">
								<ul>
									<c:if test="${pageMaker.prev}">
									<li class="paginate_button previous">
										<a href="${pageMaker.startPage - 1}">이전</a>
									</li>
									</c:if>
									
									<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
									<li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active' : ''}">
										<a href="${num}">${num}</a>
									</li>
									</c:forEach>
									
									<c:if test="${pageMaker.next}">
									<li class="paginate_button next">
										<a href="${pageMaker.endPage + 1}">다음</a>
									</li>
									</c:if>

								</ul>
								
								<form id="actionForm" action="/pBoard/pList" method="get">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
									<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
									<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}' />" />
									<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}' />" />
								</form>
							</div>
						</div>
						<!-- end pagination ------------------------------------------------------------------->
						
						<!-- 글등록버튼 ----------------------------------------------------------------->
						<div>
							<a class="btn btn-primary pull-right" href="/pBoard/pRegister">글쓰기</a>
						</div>
						<!-- 글등록버튼 -->
					</div>
				</div>
			</div>
		</section>
		<!--end section partner-list -->
		
		

	
	<script>
		$(document).ready(function() {
			
			
			
			// 검색창 함수
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				e.preventDefault();

				if (!searchForm.find("input[name='keyword']").val()) {
					Swal.fire({ 
						icon: 'warning', // Alert 타입(success, warning, error)
						title: '필수 입력 항목 확인!', // Alert 제목
						text: '제목을 입력해주세요', // Alert 내용
					});
					
					return;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				searchForm.submit();
				
			});
		
			// 페이지 넘버 클릭시 이동	
			var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click", function(e) {
				e.preventDefault();
								
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();	// 전송
			});
			
			
			if($('input[name=keyword]').val()!=""){
				$('.filters li').removeClass("active");
			} else {
				$('.filters li').first().addClass("active");
				
			}
			
			$('.filters li').each(function (index, item) {
				
				if($('input[name=keyword]').val()==$(this).text())
					$(this).addClass("active");
			});
				
		});
	</script>
	
     <script type="text/javascript">
     var searchstr;
        $('.filters ul').children('li').off().on('click', function(e) {
           
           searchstr = $(this).text();
           if(searchstr=="All") {
              $('input[name=keyword]').val("");
              location.href="/pBoard/pList";
            }else{
               $('input[name=keyword]').val(searchstr);
               $("#searchForm").submit();
            }       
        });
     </script>   
	

	

		
<%@ include file="../includes/footer.jsp" %>