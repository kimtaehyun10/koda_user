function NextMove(next_page) {
	//var id = next_page.substring(next_page.indexOf(".htm") - 2, next_page.indexOf(".htm"));
	//go('I' + id);
	location.href = next_page;  // 과정개발시 사용
}
function notice(){
window.open("down/01 윤리준법 환경의 이해(요약).pdf");
}

	/**
	 * Time 스트링을 자바스크립트 Date 객체로 변환
	 * parameter time: Time 형식의 String
	 */
	function toTimeObject(time) { //parseTime(time)
		var year  = time.substr(0,4);
		var month = time.substr(4,2) - 1; // 1월=0,12월=11
		var day   = time.substr(6,2);
		var hour  = time.substr(8,2);
		var min   = time.substr(10,2);

		return new Date(year,month,day,hour,min);
	}


	/**
	 * 자바스크립트 Date 객체를 Time 스트링으로 변환
	 * parameter date: JavaScript Date Object
	 */
	function toTimeString(date) { //formatTime(date)
		var year  = date.getFullYear();
		var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
		var day   = date.getDate();
		var hour  = date.getHours();
		var min   = date.getMinutes();

		if (("" + month).length == 1) { month = "0" + month; }
		if (("" + day).length   == 1) { day   = "0" + day;   }
		if (("" + hour).length  == 1) { hour  = "0" + hour;  }
		if (("" + min).length   == 1) { min   = "0" + min;   }

		return ("" + year + month + day + hour + min)
	}

	
	// 페이지 모드를 넘겨줍니다.
	function getPageMode(){
		var pageMode = '';
		if( top.mode == undefined ){
			pageMode = '';
		}else if( top.mode == 'preview' || top.mode == 'lecture' ){
			pageMode = top.mode;
		}
		return pageMode;
	}


	// 페이지 접근 유효성 체크
	function isAuthenticatedURL() {
		return ( getPageMode() != '' );
	}

	// 실제 강의인지 확인
	function isRealLecture() {
		return ( getPageMode() == 'lecture' );		
	}


	// iframe에 form tag를 삽입하기 위한 함수
	function on_navi(){
		// alert( "top.mode : " + getPageMode() );
	}
	
	// 진도페이지에 진입시 호출되는 함수
	function on_chkpage( key ){
		
		if(top.sRestudyYN=='Y'){
			//재학습일경우 진도체크 안함
		}else{
			// 페이지 접근이 잘못 되었을 경우
			//if( !isAuthenticatedURL() ){
			//	top.location.href = '/lms/classes/lecture/blank.jsp';
			//}
			
			// 실제 강의 진행인 경우 진도 체크함
			if( isRealLecture() ){
				top.item_id = key;
				top.start_time = toTimeString( new Date() );
			}
		}

	}


	// 진도페이지에서 학습 완료시 호출되는 함수
	// 진도페이지가 단일 페이지로 구성된 경우 onUnload일때 호출
	function on_savepage( key ){

		if(top.sRestudyYN=='Y'){
					//재학습일경우 진도체크 안함
		}else{
			// 페이지 접근이 잘못 되었을 경우
			//if( !isAuthenticatedURL() ){
			//	top.location.href = '/lms/classes/lecture/blank.jsp';
			//}
			
			// 실제 강의 진행인 경우 진도 체크함
			if( isRealLecture() ){
				var start_time = toTimeObject( top.start_time );
				var contentpoolno = top.contentpoolno;
				var end_time = new Date();
				var attend_time = 0;
				try{
					attend_time = parseInt( (end_time - start_time) / ( 60 * 1004 ) );
				}catch(e){ 
					//alert(e); 
				}
				if( attend_time <= 0 ){
					attend_time = 0;
				}
				
				//alert("attend_time : "+attend_time + ", attend_type : "+ top.attend_type);
				
				if( top.attend_type == '1' ){
					var url = "/ehrd/lms/classes/attend/type1?item_id="+key
					url += "&attend_time="+attend_time;
					url += "&contentpoolno="+contentpoolno;
					top.ct_blankFrame.location = url;			
				}
	
				else if( top.attend_type == '2' ){
					var url = "/ehrd/lms/classes/attend/type2"
					url += "?contentpoolno="+contentpoolno;
					//url += "&attend_time="+attend_time;				
					top.ct_blankFrame.location = url;			
				}
			}//if
		}//else
		
	}


	var num_ = "";
	var contents_ = "";
    function on_opinion_input(num,contents){		//의견나누기 입력
		if( isRealLecture() ){
			top.ct_blankFrame.location.href = "/lms/classes/lecture/nscorm/blank.jsp";
			num_ = num;
			contents_ = contents;
			setTimeout("on_opinion_input_real()", 1004);
		}
		return;
	}
	
	function on_opinion_input_real(){
	
		if( top.ct_blankFrame != undefined && top.ct_blankFrame.cfrmopinion != undefined ){
			var url = "/ehrd/lms/classes/content/board_w"
			var w = 728;
			var h = 500;
			LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
			TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
			settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars=yes,resizable=yes';
			window.open("","opinion",settings)
			
			top.ct_blankFrame.cfrmopinion.creator         = self;
			top.ct_blankFrame.cfrmopinion.partcd.value     = num_;
			//alert(document.form2.p_num.value);
			top.ct_blankFrame.cfrmopinion.opinion.value = contents_;
			top.ct_blankFrame.cfrmopinion.target          = 'opinion' ;
			top.ct_blankFrame.cfrmopinion.action          = url ;
			top.ct_blankFrame.cfrmopinion.submit();
		}else{
			alert( '입력 실패.' );
		}
		
	}



	function on_opinion_list(num){				//의견나누기 리스트
		
		if( isRealLecture() ){
			var url = "/ehrd/lms/classes/content/board?partcd="+num
			var w = 728;
			var h = 500;
			LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
			TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
			settings = 'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars=yes,resizable=yes';
			window.open(url,"opinion",settings)
			
			//top.ct_blankFrame.cfrmopinion.creator       = self;
			//top.ct_blankFrame.cfrmopinion.p_num.value   = num;
			//top.ct_blankFrame.cfrmopinion.target        = 'opinion' ;
			//top.ct_blankFrame.cfrmopinion.action        = url ;
			//top.ct_blankFrame.cfrmopinion.submit();
		}
		return;
	}

	// shockwave용 on_chk() 함수
	function on_chk(){
		on_chkpage( 'key' );
	}

	// shockwave용 on_chk() 함수
	function on_chk(value1, value2){
		on_chkpage( 'key' );
	}

	// shockwave용 on_save() 함수	
	function on_save(){
		on_savepage( 'key' );
	}

	// shockwave용 on_save() 함수	
	function on_save(value1, value2){
		on_savepage( 'key' );
	}


	// 강의실 팝업창
	// 진도, 성적
	function openProgResult(){
		try{
			top.opener.top.frmMenu.openProgResult();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

	// 질문방
	function openQNA(){
		try{
			top.opener.top.frmMenu.openQNA();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

	// 자료방
	function openPDS(){
		try{
			top.opener.top.frmMenu.openPDS();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

	// 시험방
	function openTest(){
		try{
			top.opener.top.frmMenu.openTest();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

	//  과제방
	function openHomework(){
		try{
			top.opener.top.frmMenu.openHomework();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

	// 토론방
	function openDiscuss(){
		try{
			top.opener.top.frmMenu.openDiscuss();
		}catch(e){alert('유효한 경로가 아닙니다.');}
	}

