<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp" %>

	<!-- start register section -------------------------------------------------------------------------->
	<section class="list-page" id="register-review">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 reg-con">
					<div class="get-single-item">
						<div class="card card-default">
							<div class="card-header"><h3>식구 찾기</h3></div>	
							<div class="card-body">
								<form role="form" action="/pBoard/pModify" method="post">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									<input type="hidden" value ='<c:out value="${p_board.pbno}"/>' name ="pbno" />
                         			<input type="hidden" value ='<c:out value="${p_board.m_id}"/>' name="m_id" value='<sec:authentication property="principal.username"/>' readonly>
									<div class="form-group regform">
										<label>제목</label>
										<input autocomplete="off" class="form-control input-border-def" name="p_title" autofocus value ='<c:out value="${p_board.p_title}"/>' />
										<div class="row form-group">
											<div class="col-lg-6" id="seek-date">
												<label>시간</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
												<input name="p_time" class="form-control" autocomplete="off" value ='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${p_board.p_time }" />' />
											</div>
											<div class="col-lg-6">
												<label>금액</label>
				                            		<input autocomplete="off" class="form-control" name="p_total" type="number" value='<c:out value="${p_board.p_total}"/>' step="1000">
											</div>
										</div>
										
										<div class="row form-group">
											<div class="col-lg-6">
												<label>인원</label>
												<select id="max" class="form-select" name ="p_maxmember">
													<option>2</option>
													<option>3</option>
													<option>4</option>
													<option>5</option>
												</select>
											</div>
											<div class="col-lg-6">
												<label>메뉴</label>
												<select id="menu"class="form-select" name="p_menu">
													<option>한식</option>
													<option>중식</option>
													<option>양식</option>
													<option>일식</option>
													<option>야식</option>
													<option>분식</option>
													<option>찜/탕</option>
													<option>치킨</option>
													<option>피자</option>
													<option>비건</option>
													<option>디저트</option>
													<option>아시안</option>
													<option>기타</option>
												</select>
											</div>
										</div>
										<br>
										
										<label>내용</label>
										<textarea class="form-control input-border-def" rows="10" name="p_content"><c:out value="${p_board.p_content}" /></textarea>
												
												
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
												<input type="text" id="getAddress" class="form-control input-border-def" name="p_area" readonly value ='<c:out value="${p_board.p_area}"/>' />
											</div>
										</div>
										
										<div id="map" class="lg-8" style="min-width:300px; min-height: 300px;">
											<input type="hidden" id="Lat" value ='<c:out value="${p_board.lat}"/>' name ="lat" />
											<input type="hidden" id="Lng" value ='<c:out value="${p_board.lng}"/>' name ="lng" />
										</div>
									</div>
											<!--regForm 끝-->
											
									<div class="card-footer">
										<button id="registerBtn" class="btn">글 수정</button>
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

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b35260abd815a3642778f0bf811a9f8&libraries=services"></script>
	
	<!-- Security적용 후 ajax 사용시 csrf값을 서버에 전송하는 코드 -->
	<script>
	
	/* $(document).ready(function(){
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});		
	}); */
	
	</script>
	
	<script type="text/javascript">
	
		
		var lt = '<c:out value="${p_board.lat}"/>';
		var lg = '<c:out value="${p_board.lng}"/>';
        
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
        //지도 설정 끝
        
        $(document).ready(function() {
        	//시간 설정
        	var dateInput = $('input', '#seek-date').focus(function() {
        		$('.dateDropdown', '#seek-date').remove();
        		
        		var dateDropdown = $('<div class="dateDropdown"/>').appendTo('#seek-date');
        		dateDropdown.datetimepicker({
        			
        			date: dateInput.data('value') || new Date(),
        			viewMode: 'YMDHM',
        			onDateChange: function() {
        				dateInput.val(this.getText());
        				dateInput.data('value', this.getValue());
       				},
       				onOk: function() {
       					dateDropdown.remove();
   					}
   				});
       		}); //시간 설정 끝
        });
        
        $("#registerBtn").on("click", function(e) {
        	
        	e.preventDefault();
        	
        	if ($("input[name='p_title']").val() === "") {
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '제목을 입력해주세요', // Alert 내용
				});
 
        		return;
       		}
        	
        	if ($("input[name='p_time']").val() === "") {
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '만날 시간을 입력해주세요', // Alert 내용
				});
        		
        		return;
       		}
        	
        	if ($("input[name='p_total']").val() === "") {
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '금액을 입력해주세요', // Alert 내용
				});
        		
        		return;
       		}
        	
        	if($("textarea[name='p_content']").val() === "") {
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '내용을 입력해주세요', // Alert 내용
				});
        		
        		return;
       		}
        	
        	if($("input[name='p_area']").val() === "") {
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '만날 장소를 입력해주세요', // Alert 내용
				});
        		return;
       		}
        	
        	Swal.fire({ 
				icon: 'success', // Alert 타입(success, warning, error)
				title: '글 수정 성공!', // Alert 제목
				text: '성공적으로 수정을 완료했습니다!', // Alert 내용
			}).then(function(){
				$("form").submit();
			});
        	        	
        });

    </script>
	<script type="text/javascript">
		//셀렉트 박스 초기값(총원)
		$(document).ready(function() {
			$("#max").val('${p_board.p_maxmember}');
			$("#menu").val('${p_board.p_menu}');
			
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr, options){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});
		});
	</script>

	
	<%@ include file="../includes/footer.jsp" %>