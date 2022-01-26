<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>



<%@ include file="includes/header.jsp" %>

		
		<!-- start search bar ------------------------------------------------------------------------->
		<section class="searchbar">
			<h1><i class="icofont-restaurant"></i>SEEK.PARNTER</h1>
			<form id="searchForm" action="/pBoard/pList" method="get">
                <div class="container">
					<div class="input-group mb-3 searching">
						<select name="type" style="display: none;">
							<option value="TAM">제목 or 지역 or 메뉴</option>
						</select>
						<input class="form-control search-box over" type="text" name="keyword" aria-label="test" aria-describedby="button-addon2" autocomplete="off"/>
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
						<button id="button-addon2" class="btn" type="button"><i class="fa fa-search"></i></button>
					</div>
				</div>
            </form>
        </section>
        <!-- end search bar -->
		
		<!--Start filter (해시태그)--------------------------------------------------------------------->
		<div class="col-lg-12">
			<div class="filters">
				<ul>
		          <li class="active">All</li>
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
		
		<!-- start parter (식구찾기) ----------------------------------------------------------------------------->
		<section class="main-partners" id="main-partner">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-heading">
							<h2>최근 등록된 식구 찾기></h2>
							<a class="btn pull-right" href="/pBoard/pList">+더보기</a>
						</div>
					</div>
					
					<div class="col-lg-12 slide-cover">
						<div class="owl-courses-item owl-carousel">
							
							<!-- item 반복 ----------------------------------------------------------------------------->
							<c:forEach items="${pList}" var="pInfo">
							<div class="item">
								<div class="down-content">
									<div class="seek-cat">
										<div class="row">
											<div class="col-lg-8">
												<h4 id="area-info" class="partner-cat seek-split">[<c:out value="${pInfo.p_areasplit}" />]</h4>
												<%-- <div class="row">
													<h4 style="display:inline-block;" id="menu-info" class="partner-cat">[<c:out value="${pInfo.p_menu }" />]1</h4>
													<i class="icofont-ui-user-group" style="font-size: 20px;"></i>
													<c:out value="${pInfo.p_maxmember}" />
												</div> --%>
												<div class="down-info">
												
													<h4 id="menu-info" class="partner-cat">[<c:out value="${pInfo.p_menu }" />]</h4>
														<i class="icofont-ui-user-group"></i>
														<c:out value="${pInfo.p_maxmember}" />
												
												</div>
													
												<%-- <div class="info">
													<div class="row">
														<div class="col-6" style="text-align: center;">
															<ul>
																<li><i class="icofont-ui-user-group" style="font-size: 20px;"></i></li>
																<li><c:out value="${pInfo.p_maxmember}" /></li>
															</ul>
														</div>
														<div class="col-6" style="text-align: center;">
															<span><c:out value="${pInfo.p_total}" /><i class="icofont-won-true"></i></span>
														</div>
													</div>
												</div> --%>
												
											</div>
											
											<div class="col-lg-4 p_date">
												<h6><fmt:formatDate pattern="dd" value="${pInfo.p_time }" /><span>일</span></h6>
												<p id="time-info"><fmt:formatDate pattern="HH:mm" value="${pInfo.p_time }" /></p>
											</div>

										</div>
									</div>
									<div>
										<h4>
											<a href='/pBoard/pDetails?pbno=<c:out value="${pInfo.pbno }"/>'>
												<c:out value="${pInfo.p_title}" />
											</a>
										</h4>
									</div>
								</div>
							</div>
							</c:forEach>
							<!--item 반복 끝-->
							
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- end parter -->
			<hr>
		<!-- start review (식당리뷰) ----------------------------------------------------------------------------->
		<section class="main-reviews" id="main-reviews">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="section-heading">
							<div>
								<h2>최근 등록된 식당 리뷰 ></h2>
								<!-- 직접접근 하지말고  VO를 통해 접근시도 -->
								<!-- <a href="rs-list.html">+더보기</a> -->
								<a class="btn pull-right" href="/rBoard/rList">+더보기</a>
							</div>
						</div>
					</div>
					
					<div class="col-lg-12">
						<div class="row" style="padding-bottom: 150px;">
					
							<!-- 반복 ----------------------------------------------------------------------------->
							<c:forEach items="${rList}" var="rInfo">
									<div class="col-3 show-item-col all soon">
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
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
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
															<span><fmt:formatDate pattern="HH:ss" value="${rInfo.r_date}"/></span>
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
														<a href='/rBoard/rDetails?rbno=<c:out value="${rInfo.rbno}"/>'>
														<!-- &type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount} -->
															<c:out value="${rInfo.r_title }"/>
														</a>
													</h4>
												</div>
											</div>
									</div>
								</div>
								</c:forEach>
							<!-- 반복 ------------->
							
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<script type="text/javascript">
		$(document).ready(function(){
		    var owl = $('.owl-carousel');
		    
		    owl.owlCarousel({
		        items:3,                 // 한번에 보여줄 아이템 수
		        loop:true,               // 반복여부
		        margin:10,               // 오른쪽 간격
		        autoplay:true,           // 자동재생 여부
		        autoplayTimeout:1800,    // 재생간격
		        autoplayHoverPause:true  //마우스오버시 멈출지 여부
		    });  
		});
		</script>
		
		<script src="https://unpkg.com/vue-star-rating/dist/VueStarRating.umd.min.js"></script>
    	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
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
					$(this).find('svg:nth-child(-n+'+rate+')').css({color:'#F5A428'});
				});
					
					
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
		
		

<%@include file="includes/footer.jsp" %>
