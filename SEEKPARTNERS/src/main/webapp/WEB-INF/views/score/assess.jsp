<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/headerChat.jsp" %>
<style>
	
	#scoreForm.scores-wrap{margin-top:10px; padding: 10px; height: 500px;}
	.star_rating {font-size:0; letter-spacing:-4px;}

	.star_rating a {
	
	    font-size:22px;	
	    letter-spacing:0;	
	    display:inline-block;	
	    margin-left:5px;	
	    color:#ccc;	
	    text-decoration:none;
	
	}
	
	.star_rating a:first-child {margin-left:0;}
	
	.star_rating a.onStar {color:blue;}
	
		
</style>
	<sec:authentication property="principal" var="prin"/>
	
	<form action="score/assess" method="get" id="scoreForm" class="scores-wrap">

		
		<div class="row">
			<div class="col-lg-12">
			<div class="row">
				<div class="col-8">
					<h4><c:out value="${clicked_id}"/><span>님에게 코멘트와 별점을 남겨주세요 :)</span></h4>
				</div>
				<div class="col-4">
					<button id='newBtn' type="button" class="btn btn-primary mt-2  pull-right" data-dismiss="modal">평점 등록</button>
				</div>
			
			</div>
				
				<table width="100%" id="table_score" class="table table-striped table-bordered table-hover mt-2">
						
				</table>
					
				<div class="panel-footer">
							
				</div>
				
						<!-- 유저 평가 모달창 코드 -->
				<div class="modal fade scoreModal" id="sModal" tabindex="-1" role="dialog" aria-labelledby="scoreModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
								   	<div class="modal-header">
								       	<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							            &times;
								            </button> -->											            
									</div>
								        <div class="modal-body">
											        	<!-- <div class="form-group" style="display:none"> -->
											  
								            <div class="form-group">
									        	<!-- <label>평가 게시글 번호</label> -->
									            <input class="form-control" name='sbno' value='' type="hidden">
								           </div>
								           
								           <div class="form-group">
									        	<!-- <label>평가 대상 ID</label> -->
									            <input class="form-control" name='s_id' value='' type="hidden"><!-- 데이터베이스에 실제 있는 m_id 값을 value로 설정해야함 -->
								           </div>
									        <div class="form-group">
									        	<label>평가자 ID</label>
									            <input class="form-control" name='m_id' value=''>	
											</div>
									        <div class="form-group">
									        	<label>별점</label>
									        	
									        	<p class="star_rating">
												    <a href="#" class="onStar" id="star1">★</a>
												    <a href="#" class="onStar" id="star2">★</a>
												    <a href="#" class="onStar" id="star3">★</a>
												    <a href="#" class="onStar" id="star4">★</a>
												    <a href="#" class="onStar" id="star5">★</a>
												    <input name='starValue' value='' type="hidden">
												</p>
												
									            <input class="form-control" name='s_score' value='' placeholder="최소:1점~최대:5점">
											</div>
											<div class="form-group">
									        	<label>코멘트</label>
									            <input class="form-control" name='s_comment' value='' placeholder="평가 사유를 입력하세요" autocomplete="off">
											</div>
									</div>
								    <div class="modal-footer">
										    <!-- <button id='modalRegisterBtnS' type="button" class="btn btn-default" data-dismiss="modal">Register</button> -->
									    	<button id='modalModBtnS' type="button" class="btn btn-warning">수정</button>
									    	<button id='modalRegisterBtnS' type="button" class="btn btn-default" data-dismiss="modal">등록</button>
									        <button id='modalRemoveBtnS' type="button" class="btn btn-danger">삭제</button>											        
									        <button id='modalCloseBtnS' type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
									</div>     
								</div>       	
							<!-- /.modal-content -->  
							</div>
						<!-- /.modal-dialog -->            	            
				</div>
			<!-- ./ 유저 평가 모달창 코드				 -->
			
			</div>
		</div>
		
	</form>

	<script type="text/javascript" src="/resources/js/score.js"></script>	
<script>
		$(document).ready(function () {
			
			$("#th_target").attr('style', "display:none;");
			$("td:nth-child(2)").attr('style', "display:none;");
			showList_s(1);
			
			/* var sbnoValue = '<c:out value="${score.sbno}"/>'; */
		    
		    var modal_s = $("#sModal");
		    var modalInputSbno= modal_s.find("input[name='sbno']");
		    var modalInputTargetUser = modal_s.find("input[name='s_id']").attr("readonly", "readonly");
		    var modalInputWriter =  modal_s.find("input[name='m_id']").attr("readonly", "readonly");//계정정보에서 불러오기 처리할것, readonly처리할 것
		    var modalInputScore = modal_s.find("input[name='s_score']");
		    var modalInputComment= modal_s.find("input[name='s_comment']");
		    
		    var newBtn = $("#newBtn");
		    var modalModBtn = $("#modalModBtnS");
		    var modalRemoveBtn = $("#modalRemoveBtnS"); 
		    var modalRegisterBtn = $("#modalRegisterBtnS");
			var modalCloseBtn = $("#modalCloseBtnS");
		    
		    var sbnoValue;

		    
			//별점 관련 제이쿼리
			var scoreStar;
			
			$( ".star_rating a" ).click(function() {

			     $(this).parent().children("a").removeClass("onStar");

			     $(this).addClass("onStar").prevAll("a").addClass("onStar");

			   	 scoreStar = $(".onStar").length;//html에서 클래스가 'onStar'로 작성된 개체들의 개수를 반환한다.
			     			     
			   	 modal_s.find("input[name='starValue']").attr("value", scoreStar);
			   	 modal_s.find("input[name='s_score']").attr("value", scoreStar);
			   	 modalInputScore.val(scoreStar);
			     return false;
			});
		
			
		    
		  /*   var commentValue;
		    var scoreValue; */
		    $("#table_score").on("click", "tr", function (e) {

		    	var m_id = $(this).find("#m_id");
		    	var s_id = '${clicked_id}';		    		
		    		
		    	<sec:authentication property="principal" var="prin"/>
		        	var prinuser = '${prin.username}';
		    	
		        modalInputWriter.val(m_id.text());  //평가자 id       	        
		        modalInputTargetUser.val(s_id);//평가 대상 id
		        
		        if(prinuser!=m_id.text())
		        		{
		        			return 0;
		        		}
		        
		        var score = {
		        		s_id: modalInputTargetUser.val(),
		        		m_id: modalInputWriter.val()		        		
		        };
		        
		        
		        scoreService.get(score, function(result){
		        	
		        	var commentValue = result.s_comment;
		        	var scoreValue = result.s_score;
		        			   	
		        	
		        	<sec:authentication property="principal" var="prin"/>
		        	var prinuser = '${prin.username}';
		        	
		        	var writerValue = prinuser;//접속한 유저 id가 곧, 평가글 작성 유저 id
		        	sbnoValue = result.sbno;
		        	
		        	if(writerValue==s_id)//평가글 작성 유저id == 평가 대상 id 이면
		        	{
		        		alert("수정 권한이 없습니다.");
		        	}else{
		        		if(sbnoValue==null){
			        		modalInputScore.val("");
			        		modalInputComment.val("");
			        	}else{
			        		modalInputScore.val(scoreValue);
			        		modalInputComment.val(commentValue);
			        	}
			        	
			        	modalInputWriter.val(writerValue);
			        	modalInputSbno.val(sbnoValue).attr("readonly", "readonly");
			        	
			        	/*   m_id, s_id 데이터에 따른 글번호가 조회되면 modalRegisterBtn hide modalModBtn show
				        그렇지 않으면 modalRegisterBtn show modalModBtn hide */
			     	   if(sbnoValue==null)
			        	{
			     		modalRemoveBtn.hide();
			     		modalRegisterBtn.show();
			     		modalModBtn.hide(); 
			        	
			        	}else{
			        		modalRemoveBtn.show();
			        		modalRegisterBtn.hide(); 
			        		modalModBtn.show(); 
			        	
			        		
			        		modal_s.modal("show");
			        	}
		        	}
		        	
		        	//scoreValue에 대응하는 별점 출력
		            switch(parseInt(scoreValue))
					{
					 case 1:
						 
					 $("#star1").parent().children("a").removeClass("onStar");	 
					 $("#star1").addClass("onStar").prevAll("a").addClass("onStar");
					 break
					 
					 case 2:
					 $("#star2").parent().children("a").removeClass("onStar");	
					 $("#star2").addClass("onStar").prevAll("a").addClass("onStar");
					 break
					 
					 case 3:
						 
					 $("#star3").parent().children("a").removeClass("onStar");	
					 $("#star3").addClass("onStar").prevAll("a").addClass("onStar");
					 break
					 
					 case 4:
					 $("#star4").parent().children("a").removeClass("onStar");	
					 $("#star4").addClass("onStar").prevAll("a").addClass("onStar");
					 break
					 
					 case 5:
					 $("#star5").parent().children("a").removeClass("onStar");	
					 $("#star5").addClass("onStar").prevAll("a").addClass("onStar");
					 break
					} 
		        	 
		        })
		        
		  
		        
		    })
		    		 
		    //상단의 추가 버튼
		    newBtn.on("click", function(e){
		    	<sec:authentication property="principal" var="prin"/>
		        var prin_user = '${prin.username}';
		    	var c_user = '${clicked_id}';
		    			    	
				modalInputTargetUser.val(c_user);//평가 대상 id
		       	modalInputWriter.val(prin_user);//평가자 id(로그인중인 유저 id)          	        
		      
		        
		        var score = {
		        		s_id: modalInputTargetUser.val(),
		        		m_id: modalInputWriter.val()		        		
		        };
		        
		        
		        scoreService.get(score, function(result){
		        	
		        	var commentValue = result.s_comment;
		        	var scoreValue = result.s_score;
		        		        			        			        	
		        	var writerValue = prin_user;
		        	sbnoValue = result.sbno;
		        	
		        	
		        	if(sbnoValue==null){
		        		modalInputScore.val("");
		        		modalInputComment.val("");
		        		
		        		modalRegisterBtn.hide();
				    	
		        		//자신에게 셀프 평가하지 못하게
				    	if(prin_user!=c_user)
				    	{
				    		modalModBtn.hide();
				    		modalRemoveBtn.hide();
				     		modalRegisterBtn.show();
				     		 
				     		modalInputSbno.attr("readonly", "readonly");
				     						    
					    	modal_s.modal("show");
					    	
				    	}
				    	else
				    	{//평가 대상과 로그인 대상이 같을 때
				    		alert("자신은 평가할 수 없습니다.");
				    	}
				    	
		        	}else{
		        		//modalInputScore.val(scoreValue);
		        		modalInputScore.val(scoreStar);
		        		modalInputComment.val(commentValue);
		        		alert("이미 등록하셨습니다.");
		        	}
		        	
		        	modalInputWriter.val(writerValue);
		        	modalInputSbno.val(sbnoValue).attr("readonly", "readonly");
		        	})
		        		        	
		        	
		    })
	    /* 등록 버튼 및 모달 작성하기 */
		    modalRegisterBtn.on("click", function(e){		
		    	/* 0~5의 정수로만 평가 가능 */
		    	if(!(parseInt(modalInputScore.val())>0 && parseInt(modalInputScore.val())<=5)){//별점이 범위 밖일 때
		    		modalInputScore.val("");
		    		modalInputScore.attr("placeholder", "최소:1점~최대:5점");	
		    		
		    		if(modalInputComment.val()!="")
		    			{
		    			alert("평점을 클릭하여 입력해주세요 :)");
		    			}
		    		else{
		    			alert("입력한 값이 없습니다 :(");
		    		}
		    		
		    	}else if(modalInputComment.val()=="")//별점이 범위내 and 코멘트가 공백일때
		    	{
		    		alert("코멘트를 입력하세요");	
		    	}else{//별점이 범위내 and 코멘트가 공백이 아닐때
		    		<sec:authentication property="principal" var="prin"/>
			        	var prinuser = '${prin.username}';
			        	
		    		var score = {
			    			m_id: prinuser,
			    			s_id: '${clicked_id}',
			    			s_score: modalInputScore.val(),
			    			s_comment: modalInputComment.val()
			    	};
		    	
		    		scoreService.add(score, function(result){
		    			modalInputScore.val("");
			    		modalInputScore.attr("placeholder", "최소:1점~최대:5점");	
			    	
			    		showList_s(-1);
			    	})
			    	
		    	}
		    			    	
		    	modal_s.modal("hide");
		    })
		    
		    //수정버튼
		    modalModBtn.on("click", function(e){
		      	/* 0~5의 정수로만 평가 가능 */
		    	if(!(parseInt(modalInputScore.val())>0 && parseInt(modalInputScore.val())<=5)){//별점이 범위 밖일 때
		    		modalInputScore.val("");
		    		modalInputScore.attr("placeholder", "최소:1점~최대:5점");	
		    		
		    		if(modalInputComment.val()!="")
		    			{
		    			alert("평점을 클릭하여 입력해주세요 :)");
		    			}
		    		else{
		    			alert("입력한 값이 없습니다 :(");
		    		}
		    		
		    	}else if(modalInputComment.val()=="")//별점이 범위내 and 코멘트가 공백일때
		    	{
		    		alert("코멘트를 입력하세요");	
		    	}else{//별점이 범위내 and 코멘트가 공백이 아닐때
		    		var score = {
		    				s_score: modalInputScore.val(),
			    			s_comment: modalInputComment.val(),
			    			sbno: modalInputSbno.val()
			    	};
		    	
		    		scoreService.update(score, function(result){
		    			modal_s.modal("hide");
		    			showList_s(pageNum1);
			    	})
			    	
		    	}
		    })
		    
		    //삭제 버튼
		    modalRemoveBtn.on("click", function(e){
		    	
		    	var sbno = sbnoValue;
		    	
		    	scoreService.remove(sbno, function(result){
		    		
		    		alert("정상적으로 삭제됐습니다 :)");
		    		
		    		modalRegisterBtn.show();
		    		modalModBtn.hide();
		    		modalRemoveBtn.hide();
		    		modal_s.find("input").val("");
		    		modal_s.modal("hide");	
		    		
		    		showList_s(pageNum1);
		    	})
		    	
		    })
		    
		    modalCloseBtn.on("click", function(e){
		    	
		    	modal_s.modal("hide");
		    })		    
		})
	</script>
	
	
	<script>
		var pageNum1=1;
		var scorePageFooter = $(".panel-footer");
		
		function showScorePage(scoreCnt){
			
			var endNum = Math.ceil(pageNum1/10.0)*10;
			var startNum = endNum - 9;
			
			var prev = startNum !=1;
			var next = false;
			
			if(endNum * 5 >=scoreCnt){
				endNum = Math.ceil(scoreCnt/5.0);
			}
			
			if(endNum * 5 <scoreCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link btn btn-primary' href="+(startNum-1)+">Previous</a></li>";
			}
			
			
			for(var i = startNum; i<= endNum; i++){
				
				var active = pageNum1 ==i? "active":"";
				
				str+= "<li class='page-item "+active+" '><a class='page-link btn btn-primary' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str	+= "<li class='page-item'><a class='page-link btn btn-primary' href="+(endNum+1)+">Next</a></li>";
			}
			
			str += "</ul></div>";
			
			scorePageFooter.html(str);
		}
	</script>
	<!---------- ./댓글 페이지 번호 출력 로직  -->
	<script>
		scorePageFooter.on("click", "li a", function(e){
			e.preventDefault();
			var targetPageNum_s = $(this).attr("href");
			
			
			pageNum1 = targetPageNum_s;
			
			showList_s(pageNum1);
		})
	</script>

	
	<script>
	
	/* <sec:authentication property="principal" var="prin"/>
		   var prinuser = '${prin.username}'; */
		   
		   var targetUser = '${clicked_id}';
	
	function showList_s(page){
		scoreService.getList({s_id:targetUser, page: page||1},
				function(scoreCnt, list){
			
			if(page == -1){
				pageNum1 = Math.ceil(scoreCnt/5.0);
				showList_s(pageNum1);
				return;				
			}
			
			var str="";
			str+= '	<thead style="text-align:center;">';
			str+= '	<tr><th id="th_target2" style="display:none">평가자ID</th>';
			str+= '	<th width="200" style="display:none">평가대상ID</th>';
			str+= '	<th width="550">코멘트</th>';
			str+= '	<th width=100>평점</th>';
			str+= '	<th width="150">작성일</th>';
			str+= '	</thead>';
			
			if(list==null || list.length == 0){
				return;
			}
			
			for(var i = 0, len = list.length || 0; i<len; i++){	
				
				str +='<tr class="tr_1">';
				str +="	<td id='m_id' style='display:none'>"+list[i].m_id+"</td>";
				str +="	<td id='s_id' style='display:none'>"+list[i].s_id+"</td>";
				str +="	<td id='s_comment'>"+list[i].s_comment+"</td>";
				str +="	<td id='s_score' style='text-align:center;'>"+list[i].s_score+"</td>";
				str +="	<td id='s_date' style='text-align:center;'>"+scoreService.displayTime(list[i].s_date)+"</td>";
				str +='	</tr>'
			}
			
			$("#table_score").html(str);	
			showScorePage(scoreCnt);
			
		})
	}
	</script>
<%@include file="../includes/footerChat.jsp" %>