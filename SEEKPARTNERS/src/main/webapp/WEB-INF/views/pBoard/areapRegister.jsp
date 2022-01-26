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
                     <form role="form" action="/pBoard/pRegister" method="post">
                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                         <input type="hidden" name="m_id" value='<sec:authentication property="principal.username"/>' readonly>                         
                         <div class="form-group regform"> 
                             <label>제목</label>
                             <input autocomplete="off" class="form-control input-border-def" name="p_title" autofocus>
                             
                             <div class="row form-group">
                               <div class="col-lg-6" id="seek-date">
                                 <label>시간</label>&nbsp;<span class="text-muted m-0 text-muted"></span>
                          	  	<input name="p_time" class="form-control" placeholder="주문시간을 입력해주세요" autocomplete="off">
                               </div>
                               <div class="col-lg-6">
                               	<label>금액</label>
                            		<input class="form-control" name="p_total" type="number" value="10000" step="1000">
                               </div>
                             </div>
                             
                             
                             <div class="row form-group">
                             	<div class="col-lg-6">
                            		<label>인원</label>
                           	<!-- <input class="form-control input-border-def" name="p_total" type="number" value="2" step="1"> -->
		                           	<select class="form-select" name ="p_maxmember">
	                                   <option>2</option>
	                                   <option>3</option>
	                                   <option>4</option>
	                                   <option>5</option>
		                             </select>
                              	</div>
	                              <div class="col-lg-6">
	                              	<label>메뉴</label>
	                              	<select class="form-select" name="p_menu">
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
                             <textarea class="form-control input-border-def" rows="10" name="p_content"></textarea>
                             
                             <!--지도영역-->
                             <label>위치 지정</label>
                             <!-- <textarea class="form-control input-border-def" rows="10"></textarea> -->
                             <div class="row form-group form-inline">
                             	<div class="col-lg-2">
	                                <a type="button" class="btn btn-outline-primary mb-2" onclick="getRegion()">
	                                  주소검색
	                                </a>
                              	</div>
                               	<div class="col-lg-10">
                               		<input type="text" id="getAddress" class="form-control input-border-def" name="p_area" readonly value ='<c:out value="${get_area}"/>'>	
                               	</div>
                             </div>
                             
                             <div id="map" class="lg-8" style="min-width:300px; min-height: 300px;">
                               <input type="hidden" id="Lat" value="" name ="lat">
                               <input type="hidden" id="Lng" value="" name ="lng">
                             </div>
                         </div>
                         <!--regForm 끝-->

                         <div class="card-footer">
                             <button id="registerBtn" class="btn">글 등록</button>
                         </div>
      
                     </form>
                 </div>
             </div>
           </div>
         </div>
       </div>
    </div>
   </section>

    <script src="/resources/assets/js/jquery.datetimepicker.js"></script>

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

        //지도 설정
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 4 // 지도의 확대 레벨
          };

          //지도를 미리 생성
          var map = new daum.maps.Map(mapContainer, mapOption);
          //주소-좌표 변환 객체를 생성
          var geocoder = new daum.maps.services.Geocoder();
          //마커를 미리 생성
          var marker = new daum.maps.Marker({
              position: new daum.maps.LatLng(37.537187, 127.005476),
              map: map
          });
  		// 주소-좌표 변환 객체를 생성합니다
  		var geocoder = new kakao.maps.services.Geocoder();
  		
  		// 주소로 좌표를 검색합니다
  		geocoder.addressSearch($("#getAddress").val(), function(result, status) {
  			// 정상적으로 검색이 완료됐으면
  			if (status === kakao.maps.services.Status.OK) {
  				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
  				var latVal = coords.getLat();
  				var lngVal = coords.getLng();
  				document.getElementById("Lat").value = latVal;
				document.getElementById("Lng").value = lngVal;
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
          //주소검생 클릭 시 활성화
          function getRegion() {
              new daum.Postcode({
                  oncomplete: function(data) {
                      var addr = data.address; // 최종 주소 변수
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

      $(document).ready(function(){
        //시간 설정
        var dateInput = $('input', '#seek-date').focus(function() {
                $('.dateDropdown', '#seek-date').remove();
                var dateDropdown = $('<div class="dateDropdown"/>').appendTo('#seek-date');
                dateDropdown.datetimepicker({

                  date: dateInput.data('value') || new Date(),
                  viewMode: 'YMDHM',
                  onDateChange: function(){
                      
                  dateInput.val(this.getText());
                  dateInput.data('value', this.getText());
                 },

	  	    			  onOk: function() {
                    dateDropdown.remove();
                  }
                    });
                });
        //시간 설정 끝
        
        $("#registerBtn").on("click", function(e){
        	e.preventDefault();
        	
        	if($("input[name='p_title']").val()===""){
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '제목을 입력해주세요', // Alert 내용
				});
 
        		return;
              }
        	if($("input[name='p_time']").val()===""){
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '만날 시간을 입력해주세요', // Alert 내용
				});
 
        		return;
              }
        	if($("input[name='p_total']").val()===""){
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '금액을 입력해주세요', // Alert 내용
				});
 
        		return;
            }
        	if($("textarea[name='p_content']").val()===""){
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '내용을 입력해주세요', // Alert 내용
				});
 
        		return;
            }
        	if($("input[name='p_area']").val()===""){
        		Swal.fire({ 
					icon: 'warning', // Alert 타입(success, warning, error)
					title: '필수 입력 항목 확인!', // Alert 제목
					text: '만날 장소를 입력해주세요', // Alert 내용
				});
 
        		return;
            }
        	
        	Swal.fire({ 
				icon: 'success', // Alert 타입(success, warning, error)
				title: '등록 성공!', // Alert 제목
				text: '입력하신 글이 등록됐습니다 :)', // Alert 내용
			}).then(function(){
				$("form").submit();				
			});

      	      	      	        	
        	
        })
        
        
      });
        



    </script>

<%@ include file="../includes/footer.jsp" %>