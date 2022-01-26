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
						<input class="form-control search-box over" type="text" name="keyword" aria-label="test" aria-describedby="button-addon2"/>
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
		          <li data-filter="*" class="active">All</li>
		          <li data-filter=".soon">치킨</li>
		          <li data-filter=".imp">피자</li>
		          <li data-filter=".imp">분식</li>
		          <li data-filter=".att">한식</li>
		          <li data-filter=".att">일식/돈까스</li>
		          <li data-filter=".att">중식</li>
		          <li data-filter=".att">양식</li>
		          <li data-filter=".att">찜/탕</li>
		          <li data-filter=".att">디저트</li>
		          <li data-filter=".att">야식</li>
		          <li data-filter=".imp">비건</li>
		          <li data-filter=".att">아시안</li>
		          <li data-filter=".att">기타</li>
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
											<div class="col-lg-8" style="padding-right:0px;">
												<h4 id="area-info" class="partner-cat seek-split">[<c:out value="${pInfo.p_areasplit}" />]</h4>
												<h4 id="menu-info" class="partner-cat">[<c:out value="${pInfo.p_menu }" />]</h4>
											</div>
											
											<div class="col-lg-4" style="padding-left:0px; text-align: center;">
												<h6><fmt:formatDate pattern="dd" value="${pInfo.p_time }" /><span>일</span></h6>
												<p id="time-info"><fmt:formatDate pattern="HH:mm" value="${pInfo.p_time }" /></p>
											</div>

										</div>
									</div>
									<div class="info">
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
						<div class="row">
					
							<!-- 반복 ----------------------------------------------------------------------------->
							<div class="col-lg-3">
								<div class="card-shape-item">
									<div class="thumb">
										<div class="price">
											<div class="row">
												<span>
													<ul>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
													</ul>
												</span>
											</div>
										</div>
										
										<a href="rs-details.html">
											<img src="../resources/assets/images/food001.jpg" />
										</a>
									</div>
									
									<div class="down-content">
										<div class="date">
											<h6>MM <span>dd</span></h6>
										</div>
										<h4 class="region">[지역]</h4>
										<h4>가게이름</h4>
										<h6>글 제목</h6>
									</div>
								</div>
							</div>
							<!-- 반복 ----------------------------------------------------------------------------->
							
							<div class="col-lg-3">
								<div class="card-shape-item">
									<div class="thumb">
										<div class="price">
											<div class="row">
												<span>
													<ul>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
													</ul>
												</span>
											</div>
										</div>
										
										<a href="rs-details.html">
											<img src="../resources/assets/images/food002.jpg" />
										</a>
									</div>
									
									<div class="down-content">
										<div class="date">
											<h6>MM <span>dd</span></h6>
										</div>
										
										<h4 class="region">[지역]</h4>
										<h4>가게이름</h4>
										<h6>글 제목</h6>
									</div>
								</div>
							</div>
							
							<div class="col-lg-3">
								<div class="card-shape-item">
									<div class="thumb">
										<div class="price">
											<div class="row">
												<span>
													<ul>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
													</ul>
												</span>
											</div>
										</div>
										
										<a href="rs-details.html">
											<img src="../resources/assets/images/food002.jpg" />
										</a>
									</div>
									
									<div class="down-content">
										<div class="date">
											<h6>MM <span>dd</span></h6>
										</div>
										
										<h4 class="region">[지역]</h4>
										<h4>가게이름</h4>
										<h6>글 제목</h6>
									</div>
								</div>
							</div>
							
							<div class="col-lg-3">
								<div class="card-shape-item">
									<div class="thumb">
										<div class="price">
											<div class="row">
												<span>
													<ul>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
														<li><i class="fa fa-star"></i></li>
													</ul>
												</span>
											</div>
										</div>
										
										<a href="rs-details.html">
											<img src="../resources/assets/images/food002.jpg" />
										</a>
									</div>
									
									<div class="down-content">
										<div class="date">
											<h6>MM <span>dd</span></h6>
										</div>
										
										<h4 class="region">[지역]</h4>
										<h4>가게이름</h4>
										<h6>글 제목</h6>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>

<%@include file="includes/footer.jsp" %>
