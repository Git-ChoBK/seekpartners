
var replyService = (function(){
	
	function add(reply, callback, error){
		

		$.ajax({
			type : 'post',//데이터를 전송할 방식 post
			url : '/replies/new',//데이터를 전송할 페이지
			data : JSON.stringify(reply),//서버로 전송할 데이터
			contentType : "application/json; charset=utf-8",//서버로 전송할 데이터의 content-type(json형태)
			success : function(result, status, xhr){//Ajax로 통신이 정상적으로 이뤄지면 이벤트 핸들러 실행
				if(callback){
					callback(result);
				}

				if(socket) {
					//웹소켓에 보내기 (reply, 댓글 작성자, 게시글 작성자, 글 번호);
					var socketMsg = "reply," + reply.m_id + "," + reply.gboardwriter + "," + reply.pbno;
					socket.send(socketMsg);
				}
			},
			error : function(xhr, status, er){//통신에 문제가 발생했을 때 함수를 실행
				if(error){
					error(er);
				}
			}
		});
	}
	
	function getList(param, callback, error){

		var pbno = param.pbno;
		var page = param.page || 1;//

		$.getJSON("/replies/pages/" + pbno + "/" + page + ".json",
			function(data){
				if(callback){
					// callback(data);
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr, status, err){//getJSON메서드 체인
			if(error){
				error();
			}
		});//getJSON함수 호출
	}//getList함수 정의	

	function remove(prno, replyer, callback, error){
		$.ajax({
			type: 'delete',//데이터 전달 타입이 DELETE 방식이므로 url입력으로 처리 불가능. 크롬 확장 프로그램 사용할 것
			data: JSON.stringify({prno:prno, m_id:replyer}),
			contentType: "application/json; charset=utf-8",
			url : '/replies/' +prno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					console.log(error);
					error(er);
				}
			}
		});//aJax함수 호출
	}//remove함수 정의

	function update(reply, callback, error){
		console.log("prno: " + reply.prno);

		$.ajax({
			type: 'put',//데이터 전달 타입이 PUT 방식이므로 url입력으로 처리 불가능. 크롬 확장 프로그램 사용할 것
			url: '/replies/'+reply.prno,
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}

	function get(prno, callback, error) {
		
		$.get("/replies/" +prno +".json", function(result){

			if(callback){
				callback(result);
			}
			
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	};//함수 get() 정의
	// 첫번째 인수 prno가 포함된 url에 HTTP 요청이 성공적으로 보내졌을때
	// 두번째 인수 callback에 아무런 값도 들어오지 않으면 if(callback)에서 반환값은 false
	// 반면, 어떠한 값이라도 들어오면 내부 반환값은 true


	function displayTime(timeValue){

		var today = new Date();
		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if(gap < (1000*60*60*24)){

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh>9 ? '' : '0') +hh, ':', (mi>9 ? '' : '0') + mi,
				':', (ss>9 ? '' : '0') +ss ].join('');	
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();

			return [yy, '/',(mm>9 ? '' : '0')+ mm, '/',
				(dd>9 ? '' : '0') + dd].join('');
		}
	};

	// function displayTime(timeValue){

	// 	var today = new Date();
	// 	var gap = today.getTime() - timeValue;

	// 	var dateObj = new Date(timeValue);
	// 	var str = "";

	// 	var yy = dateObj.getFullYear();
	// 	var mm = dateObj.getMonth() + 1;
	// 	var dd = dateObj.getDate();

	// 	var hh = dateObj.getHours();
	// 	var mi = dateObj.getMinutes();
	// 	var ss = dateObj.getSeconds();
			

	// 	return [yy, '-',(mm>9 ? '' : '0')+ mm, '-', (dd>9 ? '' : '0') + dd, ' ',
	// 		(hh>9 ? '' : '0') +hh, ':', (mi>9 ? '' : '0') + mi,	':', (ss>9 ? '' : '0') +ss ].join('');	
	
	// };

	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
	};

})();//즉시실행함수