console.log("score Module.........");

var scoreService = (function(){

	console.log("score service...........");
	function add(score, callback, error){
		console.log("add score.......");

		$.ajax({
			type : 'post',//데이터를 전송할 방식 post
			url : '/score/new',//데이터를 전송할 페이지
			data : JSON.stringify(score),//서버로 전송할 데이터
			contentType : "application/json; charset=utf-8",//서버로 전송할 데이터의 content-type(json형태)
			success : function(result, status, xhr){//Ajax로 통신이 정상적으로 이뤄지면 이벤트 핸들러 실행
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){//통신에 문제가 발생했을 때 함수를 실행
				if(error){
					error(er);
				}
			}
		});
	}
	
	function getList_m(param, callback, error){

		var m_id = param.m_id;
		var page = param.page || 1;

		$.getJSON("/score/pages/myEval/" + m_id + "/"+page+".json",
			function(data){
				if(callback){
					// callback(data);
					callback(data.scoreCnt, data.list);
				}
			}).fail(function(xhr, status, err){//getJSON메서드 체인
			if(error){
				error();
			}
		});//getJSON함수 호출
	}//getList함수 정의	////////////////////////////추가

	function getList(param, callback, error){

		var s_id = param.s_id;
		var page = param.page || 1;

		$.getJSON("/score/pages/" + s_id + "/"+page+".json",
			function(data){
				if(callback){
					// callback(data);
					callback(data.scoreCnt, data.list);
				}
			}).fail(function(xhr, status, err){//getJSON메서드 체인
			if(error){
				error();
			}
		});//getJSON함수 호출
	}//getList함수 정의	////////////////////////////추가

	function remove(sbno, callback, error){
		$.ajax({
			type: 'delete',//데이터 전달 타입이 DELETE 방식이므로 url입력으로 처리 불가능. 크롬 확장 프로그램 사용할 것
			url : '/score/' +sbno,
			success : function(deleteResult, status, xhr){				
				if(callback){
					callback(deleteResult);
				}location.reload();
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});//aJax함수 호출
	}//remove함수 정의

	function update(score, callback, error){
		console.log("sbno: " + score.sbno);

		$.ajax({
			type: 'put',//데이터 전달 타입이 PUT 방식이므로 url입력으로 처리 불가능. 크롬 확장 프로그램 사용할 것
			url: '/score/'+score.sbno,
			data: JSON.stringify(score),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}location.reload();
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}

	function get(score, callback, error) {
		
		$.get("/score/"+score.s_id+"/"+score.m_id+".json", function(result){

			if(callback){
				callback(result);
			}
			
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	};//함수 get() 정의

	// function get(score, callback, error){
	// 	$.ajax({
	// 		type: 'get',
	// 		url : "/score/"+score.s_id+"/"+score.m_id+".json",
	// 		success : function(result, status, xhr){
	// 			if(callback){
	// 				callback(result);
	// 			}location.reload();
	// 		},
	// 		error : function(xhr, status, er){
	// 			if(error){
	// 				error(er);
	// 			}
	// 	});//aJax함수 호출
	// }//get 정의

	function displayTime(timeValue){

		var today = new Date();
		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);
		var str = "";

		if(gap < (1000*60*60*24)){//timeValue의 시간값과 getTime()함수로 불러온 시간값이 24시간 보다 작을 때

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh>9 ? '' : '0') +hh, ':', (mi>9 ? '' : '0') + mi,
				':', (ss>9 ? '' : '0') +ss ].join('');	
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();

			return [yy, '-',(mm>9 ? '' : '0')+ mm, '-',
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
			

	// 	return [yy, '-',(mm>9 ? '' : '0')+ mm, '-', (dd>9 ? '' : '0') + dd, 
	// 		(hh>9 ? '' : '0') +hh, ':', (mi>9 ? '' : '0') + mi,	':', (ss>9 ? '' : '0') +ss ].join('');	
	
	// };

	return {
		add:add,
		remove:remove,
		update:update,
		get:get,
		getList:getList,
		getList_m:getList_m,
		displayTime:displayTime
	};

})();//즉시실행함수