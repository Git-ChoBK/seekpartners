<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  </section>
  
 </div>
 
  <style>
	 #footer{ color:darkgray !important; margin:0 10% 0;}

</style>
  
  <!-- end register section -->


	<!--Start footer----------------------------------------------------------------------------->
		<footer>
	  <!-- <p>FOOTER</p> -->
	  <div id="footer">
		<div class="row">
			<div class="col-lg-3 col-sm-12">
		  			(주)SeekPartner<br>
			  		서울특별시 강남구 식파트너 빌딩 2층<br>
			  		사업자 등록번호:111-1111-11111<br>
			  		고객센터:02-111-1111<br><br>	  		
			</div> 	
			<div class="col-lg-3 col-sm-4">
		  			회사소개<br>
		  			투자정보<br>
		  			광고문의<br>
		  			채용<br><br>
		  	</div>
		  	<div class="col-lg-3 col-sm-4">
		  			공지사항<br>
		  			이용약관<br>
		  			이용 정책<br>		  			
		  			청소년 보호정책<br><br>  		
		  	</div>
		  	<div class="col-lg-3 col-sm-4">
		  			개인정보 처리방침<br>
		  			커뮤니티 가이드라인<br>
		  			서비스 소개	  			  		
		  	</div>
	  </div>
	</footer>
	<!--end footer------------------------------------------------------------------------------->
	
	<!-- Scripts -->
	
	<!-- Custom JavaScripts -->
	<script src="/resources/assets/js/isotope.min.js"></script>
	<script src="/resources/assets/js/owl-carousel.js"></script>
	<script src="/resources/assets/js/lightbox.js"></script>
	<script src="/resources/assets/js/tabs.js"></script>
	<script src="/resources/assets/js/slick-slider.js"></script>
	<script src="/resources/assets/js/custom.js"></script>
    <script src="/resources/assets/js/jquery.datetimepicker.js"></script>
    <script type="text/javascript" src="/resources/vendor/sockjs-client-main/dist/sockjs.min.js"></script>

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
	
	
	
	<script>
 	var socket = null;
	$(document).ready(function(){	
		connectWS();	
	});
	
	
//웹소켓 테스트
	
	function connectWS(){
		
	    var ws = new WebSocket("ws://localhost:8181/echo");
	    //var ws = new WebSocket("ws://192.168.0.11:8181/echo");
	    socket = ws;
	
	    ws.onopen = function () {
	        console.log('Info: 웹소켓 연결 성공');
	    };
	
	    ws.onmessage = function (event) {
	        console.log("ReceiveMsg : " + event.data+'\n');       
	        var headerAlert = $(".headerAlert");
	        var AlertUL = $("#toApd");
	        /* $(".headerAlert>span").html(event.data);
	        headerAlert.addClass('on');
	        
	        setTimeout(function(){
	        	headerAlert.removeClass('on');
	        }, 10000); */
	        
	        var str="";
	          
	        str += '<li class="alert alert-success alert-dismissible headerAlert">';
	        str += '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
	        str += '<span>'+event.data+'</span>';
	        str += '</li>';	        	

	        
	        AlertUL.append(str);
	        
	        //$(".headerAlert>span").html(event.data);
	             	
	       	$(".headerAlert").addClass('on').animate({opacity:'1'}, 1000);
	       	
	       	setTimeout(function(){
	       		$(".headerAlert").first().remove();	
	       	}, 5000);
	       	
	       	
	       	
 			var countA = document.getElementsByClassName('headerAlert').length;
			console.log(countA);
			
			var setA =$(".main-nav>.nav #ringAlarm");
			
			if(countA > 0) {
				setA.css({"color":"red", "font-size":"14px;"});
			} else {
				setA.css({"color":"black"});
			}
			
			
			
	        
	        
	        
	    };
	
	    ws.onclose = function (event) { 
	    	console.log('ws.onclose: 연결 종료');
	    	// setTimeout( function(){ connect(); }, 1000); //오토커넥션
	    	};
	    ws.onerror = function (err) { console.log("ws.onerror : " + err); };
		
	}

	

	</script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		
		var alarmLoc = $("#onHere");
		
		loadAlarm();
		
		
		
		
		function loadAlarm(){
			
			<sec:authorize access="isAuthenticated()">
	   	    
			var gboardwriter = '<sec:authentication property="principal.username"/>';
		    
			</sec:authorize>
			
			str="";
			
			$.ajax({
				url: "/member/AlarmList",
				type : "GET",
				dataType : "JSON",
				data : {"gboardwriter" : gboardwriter},
				success: function(data){					
					$.each(data, (index, data)=>{
						str +="<li class='alert alert-info' style='width: 100%'>";
						str +=	"<strong>" +'[알림]'+ "&ensp;</strong>";
						if(data.cmd == "CHAT") {
							str += 	"<a href='/pBoard/pDetails?pbno="+data.pbno+"' class='alert-link setread'>"+data.m_id+"님이 채팅방에 입장하였습니다</a>";	
						} else {
							str += 	"<a href='/pBoard/pDetails?pbno="+data.pbno+"' class='alert-link setread'>"+data.m_id+"님이 댓글을 남겼습니다</a>";
						}
						str += 	"<input type='hidden' name='ano' class='ano' value='"+data.ano+"'>";		
						str += 	"<button class='btn btn-outline-info setread pull-right' style='padding-top:0px; padding-bottom:0px;'>확인</button></li>";
						
						if(data != null){
							$("#ringAlarm").css({"color":"red", "font-size":"20px;"});
						} else {
							$("#ringAlarm").css({"color":"black", "font-size":"12px;"});
						}
					})
					alarmLoc.html(str);
					
				}	
			});//ajax 통신 끝		
			
		}
		
		//function for get rid of savealarm click
		function alarmClick() {
			var ano = $('input[name="ano"]').val();
			$.ajax({
				url: "/member/readIt",
				type : "POST",
				dataType : "JSON",
				data : {"ano" : ano},
				success : function(data){
				},
				error : function(err) {
					console.log(err);
				}
			});//ajax통신 끝
			//loadAlarm();
		}
		
		//when click a, button
		$(alarmLoc).on("click", "li>button", function(){
			alarmClick();
			$(this).parents('li').css({"display" : "none"}).remove();
			if(alarmLoc.children('li').length == 0) {
				$("#ringAlarm").css({"color":"black", "font-size":"12px;"});				
			}
		});
		
/* 		var m_id = '${prin.getUsername()}'; 
		
		function noticeAlarm() {
			$.ajax({
				url: "/member/readCount",
				type : "POST",
				dataType : "JSON",
				data : {"m_id" : m_id},
				success : function(data){
					console("성공시 반환 값 >>> ");
					console(data);
				},
				error : function(err) {
					console.log(err);
				}
			});//ajax통신 끝
		} */
		
		// noticeAlarm();
				
	});

</script>
</body>
</html>