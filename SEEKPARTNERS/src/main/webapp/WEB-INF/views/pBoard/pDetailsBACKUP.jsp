<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
	<style>
		.outer {clear:both; 
		text-align: center;}		

		section.list-page .pagination {
		    text-align: center;
		    width: auto;
		    margin-top: 30px;
		    display: inline-block;
		}
		.pagination>li{
		 float:left;}	
	</style>

		<!-- start review-detial-page ---------------------------------------------------------------------->
		<section class="list-page" id="review-detail">
			<div class="container">
				<div class="get-single-item">
					<div class="up-content">
						<div class="row">
							<div class="col-lg-8">
								<div>
									<span id="details-menu">[<c:out value="${p_board.p_menu}" />]</span>
									<span id="details-title"><c:out value="${p_board.p_title}"/></span>
								</div>
								<hr>
								<div class="description mb-3">
									<span class="badge bg-primary">모집중</span>
									<span class="badge bg-danger">모집완료</span>
									<span class="m_writer">[<c:out value="${p_board.m_id}" />]</span>
								</div>
									<div id="details-content" class="form-control"><c:out value="${p_board.p_content}"/>
								</div>
							</div>
							<div class="col-lg-4">
								<div id="right-info" class="row form-control">
									<div class="col-lg-12">
										<div class="row" style="height: 300px;">
											<div id="map" style="width: 100%; height: 100%;">
											</div>
											<span id=parea>[<c:out value="${p_board.p_area}"/>]</span>
										</div>
									</div>
										<br>
									<div class="col-lg-12">
										<div id="detaildata" class="row">
											<div class="col-lg-6 mt-2">
												<p>모집인원 : </p>
											</div>
											<div class="col-lg-6 mt-2">
												<p class="vo-data">${p_board.p_maxmember}명</p>
											</div>
											<div class="col-lg-6 mt-2">
												<p>예상금액 : </p>
											</div>
											<div class="col-lg-6 mt-2">
												<p class="vo-data">${p_board.p_total}원</p>
											</div>
										
											<div class="col-lg-6 mt-2">
												<p>약속시간 : </p>
											</div>
											<div class="col-lg-6 mt-2">
												<p class="vo-data"><fmt:formatDate pattern="MM-dd HH:mm" value="${p_board.p_time }" /></p>
											</div>
										</div>
									</div>
									<sec:authentication property="principal" var="prin"/>
									<sec:authorize access="isAuthenticated()">
									<div id="details-btns" class="row btn-group">
										<c:if test="${prin.username eq p_board.m_id }">
										<button data-oper='modify' class="btn mt-3 btn btn-outline-secondary">수정</button>
										<button data-oper='remove' class="btn mt-3 btn btn-outline-secondary">삭제</button>
										</c:if>
										<button data-oper='list' class="btn mt-3 btn-outline-secondary">
											목록
											<%-- <a href="pList?type=${cri.type}&keyword=${cri.keyword}&pageNum=${cri.pageNum}&amount=${cri.amount}">목록</a> --%>
										</button>
										<c:if test="${prin.username ne p_board.m_id }">
										<button class="btn btn-danger mt-3" style="width:66.6%">신고하기</button>
										</c:if>
									</div>
									<div class="row" style="margin:0 auto">
										
										<c:if test="${prin.username ne p_board.m_id }">
										<button class="btn btn-primary col-12 mt-3">신청/채팅하기</button>
										</c:if>
										<c:if test="${prin.username eq p_board.m_id }">
										<button class="btn btn-primary col-12 mt-3">모집완료!</button>
										</c:if>
									</div>	
										</sec:authorize>
								</div>
							</div>
						</div>
					</div>
										<%-- <p>
											작성일 : <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${p_board.p_date }" />&emsp;
											최종 수정일 : <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${p_board.p_update }" />
										</p> --%>
					<hr>
					<div class="down-content">
						<br>
						<form action="/pBoard/pModify" id="operForm" method="get">
							<input type="hidden" id="pbno" name="pbno" value='<c:out value="${p_board.pbno}" />' />
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}' />" />
							<input type="hidden" name="amount" value="<c:out value='${cri.amount}' />" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
						
							<!-- 댓글 추가 ------------------------------------------------------------------>
						<div class="reply-test">
											<!-- <span>댓글영역</span> -->

								            
							<!-- 댓글 목록  ----------------------------------------------------------------------->
							<div class='row'>
								<div class="col-lg-12">
								<!-- /.card -->
							  		<div class="card card-default">
								    	<div class="card-header">
								        	<i class="fa fa-comments fa-fw"></i> 실시간 댓글 확인
								            <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글등록</button>
								        </div>
								        <!-- 댓글 추가 Modal창 코드---------------------------------------------------------------->
										<!-- Modal --------------------------------------------------------------------->
										<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
											    	<div class="modal-header">
											        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
											            &times;
											            </button>
											            <!-- <h4 class="modal-title" id="myModalLabel">댓글달기</h4> -->
													</div>
											        <div class="modal-body">
											            <div class="form-group">
												        	<label>Reply</label>
												            <input class="form-control" name='pr_content' value='New Reply!!!!'>
											            </div>
												        <div class="form-group">
												        	<label>Replyer</label>
												            <input class="form-control" name='m_id' value='replyer'>
														</div>
												        <div class="form-group">
												        	<label>Reply Date</label>
												            <input class="form-control" name='pr_date' value=''>
														</div>
													</div>
												    <div class="modal-footer">
												    	<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
												        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
												        <button id='modalRegisterBtn' type="button" class="btn btn-default" data-dismiss="modal">Register</button>
												        <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
													</div>     
												</div>       	
												<!-- /.modal-content -->  
											</div>
											<!-- /.modal-dialog -->            	            
										</div>
										<!--/.modal  -->
									<!-- /.card-heading -->
								        <div class="card-body">
								        	<ul class="chat">	<!-- 댓글 시작 --------------><!-- replyUL -->
	
											</ul><!-- end 댓글 시작 -->		
								        	<!-- ./ end ul -->
										</div>
										<div class="card-footer">
										</div>
									    <!-- /.card-footer -->
										<!-- /.card .chat-card -->
									</div>            	
								</div>    
								<!-- ./ end row -->        
							</div>
							<!-- 댓글목록 -->
						</div>
					<!-- ./댓글 추가-------------------- -->
					</div>
				</div>
			</div>			
		</section>
		<!-- end review-detial-page -->

	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	
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
				
				console.log("coords의 값 : " + coords);
				console.log("latVal의 값 : " + latVal);
				console.log("lngVal의 값 : " + lngVal);
				
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
	<script type="text/javascript">
		$(document).ready(function() {
			var operForm = $("#operForm");
			var formObj = $("form");
			
			$("button[data-oper='modify']").on("click",function (e) {
				operForm.attr("action", "/pBoard/pModify").submit();
			});
			
			$("button[data-oper='remove']").on("click",function (e) {
		
				e.preventDefault();
				Swal.fire({
					  title: '삭제하시겠어요?',
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
							formObj.attr("action", "/pBoard/pRemove").attr("method", "post").submit();
					  })
					}
				})
			});
			
			$("button[data-oper='list']").on("click", function (e) {
				operForm.find("#pbno").remove();
				operForm.attr("action", "pList");
				operForm.submit();
			});
		});
	</script>
	<script>
		$(document).ready(function(){
       	
       		var pbnoValue = '<c:out value="${p_board.pbno}"/>';
       		var replyUL = $(".chat");
       	
       		showList(1);
       		
	       	function showList(page){
     		
     			console.log("show list "+page);
     		
     			replyService.getList({pbno:pbnoValue, page: page||1}, 
     				
     			function(replyCnt, list){
     			
     				console.log("replyCnt: "+replyCnt);
     				console.log("list: "+list);
     				console.log(list);
     				
     				if(page==-1){
     					pageNum = Math.ceil(replyCnt/10.0);
	     				showList(pageNum);
     				return;
    	 			}
     			
      				var str="";
      			
      				if(list == null || list.length == 0){
      				
      					return;
      				}
      			
	      			for(var i = 0, len = list.length || 0; i< len; i++){
	      				str +="<div>";
	      				
	      				str +="<li class='left clearfix' data-rno='"+list[i].prno+"'>";
	      				str +=" <div><div class='header'><strong class='primary-font'>"+list[i].m_id+"</strong>";
	      				str +=" &nbsp; <small class='text-muted'>"+replyService.displayTime(list[i].pr_date)+"</small></div>";
	      				str +=" <p>"+list[i].pr_content+"</p></div></li>";
	      				
	      				str +="</div>";
	      			}
	      			
	      			replyUL.html(str);
	      			console.log(str);
	      			
	      			showReplyPage(replyCnt);
     			});//end replyService.getList
     		
			}//end showList		
       		
       		
		<!-- 버튼 이벤트 처리 -------------------------------------------------->
		<!-- Modal창 버튼 이벤트 처리 ------------------------------->

			var modal = $(".modal");
    	   	var modalInputReply = modal.find("input[name='pr_content']");
       		var modalInputReplyer = modal.find("input[name='m_id']");
       		var modalInputReplyDate = modal.find("input[name='pr_date']");
       		
	       	var modalModBtn = $("#modalModBtn");
    	   	var modalRemoveBtn = $("#modalRemoveBtn");
       		var modalRegisterBtn = $("#modalRegisterBtn");
       		
     	  	$("#addReplyBtn").on("click", function(e){
       			
       			modal.find("input").val("");
       			modalInputReplyDate.closest("div").hide();
       			modal.find("button[id !='modalCloseBtn']").hide();
       			
       			modalRegisterBtn.show();
       			
       			$(".modal").modal("show");
       		});
       		
			$("#modalCloseBtn").on("click", function(e){
				
               	modal.modal('hide');
            });
       	    
       		modalRegisterBtn.on("click", function(e){
       			
       			var reply = {
       				pr_content: modalInputReply.val(),
       				m_id: modalInputReplyer.val(),
       				pbno: pbnoValue
       		};
       			
       		replyService.add(reply, function(result){
       			
    			e.preventDefault();
    			
    			if(result == "Success") {
    				Swal.fire({ 
    					icon: 'success', // Alert 타입(success, warning, error)
    					title: '등록 성공!', // Alert 제목
    					text: '댓글 등록을 성공했어요!', // Alert 내용
    				}).then(function(){
    					modal.find("input").val("");
    	       			modal.modal("hide");
    	       				
    	       			//showList(1);//댓글목록 갱신
    	       			showList(-1);
    				})
    			}
       				
       			
       				
       		});
       	});
		<!-- end Modal창 버튼 이벤트 처리 ------------>
	
		/* 댓글 클릭 이벤트 처리 */
			$(".chat").on("click", "li", function(e){
			
				var prno = $(this).data("rno");
			//console.log(prno);
			
				replyService.get(prno, function(reply){
				
					modalInputReply.val(reply.pr_content);
					modalInputReplyer.val(reply.m_id);
					modalInputReplyDate.val(replyService.displayTime(reply.pr_update)).attr("readonly", "readonly");
					modal.data("prno", reply.prno);
				
					modal.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();
				
					$(".modal").modal("show");
				});
			});
		
			modalModBtn.on("click", function(e){
			
				var reply = {prno:modal.data("prno"), pr_content: modalInputReply.val()};
			
				replyService.update(reply, function(result){
					
					if(result == "Success") {
						
						e.preventDefault();
						Swal.fire({
							  title: '댓글을 수정하시겠어요?',
							  icon: 'question',
							  showCancelButton: true,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: '수정할게요!',
							  cancelButtonText: '잠깐!',
							  
							}).then((result) => {
							  if (!result.isConfirmed) {
								  return;
							  } else {
							    Swal.fire(
							      '성공!',
							      '댓글이 정상적으로 수정됐어요:)',
							      'success',
							    ).then(function(){
									modal.modal("hide");
									showList(pageNum);
							  })
							}
						})
						
					}
				
					/* alert(result);
					modal.modal("hide");
					showList(pageNum); */															
				});
			});
		
			modalRemoveBtn.on("click", function(e){
			
				var prno = modal.data("prno");
			
				replyService.remove(prno, function(result){
					
					if(result == "Success") {
						
						e.preventDefault();
						Swal.fire({
							  title: '댓글을 삭제하시겠어요?',
							  icon: 'question',
							  showCancelButton: true,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: '삭제할게요!',
							  cancelButtonText: '잠깐!',
							  
							}).then((result) => {
							  if (!result.isConfirmed) {
								  return;
							  } else {
							    Swal.fire(
							      '성공!',
							      '댓글이 정상적으로 삭제됐어요:)',
							      'success',
							    ).then(function(){
									modal.modal("hide");
									showList(pageNum);
							  })
							}
						})
						
					}
					
					/* alert(result);
					modal.modal("hide");
					showList(pageNum); */
				});
			});
			<!-- end 버튼 이벤트 처리 ------------->

			/* <div class='card-footer'>에 댓글 페이지 번호 출력하는 로직 */
			var pageNum = 1;
        	var replyPageFooter = $(".card-footer");
                  	    
        	function showReplyPage(replyCnt){
                  	      
	        	var endNum = Math.ceil(pageNum / 10.0) * 10;  
	        	var startNum = endNum - 9; 
	                  	      
	        	var prev = startNum != 1;
	        	var next = false;
	                  	      
		        if(endNum * 10 >= replyCnt){
		           	endNum = Math.ceil(replyCnt/10.0);
		        }
	                  	      
	        	if(endNum * 10 < replyCnt){
	          		next = true;
	        	}
	                  
		        var str = "<div class='outer'>";
		            str += "<ul class='pagination'>";
		                  	      
		        if(prev){
		           	str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
		        }
		                  	      
		        for(var i = startNum ; i <= endNum; i++){	                            	       
		        var active = pageNum == i? "active":"";
		                  	      
		         	str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		        }
		                  	      
		        if(next){
		           	str+= "<li class='page-item'><a class='page-link clearfix' href='"+(endNum + 1)+"'>Next</a></li>";
		        }
		
		            str += "</ul></div>";
		                
	                  	      
	    	    replyPageFooter.html(str);
	        	console.log(str);
	        }

                  
	        replyPageFooter.on("click", "li a", function(e){
    	    	e.preventDefault();
        		console.log("page click");
        	
        		var targetPageNum = $(this).attr("href");
        	
        		console.log("targetPageNum: "+targetPageNum);
        	
        		pageNum = targetPageNum;
        	
        		showList(pageNum);
        	
        	})
                  
       });
       
	</script>

	
	<%@ include file="../includes/footer.jsp" %>