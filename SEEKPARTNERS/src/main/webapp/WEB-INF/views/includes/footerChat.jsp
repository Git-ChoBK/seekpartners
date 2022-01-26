<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 </div>
  
  
  <!-- end register section -->


	<!--Start footer----------------------------------------------------------------------------->
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

</body>
</html>