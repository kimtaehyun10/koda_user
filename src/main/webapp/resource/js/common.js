// 쿠키생성
function set_cookie(name, value, expirehours, domain){
	var today	= new Date();
	today.setTime(today.getTime() + (60*60*1000*expirehours));
	document.cookie	= name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';';
	if(domain != '') document.cookie += 'domain=' + domain + ';';
}
// 쿠키값얻기
function get_cookie(name){
	var is_find	= false;
	var loops, loope;

	for(var k1=0; k1<=document.cookie.length; k1++){
		loops	= k1;
		loope	= loops + name.length;
		if(document.cookie.substring(loops, loope) == name){
			is_find	= true
			break
		}
	}

	if(is_find == true){
		loops	= loope + 1;
		loope	= document.cookie.indexOf(';', loops);
		if(loope < loops) loope	= document.cookie.length;
		return unescape(document.cookie.substring(loops, loope));
	}
	return '';
}
// 쿠키삭제
function de_cookie(name){
	var today	= new Date();
	today.setTime(today.getTime() - 1);
	var value	= get_cookie(name);
	if(value != '') document.cookie	= name + '=' + value + '; path=/; expires=' + today.toGMTString();
}
// daum우편번호검색
function win_zip(frm_name, frm_zip, frm_addr1, frm_addr2){
	if(typeof daum === 'undefined'){
		alert('다음 우편번호 postcode.v2.js 파일이 로드되지 않았습니다.');
		return false;
	}

	var zip_case	= 1;   // 0이면 레이어, 1이면 페이지에 끼워 넣기, 2이면 새창

	function complete_fn(data){
		// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		var fullAddr	= ''; // 최종 주소 변수
		var extraAddr	= ''; // 조합형 주소 변수

		// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		if(data.userSelectedType === 'R'){ // 사용자가 도로명 주소를 선택했을 경우
			fullAddr	= data.roadAddress;

		}
		else{ // 사용자가 지번 주소를 선택했을 경우(J)
			fullAddr	= data.jibunAddress;
		}

		// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		if(data.userSelectedType === 'R'){
			//법정동명이 있을 경우 추가한다.
			if(data.bname !== ''){
				extraAddr	+= data.bname;
			}
			// 건물명이 있을 경우 추가한다.
			if(data.buildingName !== ''){
				extraAddr	+= (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
			extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		}

		// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
		var of	= document[frm_name];

		of[frm_zip].value	= data.zonecode;
        of[frm_addr1].value	= fullAddr;

		of[frm_addr2].focus();
	};

	switch(zip_case){
		case 1 :	// iframe을 이용하여 페이지에 끼워 넣기
			var daum_pape_id	= 'daum_juso_page'+frm_zip;
			var element_wrap	= document.getElementById(daum_pape_id);
			var currentScroll	= Math.max(document.body.scrollTop, document.documentElement.scrollTop);

			if(element_wrap == null){
				element_wrap	= document.createElement('div');
				element_wrap.setAttribute('id', daum_pape_id);
				element_wrap.style.cssText	= 'display:none;border:1px solid;left:0;width:100%;height:300px;margin:5px 0;position:relative;-webkit-overflow-scrolling:touch;';
				element_wrap.innerHTML	= "<img src='//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png' id='btnFoldWrap' style='cursor:pointer;position:absolute;right:0px;top:-21px;z-index:1' class='close_daum_juso' alt='접기 버튼'>";
				jQuery('form[name="'+frm_name+'"]').find('input[name="'+frm_addr1+'"]').before(element_wrap);
				jQuery('#'+daum_pape_id).off('click', '.close_daum_juso').on('click', '.close_daum_juso', function(e){
					e.preventDefault();
					jQuery(this).parent().hide();
				});
			}

			new daum.Postcode({
				oncomplete: function(data){
					complete_fn(data);
					// iframe을 넣은 element를 안보이게 한다.
					element_wrap.style.display	= 'none';
					// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
					document.body.scrollTop	= currentScroll;
				},
				// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분.
				// iframe을 넣은 element의 높이값을 조정한다.
				onresize : function(size){
					element_wrap.style.height	= size.height + 'px';
				},
				width	: '100%',
				height	: '100%'
			}).embed(element_wrap);

			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display	= 'block';
			break;
		case 2 :	// 새창으로 띄우기
			new daum.Postcode({
				oncomplete: function(data){
					complete_fn(data);
				}
			}).open();
			break;
		default :   //iframe을 이용하여 레이어 띄우기
			var rayer_id = 'daum_juso_rayer'+frm_zip;
			var element_layer = document.getElementById(rayer_id);

			if(element_layer == null){
				element_layer	= document.createElement('div');
				element_layer.setAttribute('id', rayer_id);
				element_layer.style.cssText	= 'display:none;border:5px solid;position:fixed;width:300px;height:460px;left:50%;margin-left:-155px;top:50%;margin-top:-235px;overflow:hidden;-webkit-overflow-scrolling:touch;z-index:10000';
				element_layer.innerHTML	= "<img src='//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png' id='btnCloseLayer' style='cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1' class='close_daum_juso' alt='닫기 버튼'>";
				document.body.appendChild(element_layer);
				jQuery('#'+rayer_id).off('click', '.close_daum_juso').on('click', '.close_daum_juso', function(e){
					e.preventDefault();
					jQuery(this).parent().hide();
				});
			}

			new daum.Postcode({
				oncomplete: function(data){
					complete_fn(data);
					// iframe을 넣은 element를 안보이게 한다.
					element_layer.style.display	= 'none';
				},
				width	: '100%',
				height	: '100%'
			}).embed(element_layer);

			// iframe을 넣은 element를 보이게 한다.
			element_layer.style.display	= 'block';
	}
}
// 양수 ex) onblur='onlyNum(this)'
function onlyNum(obj){
	obj.value	= obj.value.replace(/\D/g, '');
}
// 양수도트 ex) onblur='onlyNumDot(this)'
function onlyNumDot(obj){
	obj.value	= obj.value.replace(/[^0-9\.]/g, '');
}
// 양수하이픈 ex) onblur='onlyNumHyphen(this)'
function onlyNumHyphen(obj){
	obj.value	= obj.value.replace(/[^0-9\-]/g, '').replace(/(\--)/g, '-');
}
// 양수콤마 ex) onblur='onlyNumCom(this)'
function onlyNumCom(obj){
	obj.value	= obj.value.replace(/[^0-9\,]/g, '');
}
// 양수하이픈콤마 ex) onblur='onlyNumHyCom(this)'
function onlyNumHyCom(obj){
	obj.value	= obj.value.replace(/[^0-9\-\,]/g, '');
}
// 양수하이픈콤마스페이스 ex) onblur='onlyNumHyComSp(this)'
function onlyNumHyComSp(obj){
	obj.value	= obj.value.replace(/[^0-9\-\,\s]/g, '');
}
// 엔터및공백제거(obj:객체, rstr:치환될문자) ex) <textarea name='content' onblur="noEnterRtn(this, '');"></textarea>
function noEnterRtn(obj, rstr){
	obj.value	= obj.value.replace(/\s/g, rstr);
}
// 목록에서서브밋시선택된항목이있는지검사하기
function chk_list(frm, cbox){

	if(!cbox) cbox	= 'cbox';
	var obj	= frm[cbox+'[]'];

	if(!obj){
		alert('선택된 항목이 없습니다.');
		return false;
	}

	var len	= obj.length;
	var chk	= 0;

	if(len){
		for(var k1=0; k1<len; k1++){
			if(obj[k1].checked){
				chk++;
				break;
			}
		}
	}
	else{
		if(obj.checked){
			chk++;
		}
	}

	if(!chk){
		alert('선택된 항목이 없습니다.');
		return false;
	}
	return true;
}
// 목록에서체크박스일괄선택해제
function ac_cbox(frm, bool, cbox){
	if(!cbox) cbox	= 'cbox';
	var obj	= frm[cbox+'[]'];

	if(obj){
		var len	= obj.length;

		if(len){
			for(var k1=0; k1<len; k1++){
				obj[k1].checked	= bool;
			}
		}
		else{
			obj.checked	= bool;
		}
	}
}
// 파일의 확장자를 리턴
function getFileExtension(filePath){
	var lidx	= filePath.lastIndexOf('.');
	var extv	= '';
	if(lidx != -1){
		extv	= filePath.substring( lidx+1, filePath.len );
	}
	return extv;
}
// 새창열기
function fn_wopen(url, w_name, pars, wid, hei, stat, scr, resi, px, py){
	if(pars) url = url + '?' + pars;
	var mw	= screen.availWidth		? parseInt(screen.availWidth)	: (window.innerWidth	? parseInt(window.innerWidth)	: parseInt(document.body.clientWidth));
	var mh	= screen.availHeight	? parseInt(screen.availHeight)	: (window.innerHeight	? parseInt(window.innerHeight)	: parseInt(document.body.clientHeight));
	if(!wid) wid	= mw;
	if(!hei) hei	= mh;
	var pl	= px ? px : parseInt(mw - wid) / 2;
	var pt	= py ? py : parseInt(mh - hei) / 2;
	var at	= 'toolbar=no, location=no, directories=no, status='+stat+', menubar=no, scrollbars='+scr+', resizable='+resi;
	var at	= at + ', width='+wid+', height='+hei+', left='+pl+', top='+pt;
	var nw	= window.open(url, w_name, at);
	if(!nw){
		alert('팝업 차단을 허용해주세요.');
		return;
	}
	else nw.focus();
}
// 새창
function new_win1(url, w_name, pars, wid, hei){
	fn_wopen(url, w_name, pars, wid, hei, 'no', 'no', 'no', 0, 0);
}
// 새창
function new_win2(url, w_name, pars, wid, hei){
	fn_wopen(url, w_name, pars, wid, hei, 'no', 'yes', 'no', 0, 0);
}
// 새창
function new_win3(url, w_name, pars, wid, hei){
	fn_wopen(url, w_name, pars, wid, hei, 'no', 'yes', 'yes', 0, 0);
}
// 새창
function new_win4(url, w_name, pars, wid, hei){
	fn_wopen(url, w_name, pars, wid, hei, 'yes', 'yes', 'no', 0, 0);
}
// 새창
function new_win5(url, w_name, pars, wid, hei){
	fn_wopen(url, w_name, pars, wid, hei, 'yes', 'yes', 'yes', 0, 0);
}
// byte바이트수
function chkByte(str){
	var len	= str.length;	// 전체길이

	// 변수초기화
	var bsz	= 0;	// 바이트크기
	var ch1	= '';	// char단위추출용

	for(var k1=0; k1<len; k1++){
		// 한글자추출
		ch1 = str.charAt(k1);
		if(escape(ch1).length > 4) bsz	+= 2;	// 한글
		else bsz++;	// 그외
	}
	return bsz;
}
// byte바이트수허용치만남기기
function chkByteMax(obj, maxlen, is_utf8){
	var str	= obj.value;
	var len = str.length;	// 전체길이

	// 변수초기화
	var bsz	= 0;	// 바이트크기
	var ch1	= '';	// char단위추출용
	var tsz	= 0;

	for(var k1=0; k1<len; k1++){
		if(is_utf8){
			// 한글자추출
			ch1 = str.charAt(k1);
			if(escape(ch1).length > 4) bsz	+= 2;	// 한글
			else bsz++;	// 그외
		}
		else bsz++;

		if(bsz <= maxlen){	// 전체 크기가 maxlen를 넘지않으면
			tsz = k1 + 1;
		}
	}
	// 총바이트수가 허용된 문자열의 최대값을 초과하면
	if(bsz > maxlen){
		obj.value	= str.substr(0, tsz);
		bsz	= maxlen;
	}
	return bsz;
}
// byte바이트수 리턴해서 documentgetElementById 로 메시지를 리턴함
// <input type='text' name='send_msg' size='80' class='inputbox_01' onblur="chkByteNum(this, 80, 'this_msg_byte');"/>
// <span id='this_msg_byte'>0 Byte</span>
function chkByteNum(obj, maxlen, tar_id){
	var objstr	= obj.value;		// 입력된 문자열을 담을 변수
	var objlen	= objstr.length;	// 전체길이

	// 변수초기화
	var bytesize	= 0;	// 바이트크기
	var onechar		= '';	// char단위로 추출시 필요한 변수
	var strlen		= 0;	// 입력된 문자열의 크기

	// 입력된 문자열의 총바이트수 구하기
	for(var k1=0; k1<objlen; k1++){
		// 한글자추출
		onechar	= objstr.charAt(k1);
		if(escape(onechar).length > 4){
			bytesize += 2;		  // 한글이면 2를 더한다.
		}
		else{
			bytesize++;			 // 그밗의 경우는 1을 더한다.
		}
		if(bytesize <= maxlen){	// 전체 크기가 maxlen를 넘지않으면
			strlen	= k1 + 1;		 // 1씩 증가
		}
	}
	// 총바이트수가 허용된 문자열의 최대값을 초과하면
	if(bytesize > maxlen){
		obj.value	= objstr.substr(0, strlen);
		bytesize	= maxlen;
		alert('허용된 문자열의 최대값은 한글 '+Math.floor(maxlen / 2)+'자, 영문or숫자 '+maxlen+'자 입니다. \n초과된 내용은 자동으로 삭제 됩니다.');
	}

	if(tar_id != '' && document.getElementById(tar_id)){
		document.getElementById(tar_id).innerHTML = bytesize;
	}
}
// 콤마찍기object타입
function comma_obj_y(obj){
	var oval	= String(obj.value);
	var buho	= oval.substr(0, 1) == '-' ? '-' : '';
	var nval	= oval.replace(/\D/g, '');
	var patt	= /(^[+-]?\d+)(\d{3})/; // 정규식

	while(patt.test(nval)){
		nval	= nval.replace(patt, '$1' + ',' + '$2');
	}
	obj.value	= buho + nval;
}
// 콤마없애기object타입
function comma_obj_n(obj){
	obj.value	= String(obj.value).replace(/\D/g, '');
}
// 콤마찍기string타입
function comma_str_y(str){
	var oval	= String(str);
	var buho	= oval.substr(0, 1) == '-' ? '-' : '';
	var nval	= oval.replace(/\D/g, '');
	var patt	= /(^[+-]?\d+)(\d{3})/; // 정규식

	while(patt.test(nval)){
		nval	= nval.replace(patt, '$1' + ',' + '$2');
	}
	return buho + nval;
}
// 콤마없애기string타입
function comma_str_n(str){
	return String(str).replace(/\D/g, '');
}