<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
	
		<!-- start search bar ------------------------------------------------------------------------->
		<section class="searchbar">
			<h1><i class="icofont-restaurant"></i>SEEK.PARNTER</h1>
			<form id="searchForm" action="/rBoard/rList" method="get">
                <div class="container">
					<div class="input-group mb-3 searching">
						<select name="type" style="display: none;">
							<option value="TSCL">제목 or 지역 or 가게명 or 내용</option>
						</select>
						<input autocomplete="off" class="form-control search-box over" type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}' />""/>
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
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
		          <li>서울</li>
		          <li>인천</li>
		          <li>대전</li>
		          <li>대구</li>
		          <li>울산</li>
		          <li>부산</li>
		          <li>광주</li>
		          <li>세종</li>
		          <li>제주</li>
		          <li>경기</li>
		          <li>충남</li>
		          <li>충북</li>
		          <li>전남</li>
		          <li>전북</li>
		          <li>경남</li>
		          <li>경북</li>
		          <li>강원</li>
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
								<c:forEach items="${rList}" var="rInfo">
									<div class="col-4 show-item-col all soon">
										<div class="card-shape-item">
											<div class="thumb">
												<c:forEach items="${rInfo.attachList}" var="attachList">
							                      <a href='/rBoard/rDetails?rbno=<c:out value="${rInfo.rbno}"/>'>
							                     		<img class="testatta" src="">
							                     		<input type="hidden" name="testingPath" class="testatt" value="<c:out value='${attachList.uploadpath}'/>/s_<c:out value='${attachList.uuid}'/>_<c:out value='${attachList.filename}'/>">
							                      </a>
						                        </c:forEach>
												<div class="price">
													<div class="row">
													<span class="make_star">
														<ul class="rating" data-rate1="<c:out value='${rInfo.r_score}'/>">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
														</ul>
													 </span>
													 </div>
												</div>
											</div>
											<div class="row">
											  
												<div class="col-4">
													<div class="date">
														<h6>
															<fmt:formatDate pattern="MM" value="${rInfo.r_date}"/>월
															<span><fmt:formatDate pattern="dd" value="${rInfo.r_date}"/></span>
															<%-- <span><fmt:formatDate pattern="HH:ss" value="${rInfo.r_date}"/></span> --%>
														</h6>
													</div>
												</div>
												<div class="col-8 pd-info">
													<div class="6">
														<h4 id="needCheck" class="partner-cat seek-split">[<c:out value="${rInfo.r_areasplit}"/>]</h4>													
													</div>
													<div class="6">
														<h4 id="alterCheck" class="partner-cat mt-2">[<c:out value="${rInfo.r_shop}"/>]</h4>													
													</div>
												</div>	
											</div>
											<div class="row">
												<div class="party-title">
													<h4>
														<a href='rDetails?rbno=<c:out value="${rInfo.rbno}"/>&type=${pageMaker.cri.type}&keyword=${ Maker.cri.keyword}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}'>
															<c:out value="${rInfo.r_title }"/>
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
								
								<form id="actionForm" action="/rBoard/rList" method="get">
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
							<a class="btn btn-primary pull-right" href="/rBoard/rRegister">글쓰기</a>
						</div>
					<!-- 글등록버튼 -->
					</div>
				</div>
			</div>
		</section>
		<!--end section partner-list -->
		

	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var testing = $("#needCheck").val();
			var testing2 = $("#alterCheck").val();
			var areaSplitCheck = '<c:out value="${rInfo.r_areasplit}"/>';
			var areaCheck = '<c:out value="${rInfo.r_area}"/>';
			var etc = '${rInfo.r_area}'
			
			// 페이지 넘버 클릭시 이동	
			var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click", function(e) {
				e.preventDefault();
								
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();	// 전송
			});
			
			// 검색창 함수
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				e.preventDefault();

				if (!searchForm.find("input[name='keyword']").val()) {
					Swal.fire({ 
						icon: 'warning', // Alert 타입(success, warning, error)
						title: '검색어 확인!', // Alert 제목
						text: '검색할 단어를 입력해주세요', // Alert 내용
					});
					
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				searchForm.submit();
				
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
              location.href="/rBoard/rList";
            }else{
               $('input[name=keyword]').val(searchstr);
               $("#searchForm").submit();
            }       
        }); 
	</script>  
	
	
	<script>
	  	//게시글 썸네일
	    $(document).ready(function(){
	    	var imgResult = $(".testatt");
	
	        for(i=0; i < imgResult.length; i++) {
	            var map3 = $("[name=testingPath]")[i].value;
	            var map4 = encodeURIComponent(map3);

	            $(".testatta").eq(i).attr("src", "/display?fileName="+map4);
	        }
		  	
	    	
	    });
	 </script>
		
	 <script>//별점 처리
		$(document).ready(function(){
			$(function(){
				var rating = $('.make_star .rating');
				
				$(rating).each(function(i,rated){
					var rate = $(rated).data('rate1');
					$(this).find('i:nth-child(-n+'+rate+')').css({color:'#F5A428'});
				});
					
					
			});
		});
	  </script>
	  


		
<%@ include file="../includes/footer.jsp" %>