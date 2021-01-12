var wrestMsg	= '';
var wrestFld	= null;

// tag의name을넘김
function wrestItemname(fld){
	return '';
}
// 양쪽공백없애기
function wrestTrim(fld){
	var val	= fld.value.replace(/(^\s+)|(\s+$)/g, '');
	if(!val) return false;
	else return true;
}
// 필수입력검사
function wrestRequired(fld){
	if(wrestTrim(fld) == ''){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '해당 항목은 필수 '+(fld.type=='select-one'?'선택':'입력')+'입니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 공백검사
function wrestNospace(fld){
	var pat = /(\s)/g;
	if(pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '공백이 없어야 합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 최소길이
function wrestMinLength(fld){
	if(!wrestTrim(fld)) return true;

	var minlength = fld.getAttribute('minlength');
	if(wrestFld	== null){
		if(fld.value.length < parseInt(minlength)){
			wrestMsg	= wrestItemname(fld) + '최소 '+minlength+'자 이상 입력하세요.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 최대길이
function wrestMaxLength(fld){
	if(!wrestTrim(fld)) return true;

	var maxlength = fld.getAttribute('maxlength');
	if(wrestFld	== null){
		if(fld.value.length > parseInt(maxlength)){
			wrestMsg	= wrestItemname(fld) + '최대 '+maxlength+'자 까지 입력하세요.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 최소값
function wrestMinNumber(fld){
	fld.value	= fld.value.replace(/\D/g, '');
	if(!wrestTrim(fld)) return true;

	var minnumber = fld.getAttribute('minnumber');
	if(wrestFld	== null){
		if(parseInt(fld.value) < parseInt(minnumber)){
			wrestMsg	= wrestItemname(fld) + '최소 '+minnumber+' 이상 입력하세요.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 최대값
function wrestMaxNumber(fld){
	if(!wrestTrim(fld)) return true;

	var maxnumber = fld.getAttribute('maxnumber');
	if(wrestFld	== null){
		if(parseInt(fld.value) > parseInt(maxnumber)){
			wrestMsg	= wrestItemname(fld) + '최대 '+maxnumber+' 까지 입력하세요.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 숫자
function wrestNumeric(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /(^[0-9]+$)/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '숫자만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 영문
function wrestAlpha(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /(^[a-zA-Z]+$)/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '영문만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 영문숫자
function wrestAlNum(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /(^[a-zA-Z0-9]+$)/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '영문, 숫자만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 영문숫자언더바
function wrestAlNum_(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /(^[a-zA-Z0-9\_]+$)/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '영문, 숫자, 언더바(_) 만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 한글_자음모음_완성형
function wrestHangul(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /([^가-힣\x20])/;
	if(pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '완성체 한글만 사용 가능합니다.';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 한글_자음모음_미완성형
function wrestHangul2(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i;
	if(pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '한글만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 한글영문
function wrestHangulAlpha(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /([^가-힣\x20^a-z^A-Z])/i;
	if(pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '한글, 영문만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 한글영문숫자
function wrestHangulAlNum(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /([^가-힣\x20^a-z^A-Z^0-9])/i;
	if(pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '한글, 영문, 숫자만 사용 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 휴대폰
function wrestHpNum(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^01([016789]+)-([0-9]{3,4})-([0-9]{4})$/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld)+'휴대폰 형식이 올바르지 않습니다.\n\n하이픈(-)이 포함되어야 합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 전화번호
function wrestTelNum(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld)+'전화번호 형식이 올바르지 않습니다.\n\n하이픈(-)이 포함되어야 합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 이메일주소
function wrestEmail(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)\.([0-9a-zA-Z_-]+)/;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld) + '이메일 형식이 올바르지 않습니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 이미지확장자
function wrestImgExt(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /\.(gif|jpg|png)$/i;
	if(!pat.test(fld.value)){
		if(wrestFld	== null){
			wrestMsg	= wrestItemname(fld)+'이미지 파일이 아닙니다.\n.gif .jpg .png 파일만 가능합니다.\n';
			wrestFld	= fld;
			return false;
		}
	}
	return true;
}
// 날짜datetime
function wrestDatetime(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[1-2][0-9]{3}[\-][0-9]{2}[\-][0-9]{2}[\s][0-9]{2}[\:][0-9]{2}[\:][0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '날짜 형식이 올바르지 않습니다.\n\n2017-03-15 08:36:02 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}
// 날짜date
function wrestDateYmd(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[1-2][0-9]{3}[\-][0-9]{2}[\-][0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '날짜 형식이 올바르지 않습니다.\n\n2017-03-15 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}
// 날짜date
function wrestDateYmd2(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[1-2][0-9]{3}[0-9]{2}[0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '날짜 형식이 올바르지 않습니다.\n\n20170315 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}
// 날짜
function wrestDateYmNum(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[1-2][0-9]{3}[0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '날짜 형식이 올바르지 않습니다.\n\n201703 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}
// 시분
function wrestTimeHI(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[0-9]{2}[\:][0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '시분 형식이 올바르지 않습니다.\n\n08:30 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}
// 시분
function wrestTimeHI2(fld){
	if(!wrestTrim(fld)) return true;

	var pat = /^[0-9]{2}[0-9]{2}$/;
	if(!pat.test(fld.value)){
		wrestMsg	= wrestItemname(fld) + '시분 형식이 올바르지 않습니다.\n\n0830 형식으로 입력해주세요.';
		wrestFld	= fld;
		return false;
	}
	return true;
}

// submit할때속성을검사한다
function wrestSubmit(){
	wrestMsg	= '';
	wrestFld	= null;

	var attr	= null;

	for(var k1=0; k1<this.elements.length; k1++){
		var el	= this.elements[k1];

		if(el.type=='text' || el.type=='hidden' || el.type=='file' || el.type=='password' || el.type=='select-one' || el.type=='textarea'){
			if(el.getAttribute('required') != null){
				if(!wrestRequired(el)) break;
			}
			if(el.getAttribute('minlength') != null){
				if(!wrestMinLength(el)) break;
			}
			if(el.getAttribute('maxlength') != null){
				if(!wrestMaxLength(el)) break;
			}
			if(el.getAttribute('minnumber') != null){
				if(!wrestMinNumber(el)) break;
			}
			if(el.getAttribute('maxnumber') != null){
				if(!wrestMaxNumber(el)) break;
			}

			var array_css	= el.className.split(' '); // class를공백으로나눔

			for(var k2=0; k2<array_css.length; k2++){
				var css	= array_css[k2];
				if(css == 'required' && !wrestRequired(el)) break;
				else if(css == 'trim' && !wrestTrim(el)) break;
				else if(css == 'nospace' && !wrestNospace(el)) break;
				else if(css == 'numeric' && !wrestNumeric(el)) break;
				else if(css == 'alpha' && !wrestAlpha(el)) break;
				else if(css == 'alnum' && !wrestAlNum(el)) break;
				else if(css == 'alnum_' && !wrestAlNum_(el)) break;
				else if(css == 'hangul' && !wrestHangul(el)) break;
				else if(css == 'hangul2' && !wrestHangul2(el)) break;
				else if(css == 'hangulalpha' && !wrestHangulAlpha(el)) break;
				else if(css == 'hangulalnum' && !wrestHangulAlNum(el)) break;
				else if(css == 'hpnum' && !wrestHpNum(el)) break;
				else if(css == 'telnum' && !wrestTelNum(el)) break;
				else if(css == 'email' && !wrestEmail(el)) break;
				else if(css == 'imgext' && !wrestImgExt(el)) break;
				else if(css == 'datetime' && !wrestDatetime(el)) break;
				else if(css == 'dateymd' && !wrestDateYmd(el)) break;
				else if(css == 'dateymd2' && !wrestDateYmd2(el)) break;
				else if(css == 'dateymnum' && !wrestDateYmNum(el)) break;
				else if(css == 'timehi' && !wrestTimeHI(el)) break;
				else if(css == 'timehi2' && !wrestTimeHI2(el)) break;
			}
		}
	}

	if(wrestFld != null){
		alert(wrestMsg);
		wrestFld.focus();
		return false;
	}

	if(this.oldsubmit && this.oldsubmit() == false) return false;

	return true;
}
// 초기에onsubmit을가로챈다
function wrestInitialized(){
	for(var k1=0; k1<document.forms.length; k1++){
		if(document.forms[k1].onsubmit){
			document.forms[k1].oldsubmit	= document.forms[k1].onsubmit;
		}
		document.forms[k1].onsubmit	= wrestSubmit;
	}
}
$(document).ready(function(){
	wrestInitialized();
});