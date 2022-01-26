<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>
<style>
.uploadResult{ 
	width:100%;
	height:100px; 
	background-color: #e9ecef;
	border : 1px solid #ddd;
	border-radius : 2px;
	margin-top : 10px;
	margin-left: 10px;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items: center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:50px;
}
.btn-circle{
	width:25px !important;
	height:25px !important;
	line-height:0px !important;
}


</style>
	<!-- start register section -------------------------------------------------------------------------->
	<section class="list-page" id="register-review">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 reg-con">
					<div class="get-single-item">
						<div class="card card-default">
							<div class="card-header"><h3>식구 찾기</h3></div>	
							<div class="card-body">
								<form role="form" action="/rBoard/rModify" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									<input type="hidden" value ='<c:out value="${rInfo.rbno}"/>' id="rbno" name ="rbno" />
                         			<input type="hidden" value ='<c:out value="${rInfo.m_id}"/>' name="m_id" value='<sec:authentication property="principal.username"/>' readonly>
									<div class="form-group regform">
										<label>제목</label>
										<input autocomplete="off" class="form-control input-border-def" name="r_title" autofocus value ='<c:out value="${rInfo.r_title}"/>' />
										<div class="row form-group">
											<div class="col-lg-6" id="seek-date">
												<label>별점</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
						                      	  	<div class="make_star">
														<select name="r_score" id="makeStar">
															<option value="1">1</option>
															<option value="2">2</option>
															<option value="3">3</option>
															<option value="4">4</option>
															<option value="5">5</option>
														</select>
														<div class="rating" data-rate='<c:out value="${rInfo.r_score}"/>' >
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>	
														</div>
													</div>
											</div>
											<div class="col-lg-6">
												<label>가게이름</label>
        		                        		<input autocomplete="off" class="form-control input-boder-none" name="r_shop" value='<c:out value="${rInfo.r_shop }"/>' >
											</div>
										</div>
										
										<div class="row form-group">
											<!-- 첨부파일등록 ---------------------------------------------------------------------------->
								            <div class="row">
								                <div class="col-lg-12">
								                    <div>
								                        <div>
								                            사진은 한장만 등록해주세요
								                        </div>
								                        <!-- /.panel-heading -->
								                        <div>                        	                      	
								                          	<div class="form-group uploadDiv">	                            	
								                            	<input type="file" name="uploadFile" multiple>
								                            </div>
								                            <div class="uploadResult">
								                            	<ul>
								                            	
								                            	</ul>
								                            </div>            
								                        </div>
								                        <!-- /.panel-body -->
								                    </div>
								                    <!-- /.panel -->
								                </div>
								                <!-- /.col-lg-12 -->
								            </div>
								            <!-- /.row -->  
							              <!-- 첨부파일등록 -->
										</div>
										<br>
										
										<label>내용</label>
										<textarea class="form-control input-border-def" rows="10" name="r_content"><c:out value="${rInfo.r_content}" /></textarea>
												
												
										<!--지도영역-->
										<label>위치 지정</label>
										<!-- <textarea class="form-control input-boder-none" rows="10"></textarea> -->
												
										<div class="row form-group form-inline">
											<div class="col-lg-2">
												<a type="button" class="btn btn-outline-primary mb-2" onclick="getRegion()">
												주소검색
												</a>
											</div>
											<div class="col-lg-10">
												<input type="text" id="getAddress" class="form-control input-border-def" name="r_area" readonly value ='<c:out value="${rInfo.r_area}"/>' />
											</div>
										</div>
										
										<div id="map" class="lg-8" style="min-width:300px; min-height: 300px;">
											<input type="hidden" id="Lat" value ='<c:out value="${rInfo.lat}"/>' name ="lat" />
											<input type="hidden" id="Lng" value ='<c:out value="${rInfo.lng}"/>' name ="lng" />
										</div>
									</div>
											<!--regForm 끝-->
											
									<div class="mt-3 mb-3" style="text-align: center;">
										<button type="submit" data-oper="rModify" class="btn btn-outline-dark">수정</button>
									</div>
								</form>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</section>
	<!-- end register section -->

    <script src="/resources/assets/js/jquery.datetimepicker.js"></script>
	<script src="https://unpkg.com/vue-star-rating/dist/VueStarRating.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js"></script>
	
	
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b35260abd815a3642778f0bf811a9f8&libraries=services"></script>
	
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
	
	<script type="text/javascript">
	
		
		var lt = '<c:out value="${rInfo.lat}"/>';
		var lg = '<c:out value="${rInfo.lng}"/>';
        
		// 지도 설정
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new daum.maps.LatLng(lt, lg), // 지도의 중심좌표
				level: 4 // 지도의 확대 레벨
			};
		
		// 지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		
		// 주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		
		// 마커를 미리 생성
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(lt, lg),
			map: map
		});
		
		//주소검생 클릭 시 활성화
		function getRegion() {
			new daum.Postcode({
				oncomplete: function (data) {
					var addr = data.address;	// 최종 주소 변수
										
					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("getAddress").value = addr;
					
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results, status) {
						// 정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {
							var result = results[0]; //첫번째 결과의 값을 활용
														
							// 해당 주소에 대한 좌표를 받아서
							var coords = new daum.maps.LatLng(result.y, result.x);
							var latVal = coords.getLat();
							var lngVal = coords.getLng();
							
							
							// 지도를 보여준다.
							mapContainer.style.display = "block";
							map.relayout();
							
							// 지도 중심을 변경한다.
							map.setCenter(coords);
							
							// 마커를 결과값으로 받은 위치로 옮긴다.
							marker.setPosition(coords);
							
							document.getElementById("Lat").value = latVal;
							document.getElementById("Lng").value = lngVal;
							
						}
					});
				}
			}).open();
		}

    </script>
	<script>
    	$(document).ready(function(){
    			var rbno = '<c:out value="${rInfo.rbno}"/>';
    			
    			$.getJSON("/rBoard/getAttachList", {rbno: rbno}, function(arr){
    				var str = "";
    				
    				$(arr).each(function(i, attach){
    					//image type
    	     			if(attach.filetype){
    	     				var fileCallPath = encodeURIComponent(attach.uploadpath+"/s_"+attach.uuid+"_"+attach.filename);
    	     				str+="<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'><div>";
    	     				str+="<span>"+attach.filename+"</span>";
    	     				str+="<button type='button data-file=\'"+fileCallPath+"\' data-type='img' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    	     				str+="<img src='/display?fileName="+fileCallPath+"'>";
    	     				str+="</div>";
    	     				str+="</li>";
    	     			}else{
    	     				str+="<li data-path='"+attach.uploadpath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.filename+"' data-type='"+attach.filetype+"'><div>";
    	     				str+="<span>"+ attach.filename+"</span><br/>";
    	     				str+="<button type='button data-file=\'"+fileCallPath+"\' data-type='img' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    	     				str+="<img src='/resources/img/attach.png'>";
    	     				str+="</div>";
    	     				str+="</li>";
    	     			}
    				});
    				$(".uploadResult ul").html(str);
    			});
    			$(".uploadResult").on("click", "button", function(e){
    				if(confirm("파일을 삭제 하시겠습니까?")){
    					var targetLi = $(this).closest("li");
    					targetLi.remove();
    				}
    			});//버튼 이벤트처리 끝
    			
    			var formObj=$("form");
    			$("button").on("click", function(e){
    				e.preventDefault();
    				var operation = $(this).data("oper");
    				
    				if(operation == 'rModify'){
    					var str = "";
        				$(".uploadResult ul li").each(function(i,obj){
            				var jobj=$(obj);
            				str +="<input type='hidden' name='attachList["+i+"].filename' value='"+jobj.data("filename")+"'>";
            				str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
            				str +="<input type='hidden' name='attachList["+i+"].uploadpath' value='"+jobj.data("path")+"'>";
            				str +="<input type='hidden' name='attachList["+i+"].filetype' value='"+jobj.data("type")+"'>";
            			});
            			formObj.append(str).submit();
    				}
    				formObj.submit();
    			});//button end
    			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|js|jar)$");
    			var maxSize = 5242880;
    			
    			function checkExtension(fileName, fileSize){
    				if(fileSize >= maxSize){
    					alert("파일 사이즈가 5MB를 초과하였습니다.")
    					return false;
    				}
    				
    				if(regex.test(fileName)){
    					alert("해당 종류의 파일은 업로드할 수 없어요");
    					return false;
    				}
    				return true;
    			}
    			$("input[type='file']").change(function(e){
    				var formData = new FormData();
    				var inputFile =$("input[name='uploadFile']");
    				var files = inputFile[0].files;
    				
    				for(var i = 0; i < files.length; i++){
    					if(!checkExtension(files[i].name, files[i].size) ){
    						return false;
    					}
    					formData.append("uploadFile", files[i]);
    				}
    				
    				$.ajax({
    					url: '/uploadAjaxAction',
    					processData: false,
    					contentType: false,
    					data: formData,
    					type: 'POST',
    					dataType: 'json',
    					success: function(result){
    						showUploadResult(result);
    					}
    				}); // ajax end
    			});// input end
    			
    			function showUploadResult(uploadResultArr){
                    //업로드파일이 없으면 중지
                    if(!uploadResultArr || uploadResultArr.length == 0){ 
                       return; 
                    }                         
                    
                    var uploadUL = $(".uploadResult ul");                         
                    var str ="";
                    
                    $(uploadResultArr).each(function(i, obj){   
                       
                        //이미지이면 썸네일을 보여준다.
                        if(obj.image){
                          var fileCallPath =  encodeURIComponent( obj.uploadpath+ "/s_"+obj.uuid +"_"+obj.filename);
                          str += "<li data-path='"+obj.uploadpath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'><div>";
                          str += "<span> "+ obj.filename+"</span>";
                          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                          str += "<img src='/display?fileName="+fileCallPath+"'>";
                          str += "</div>";
                          str +="</li>";
                        }else{//파일이면 파일명과 attach.png를 보여준다
                          var fileCallPath =  encodeURIComponent( obj.uploadpath+"/"+ obj.uuid +"_"+obj.filename);            
                          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
                              
                          str += "<li data-path='"+obj.uploadpath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'><div>";
                          str += "<span> "+ obj.filename+"</span>";
                          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                          str += "<img src='/resources/img/attach.png'></a>";
                          str += "</div>";
                          str +="</li>";
                        } 

                    });
                    
                    uploadUL.append(str);
                  }
    	});
    
    </script>
    
    <script>//별점등록처리
	$(document).ready(function(){
		var userScore = $('#makeStar');
		userScore.change(function(){
			var userScoreNum = $(this).val();
			$('.make_star svg').css({color:'#000'});
			$('.make_star svg:nth-child(-n+'+userScoreNum+')').css({color:'#F5A428'});
		});
	});
	</script>
	<script>//별점 처리
    $(document).ready(function(){
    	var userScore = $('#makeStar');
         $(function(){
             var rating = $('.make_star .rating');

             rating.each(function(){
                 var targetScore = $(this).attr('data-rate');
            	 
            	 $('#makeStar>option').eq(targetScore-1).attr("selected", "selected");
            	 
                 $(this).find('svg').css({color:'#000'});
                 $(this).find('svg:nth-child(-n+'+targetScore+')').css({color:'#F5A428'});
             });
         });
     });
 </script>

	
	<%@ include file="../includes/footer.jsp" %>