

function clswin() {
  var sub = confirm('학습을 종료하시겠습니까?');
   if(sub == true){
	  top.close();
  }
   if(sub == false){
   return false;
  }
 }

// flashWrite(파일경로, 가로, 세로, 아이디, 배경색, 변수, 윈도우모드)
function flashWrite(url,w,h,id,bg,vars,win){

	// 플래시 코드 정의
	var flashStr=
	"<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+
	"<param name='allowScriptAccess' value='always' />"+
	"<param name='movie' value='"+url+"' />"+
	"<param name='FlashVars' value='pageInfo="+vars+"&totalpage="+tolPage+"&chasiNum="+chasiNum+"' />"+
	"<param name='wmode' value='"+win+"' />"+
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='"+bg+"' />"+
	"<embed src='"+url+"' FlashVars='"+vars+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object>";

	// 플래시 코드 출력
	document.write(flashStr);

}

dir=location.href;
dir=dir.split("/");
var thisUrl=dir[dir.length-1];
thisUrl=thisUrl.split(".htm");
thisUrl=thisUrl[0];


var course_name ="장기기증, 희망의 씨앗을 뿌리다";
var tolPage = 13; 
var swf_FileName='swf/main.swf';
var swf_width='1000';
var swf_height='680';
var swf_id='01';
var bg_Color='#f0f0f0';
var page_info=thisUrl;
var other_option='transparent';
var chasiNum = page_info.substr(0,2);

function movePage(pName){
	location.href=swf_id+"_"+pName+".htm";
}

function on_popup(val){
	x='800';
	y='561';
	SubOnPop = window.open(val, "" ,"toolbar=no, menubar=no, scrollbars=no, resizable=no, width="+x+", height="+y+", status=no,top==100, left=100");
	SubOnPop.focus();
}
function winPop(val){
	x='800';
	y='561';
	SubOnPop = window.open(val);
	SubOnPop.focus();
}

function on_dic(val){
	x='650';
	y='550';
	SubOnPop = window.open(val, "" ,"toolbar=no, menubar=no, scrollbars=no, resizable=no, width="+x+", height="+y+", status=no,top==100, left=100");
	SubOnPop.focus();
}

function on_down(val){
	window.open("down/"+val+".zip");
 }

function dic(dic){
	window.open("dic.htm","","width=800,height=600, left=0, top=0, scrollbars=no");
	//alert("준비중입니다.")
}
function map(){
	window.open("map.htm","","width=600,height=500, left=0, top=0, scrollbars=no");
}


//의견 저장하기 스크립트
function whensubmit(optitle,title,contents){	  
	insertOpin(optitle, title, contents)
}

//다른 학습자 의견보기 팝업 스크립트
function whenoplist(optitle){
	viewOpin(optitle);
}