function NextMove(next_page) {
	//var id = next_page.substring(next_page.indexOf(".htm") - 2, next_page.indexOf(".htm"));
	//go('I' + id);
	location.href = next_page;  // �������߽� ���
}
function notice(){
window.open("down/01 �����ع� ȯ���� ����(���).pdf");
}

	/**
	 * Time ��Ʈ���� �ڹٽ�ũ��Ʈ Date ��ü�� ��ȯ
	 * parameter time: Time ������ String
	 */
	function toTimeObject(time) { //parseTime(time)
		var year  = time.substr(0,4);
		var month = time.substr(4,2) - 1; // 1��=0,12��=11
		var day   = time.substr(6,2);
		var hour  = time.substr(8,2);
		var min   = time.substr(10,2);

		return new Date(year,month,day,hour,min);
	}


	/**
	 * �ڹٽ�ũ��Ʈ Date ��ü�� Time ��Ʈ������ ��ȯ
	 * parameter date: JavaScript Date Object
	 */
	function toTimeString(date) { //formatTime(date)
		var year  = date.getFullYear();
		var month = date.getMonth() + 1; // 1��=0,12��=11�̹Ƿ� 1 ����
		var day   = date.getDate();
		var hour  = date.getHours();
		var min   = date.getMinutes();

		if (("" + month).length == 1) { month = "0" + month; }
		if (("" + day).length   == 1) { day   = "0" + day;   }
		if (("" + hour).length  == 1) { hour  = "0" + hour;  }
		if (("" + min).length   == 1) { min   = "0" + min;   }

		return ("" + year + month + day + hour + min)
	}

	
	// ������ ��带 �Ѱ��ݴϴ�.
	function getPageMode(){
		var pageMode = '';
		if( top.mode == undefined ){
			pageMode = '';
		}else if( top.mode == 'preview' || top.mode == 'lecture' ){
			pageMode = top.mode;
		}
		return pageMode;
	}


	// ������ ���� ��ȿ�� üũ
	function isAuthenticatedURL() {
		return ( getPageMode() != '' );
	}

	// ���� �������� Ȯ��
	function isRealLecture() {
		return ( getPageMode() == 'lecture' );		
	}


	// iframe�� form tag�� �����ϱ� ���� �Լ�
	function on_navi(){
		// alert( "top.mode : " + getPageMode() );
	}
	
	// ������������ ���Խ� ȣ��Ǵ� �Լ�
	function on_chkpage( key ){
		
		if(top.sRestudyYN=='Y'){
			//���н��ϰ�� ����üũ ����
		}else{
			// ������ ������ �߸� �Ǿ��� ���
			//if( !isAuthenticatedURL() ){
			//	top.location.href = '/lms/classes/lecture/blank.jsp';
			//}
			
			// ���� ���� ������ ��� ���� üũ��
			if( isRealLecture() ){
				top.item_id = key;
				top.start_time = toTimeString( new Date() );
			}
		}

	}


	// �������������� �н� �Ϸ�� ȣ��Ǵ� �Լ�
	// ������������ ���� �������� ������ ��� onUnload�϶� ȣ��
	function on_savepage( key ){

		if(top.sRestudyYN=='Y'){
					//���н��ϰ�� ����üũ ����
		}else{
			// ������ ������ �߸� �Ǿ��� ���
			//if( !isAuthenticatedURL() ){
			//	top.location.href = '/lms/classes/lecture/blank.jsp';
			//}
			
			// ���� ���� ������ ��� ���� üũ��
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
    function on_opinion_input(num,contents){		//�ǰ߳����� �Է�
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
			alert( '�Է� ����.' );
		}
		
	}



	function on_opinion_list(num){				//�ǰ߳����� ����Ʈ
		
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

	// shockwave�� on_chk() �Լ�
	function on_chk(){
		on_chkpage( 'key' );
	}

	// shockwave�� on_chk() �Լ�
	function on_chk(value1, value2){
		on_chkpage( 'key' );
	}

	// shockwave�� on_save() �Լ�	
	function on_save(){
		on_savepage( 'key' );
	}

	// shockwave�� on_save() �Լ�	
	function on_save(value1, value2){
		on_savepage( 'key' );
	}


	// ���ǽ� �˾�â
	// ����, ����
	function openProgResult(){
		try{
			top.opener.top.frmMenu.openProgResult();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

	// ������
	function openQNA(){
		try{
			top.opener.top.frmMenu.openQNA();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

	// �ڷ��
	function openPDS(){
		try{
			top.opener.top.frmMenu.openPDS();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

	// �����
	function openTest(){
		try{
			top.opener.top.frmMenu.openTest();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

	//  ������
	function openHomework(){
		try{
			top.opener.top.frmMenu.openHomework();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

	// ��й�
	function openDiscuss(){
		try{
			top.opener.top.frmMenu.openDiscuss();
		}catch(e){alert('��ȿ�� ��ΰ� �ƴմϴ�.');}
	}

