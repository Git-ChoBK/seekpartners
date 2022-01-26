<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale1">
	<link rel="stylesheet" href="/resources/assets/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/assets/css/custom.css">
	<title>채팅방</title>
	
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script type="/resources/assets/js/bootstrap.js"></script>
	

</head>
<body>

	<div class="chatcontainer">
		<div class="container bootstrap snippet">
			<div class="row" style="margin-right:0px;">
				<div class="col-xs-12">
					<div class="portlet portlet-default" style="margin-bottom:0px;">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4><i class="fa fa-circle text-green"></i><c:out value="${ChatInfo.pbno}"/>번 채팅방</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collaps collapse in">
							<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 530px;">
								<div class="row">
									<div class="col-lg-12">
										<p class="text-center text-muted small">맨 처음 입니다.</p>
									</div>
								</div>

							</div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="hidden" id="chatName"
											class="form-control" value="<c:out value="${ChatInfo.m_id}"/>" maxlength="20">
									</div>
								</div>
								<div class="row" style="height: 90px">
									<div class="form-group col-xs-10">
										<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- <div class="alert alert-success" id="successMessage" style="display :none">
			<strong>메시지 전송에 성공하였습니다.</strong>
		</div> -->
		<!-- <div class="alert alert-success" id="nonecontentMessage" style="display :none">
			<strong>텍스트를 입력해주세요.</strong>
		</div> -->
	</div>
</body>
	<script type="text/javascript">
	$('textarea').keypress(function(event){
	     if ( event.which == 13 ) {
	         $('button').click();
	         return false;
	     }
	});
		function submitFunction() {
			var chatName = $('#chatName').val();
			var chatContent = $('#chatContent').val();
			
			var today = new Date();   

			var hours = ('0' + today.getHours()).slice(-2); 
			var minutes = ('0' + today.getMinutes()).slice(-2);
			var seconds = ('0' + today.getSeconds()).slice(-2); 

			var timeString = hours + ':' + minutes  + ':' + seconds;
			
			$.ajax({
				type: "POST",
				url: "/pBoard/chatroom",
				data: {
					pbno: <c:out value="${ChatInfo.pbno}"/>,
					chatName: chatName,
					chatContent: chatContent
				},
				success: function(){
					if(chatContent !='') {
						//autoClosingAlert('#successMessage', 1000);
						if(socket){
							var socketmsg = <c:out value="${ChatInfo.pbno}"/>+","+chatName+","+chatContent+","+timeString;
							socket.send(socketmsg);
						}
					}else{
						//autoClosingAlert('#nonecontentMessage', 1000);
					}
				}
			});
			$('#chatContent').val(''); 
		}
		function autoClosingAlert(selector, delay) {
			$(selector).css('display','block');
			window.setTimeout(function(){ $(selector).css('display','none'); }, delay);
		}

		function addChat(chatName, chatContent, chatTime){
			<sec:authentication property="principal" var="prin"/>
			var prinuser = '${prin.username}';
			var assessstr = "\"assess/"+chatName+"/"+prinuser+"\"";
			$('#chatList').append(
					'<div class="row">' +
					'<div class="col-lg-12">' +
					'<div class="media">' +
					'<div class="media-body">' +
					'<h4 class="media-heading">' +
					'<a href='+
					assessstr +
					'class="m_writer" onClick="window.open(this.href,\'평가하기\',\'width=750, height=728\'); return false;">'+
					chatName +
					'</a>'+
					'</h4>' +
					'<span class="small">' +
					chatTime +
					'</span>' +
					'</div>' +
					'<p>' +
					chatContent +
					'</p>' +
					'</div>' +
					'</div>' +
					'</div>'
					
					);
				
			if(chatName === prinuser) {
				$(".media").eq($(".media").length-1).addClass("isMe pull-right");
				$(".media-heading").eq($(".media-heading").length-1).addClass("pull-right");
			} else {
				$(".media").eq($(".media").length-1).removeClass("isMe pull-right");
				$(".media-heading").eq($(".media-heading").length-1).removeClass("pull-right");
			}
			
			$(chatList).scrollTop($(chatList)[0].scrollHeight);
		}
		
	</script>
	   <script>
	   var socket = null;

   $(document).ready(function(){
      var csrfHeaderName = "${_csrf.headerName}";
      var csrfTokenValue = "${_csrf.token}";
      $(document).ajaxSend(function(e, xhr, options){
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      });  
      
      var sendname = '${sendname}';
      var sendtime = '${sendtime}';
      var sendcontent = '${sendcontent}';
      
      var namesplit = sendname.split(',');
      var timesplit = sendtime.split(',');
      var contentsplit = sendcontent.split(',');
      
      for(var i=0;i<namesplit.length-1;i++){
    	  addChat(namesplit[i], contentsplit[i], timesplit[i]);	
      }
      $(chatList).scrollTop($(chatList)[0].scrollHeight);
      connectWS();
   });
   
   function connectWS(){
	   var str = <c:out value="${ChatInfo.pbno}"/>;
       //var ws = new WebSocket("ws://192.168.0.11:8181/chatecho?pbno="+str);
       var ws = new WebSocket("ws://localhost:8181/chatecho?pbno="+str);
       socket = ws;
   
       ws.onopen = function () {
       };
   
       ws.onmessage = function (event) {
           addChat(event.data.split(',')[1], event.data.split(',')[2], event.data.split(',')[3]);
       };
   
       ws.onclose = function (event) { 
          };
       ws.onerror = function (err) { console.log("ws.onerror : " + err); };
      
   }
   </script>
</html>