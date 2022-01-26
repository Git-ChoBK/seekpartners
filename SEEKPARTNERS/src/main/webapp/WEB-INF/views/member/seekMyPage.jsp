<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/headerMyp.jsp" %>

<!--오른쪽 : 내용-->
<div class="col-md-8">
	<div class="row">
		<div class="categories right-section">
			<div class="container mt-3">
				<h2>내가 받은 알림</h2>
				<br>
           
				<ul id="onHere">
				<!-- ajax area -->
				</ul>
			</div>
		</div>
	</div>
</div>
<!--오른쪽 내용 끝-->


</div>
</div>
    
</section>


	
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

	
	
	$(document).ready(function(){
		
		
		/* var alarmLoc = $("#onHere");
		
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
			loadAlarm();
		}
		
		//when click a, button
		$(alarmLoc).on("click", "li>button", function(){
			alarmClick();
		});
		$(alarmLoc).on("click", "li", function(){
			alarmClick();
		}); */

		
		
		
	}); // document.ready 끝



</script>

<%@ include file="../includes/footer.jsp" %>