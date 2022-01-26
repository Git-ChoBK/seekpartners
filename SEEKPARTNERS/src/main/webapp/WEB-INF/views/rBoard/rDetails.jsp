<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
	<style>
		.uploadResult {
			padding-bottom: 10px;
			padding-left:0px;
			padding-right:0px;
			overflow: hidden;
		}
		
		.uploadResult img {
			height: 391px;
		}
		
		.bigPictureWrapper{
			position: absolute;
			display: none;
			justify-content: center;
			align-items: center;
			top:0%;
			left:0%;
			width:100%;
			height: 100%;
			background-color: gray;
			z-index: 100;
			background:rgba(255,255,255,0.5); 
		}
		.bigPicture{
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.bigPicture img{
			width: 600px;
		}
	</style>

		<!-- start review-detial-page ---------------------------------------------------------------------->
		<section class="list-page" id="review-detail">
			<div class="container">
				<div class="get-single-item">
					<div class="up-content">
						<div class="row">
							<div class="col-lg-6">
								<div>
									<span id="details-menu">[<c:out value="${rInfo.r_shop}" />]</span> 
									<span class="make_star" style="display:inline-block;">
										<ul class="rating" data-rate="<c:out value='${rInfo.r_score}'/>">
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
											<i class="fas fa-star"></i>
										</ul>
								    </span> <br>
									<span id="details-title"><c:out value="${rInfo.r_title}"/></span>
								</div>
								<hr>
								<div class="description mb-3">
									<span class="m_writer">[<c:out value="${rInfo.m_id}" />]</span>
								    <div class="date pull-right" style="display:inline-block">
									  <h6><fmt:formatDate pattern="MM" value="${rInfo.r_date }"/><span>월 &ensp;<fmt:formatDate pattern="dd" value="${rInfo.r_date }"/>일</span></h6>
								    </div>
								    
								</div>
									<div id="details-content" class="form-control" style="height:456px;"><pre><c:out value="${rInfo.r_content}"/></pre>
								</div>
								<%-- <sec:authentication property="principal" var="prin"/>
									<sec:authorize access="isAuthenticated()">
										<div id="details-btns" class="row btn-group">
											<c:if test="${prin.username eq rInfo.m_id }">
											<button data-oper='modify' class="btn mt-3 btn btn-outline-secondary">수정</button>
											<button data-oper='remove' class="btn mt-3 btn btn-outline-secondary">삭제</button>
											</c:if>
											<button data-oper='list' class="btn mt-3 btn-outline-secondary">목록</button>
										</div>
									</sec:authorize> --%>
							</div>
							<div class="col-lg-6 rdetail_bottom">
								<div id="right-info" class="row form-control" style="padding-top: 0px;">
									<div class="col-lg-12">
										<div class="row" style="height: 270px;">
											<div class="uploadResult">
								               	<ul>
								               	
								               	</ul>
											</div>
											<br>
											<div id="map" style="width: 100%; height: 85%;">
											</div>
											<span id=parea>[<c:out value="${rInfo.r_area}"/>]</span>
										</div>
									</div>
										<br>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="down-content row">
					<div class="col-lg-6">
					<sec:authentication property="principal" var="prin"/>
						<sec:authorize access="isAuthenticated()">
							<div id="details-btns" class="btn-group" style="width:100%;">
								<c:if test="${prin.username eq rInfo.m_id || prin.member.authList[0].m_auth eq 'ROLE_ADMIN'}">
									<button data-oper='modify' class="btn mt-3 btn btn-primary">수정</button>
									<button data-oper='remove' class="btn mt-3 btn btn-primary">삭제</button>
								</c:if>
								<button data-oper='list' class="btn mt-3 btn-primary">목록</button>
							</div>
						</sec:authorize>
					</div>
					
					<div class="col-lg-6">
								<button data-oper='go_p' class="btn mt-3 btn-primary" style="background-color:rgb(245, 164, 40);">여기로 식구모집하기 >></button>
						<br>
						<form action="/rBoard/rModify" id="operForm" method="get">
							<input type="hidden" id="rbno" name="rbno" value='<c:out value="${rInfo.rbno}" />' />
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
							<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
							<input type="hidden" id="tokenR" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
						<form action="/pBoard/areapRegister" id="poperForm" method="get">
							<input type="hidden" id="area" name="area" value='<c:out value="${rInfo.r_area}"/>'/>
						</form>			
					</div>
					</div>
				</div>
				
			</div>
			<input id="tempID" type="hidden">
		</section>
		<!-- end review-detial-page -->
		<div class='bigPictureWrapper'>
				<div class='bigPicture'>
				</div>
			</div>

	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	<script src="https://unpkg.com/vue-star-rating/dist/VueStarRating.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
	
	
	<!-- Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 -->
	<script>
	$(document).ready(function(){
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});		
	});
	
	</script>
	<!-- 카카오 지도 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d61ac23893abb8b73e966a969104866a&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};
		
		// 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($("#parea").text(), function(result, status) {
			// 정상적으로 검색이 완료됐으면
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				var latVal = coords.getLat();
				var lngVal = coords.getLng();
				
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});
				
				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div style="width:150px; text-align:center; padding:6px 0;">식사장소</div>'
				});
				
				infowindow.open(map, marker);
				
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});
	</script>
	
	<script>
     //상세보기 썸네일
     $(document).ready(function(){
     	var rbno = '<c:out value="${rInfo.rbno}"/>';
     	$.getJSON("/rBoard/getAttachList", {rbno:rbno}, function(arr){
     		
     		var str = "";
     		
     		$(arr).each(function(i,attach){
     			//image type
     			if(attach.filetype){
     				var fileCallPath = encodeURIComponent(attach.uploadpath+"/s_"+attach.uuid+"_"+attach.filename);
     				
     				str+="<li style='cursor:pointer' data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'><div>";
     				str+="<img src='/display?fileName="+fileCallPath+"'>";// 엔코딩값 썸네일로 호출
     				str+="</div>";
     				str+="</li>";
     			}else{
     				str+="<li style='cursor:pointer' data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'><div>";
     				str+="<span>"+ attach.filename+"</span><br/>";
     				str+="<img src='/resources/img/attach.png'>"; //이미지파일이 아니면 대체될 이미지
     				str+="</div>";
     				str+="</li>";
     			}
     		});
     		$(".uploadResult ul").html(str);
     	});// end getJSON
     	
     });
     </script>
     
       <script>//별점 처리
           $(document).ready(function(){
                $(function(){
                    var rating = $('.make_star .rating');
                    
                    rating.each(function(){
                        var targetScore = $(this).attr('data-rate');
                        $(this).find('svg:nth-child(-n+'+targetScore+')').css({'color':'#F5A428', 'font-size':'25px'});
                    });
                });
            });
        </script>
		<script type="text/javascript">
		$(document).ready(function() {
			var operForm = $("#operForm");
			var formObj = $("form");
			var poperForm = $("#poperForm");
			
			$("button[data-oper='modify']").on("click",function (e) {
				operForm.attr("action", "/rBoard/rModify").submit();
			});
			
			$("button[data-oper='remove']").on("click",function (e) {
		
				e.preventDefault();
				Swal.fire({
					  title: '리뷰글을 삭제하시겠어요?',
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
					    Swal.fire(
					      '성공!',
					      '게시글이 정상적으로 지워졌어요:)',
					      'success',
					    ).then(function(){
					    	operForm.attr("action", "/rBoard/rRemove").attr("method", "post").submit();
					  })
					}
				})
			});
			
			$("button[data-oper='list']").on("click", function (e) {
				operForm.find("#rbno").remove();
				operForm.find("#tokenR").remove();
				operForm.attr("action", "/rBoard/rList");
				operForm.submit();
			});
			
			$("button[data-oper='go_p']").on("click",function (e) {
				e.preventDefault();
				poperForm.attr("action", "/pBoard/areapRegister").submit();
			});	
		});
	</script>
	<script>
		$(".uploadResult").on("click", "li", function(e){
			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g), "/"));
			}
		});
		
		function showImage(fileCallPath){
			
			$(".bigPictureWrapper").css("display", "flex").show(1000);
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height: '100%'}, 500);
		}
		$(".bigPictureWrapper").on("click", function(e){
   		 $(".bigPicture").animate({width: '0%', height: '0%'}, 500);
   		 setTimeout(function(){
   			 $('.bigPictureWrapper').hide();
   		 }, 500);
   	 	});
	</script>

	


	
	<%@ include file="../includes/footer.jsp" %>