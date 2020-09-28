$(window).scroll(function () {

    //현재 스크롤 값 얻어오기
    var height = $(document).scrollTop();
    log(height);

    //현재 스크롤 값 표기
    function log(str){
        $('#log').text(str);
        
    }

});

(function mobileRedirect() {
	if(navigator.userAgent.match(/Android|Mobile|iP(hone|od|ad)|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/)){
	    //모바일(스마트폰+태블릿)일 때 실행 될 스크립트
		//alert('모바일일경우 정상적인 이용이 되지않습니다. 모바일전용페이지로 이동합니다.');
	
		params = getUrlParams();
		
		var errorCode = params.loginError;

        if (errorCode == '01') {
        	fn_MovePage('/m/main?loginError=01');
        }else{
        	fn_MovePage('/m/main');
        }
	}
})()

function fn_MovePage(url) {
	document.location.href = url; 
}

function getUrlParams() {
    var params = {};
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
    return params;
}

function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}

function openPopup_fn() {

    var year=$("#userForm").find("[name=year]").val();
    var empno=$("#userForm").find("[name=empno]").val();
    var name=$("#userForm").find("[name=name]").val();
    var retVal;

    //window.open('');
    var pWin, tVal, lVal ;
    var ptype = 1;
    var w = 1107;
    var h = 785;
    lVal = (screen.availWidth - w) / 2;
    tVal = (screen.availHeight - h) / 2;

    var popOpt = "width="+w+"px,height="+h+"px, top="+tVal+", left="+lVal;
    if(ptype == 0)
        popOpt += ",scrollbars=no";

    if(ptype == 1)
        popOpt += ",scrollbars=yes";

    if(ptype == 2)
        popOpt += ",scrollbars=yes,resizable=yes";

    //openPopLayer( "/mis/tax/sendEmailTargetUser.do" , "yndYear="+frm.yndYear.value+"&searchKey="+frm.searchNm.value , "init" ,  800 , 620 , null , null , true);  
    //window.open("/mis/tax/incomeDeductView.do?empno="+empno+"&year="+year+"&name="+name, 'popupDeduct',popOpt); 

    //if(pop_status != null && !pop_status.closed){
    //	pop_status.focus();
    //	return;
    //}
    var myForm = document.userForm;
    var url = "/mis/popUp.do";

    var text="";
    text+="기본정보 > 가족정보를 확인 하셨습니까?\n";
    if (confirm(text) == true){    //확인
        pop_status = window.open("" ,"popupPDF", popOpt);
        myForm.action =url;
        myForm.method="post";
        myForm.target="popupPDF";
        myForm.submit();
    }else{   //취소
        return;
    }

    /*
     var url = "/mis/popUp.do?year="+year+"&empno="+empno+"&name="+encodeURIComponent(name);
     var openParam = "dialogWidth: 1024px; dialogHeight: 800px; resizable: 0, scroll: 1, center: 1"; 
     retVal = window.showModalDialog(url,window,openParam); 
     */
    /*
     var settings = 'toolbar=0, status=0, menubar=0, scrollbars=yes, width=1024, height=800';
     openNewWindow = window.open("/mis/popUp.do", "popupWin", settings);
     */
}

function openPopup_fn2() {
    
    var year=$("#userForm").find("[name=year]").val();
    var empno=$("#userForm").find("[name=empno]").val();
    var name=$("#userForm").find("[name=name]").val();

    var retVal;
    var url = "/mis/popUp2.do?year="+year+"&empno="+empno;
    var openParam = "dialogWidth: 600px; dialogHeight: 400px; resizable: 0, scroll: 1, center: 1";
    retVal = window.showModalDialog(url,window,openParam);
    alert("보완완료후 다시 신고서 제출을 실행해주세요.!")

    $('#userForm').attr('target','');
    $('#userForm').attr('action',"/mis/tax/incomeDeductView.do").submit();
    /*
     var settings = 'toolbar=0, status=0, menubar=0, scrollbars=yes, width=1024, height=800';
     openNewWindow = window.open("/mis/popUp.do", "popupWin", settings);
     */
}

function openPopup_fn3() {
    
    var retVal;
    var url = "/mis/popUp3.do";
    var openParam = "dialogWidth: 600px; dialogHeight: 400px; resizable: 0, scroll: 1, center: 1";
    retVal = window.showModalDialog(url,window,openParam);
    /*
     var settings = 'toolbar=0, status=0, menubar=0, scrollbars=yes, width=1024, height=800';
     openNewWindow = window.open("/mis/popUp.do", "popupWin", settings);
     */
}


var incomeDeductPopup11;
function openPopup_fn4() {
    
    var year=$("#userForm").find("[name=year]").val();
    var empno=$("#userForm").find("[name=empno]").val();
    var name=$("#userForm").find("[name=name]").val();
    var retVal;

    //window.open('');
    var pWin, tVal, lVal ;
    var ptype = 1;
    var w = 1107;
    var h = 500;
    lVal = (screen.availWidth - w) / 2;
    tVal = (screen.availHeight - h) / 2;

    var popOpt = "width="+w+"px,height="+h+"px, top="+tVal+", left="+lVal;
    popOpt += ",scrollbars=no,resizable=yes";

    //openPopLayer( "/mis/tax/sendEmailTargetUser.do" , "yndYear="+frm.yndYear.value+"&searchKey="+frm.searchNm.value , "init" ,  800 , 620 , null , null , true);  
    //window.open("/mis/tax/incomeDeductView.do?empno="+empno+"&year="+year+"&name="+name, 'popupDeduct',popOpt); 

    //if(pop_status != null && !pop_status.closed){
    //	pop_status.focus();
    //	return;
    //}
    var myForm = document.userForm;
    var url = "/mis/tax/incomeDeductPopup11.do";
    incomeDeductPopup11 = window.open("" ,"incomeDeductPopup11", popOpt);
    myForm.action =url;
    myForm.method="post";
    myForm.target="incomeDeductPopup11";
    myForm.submit();

    /*
     var settings = 'toolbar=0, status=0, menubar=0, scrollbars=yes, width=1024, height=800';
     openNewWindow = window.open("/mis/popUp.do", "popupWin", settings);
     */
}

function loadingEnable(){
    var loading = $('<div id="loadingBlock"   style="filter:Alpha(Opacity=40);opacity:0.4;width:100%;height:100%;position:absolute; top:0px; left:0px;z-index:10000;background-color:#F7F7F7;vertical-align: middle;text-align:center" ><img style="display:block; position:absolute; top:50%; left:50%; margin-left:-50px; margin-top:-50px;" src="/images/ajax-loader.gif" /></div>');
    $("body").prepend(loading);
}
function loadingDisable(){
    $("#loadingBlock").remove();
}
function blockScreen(){
    var loading = $('<div id="blockScreen"   style="filter:Alpha(Opacity=80);opacity:0.8;width:100%;height:100%;position:absolute; top:0px; left:0px;z-index:10000;background-color:black;vertical-align: middle;text-align:center" ><div style="display:block; position:absolute; top:50%; left:50%; margin-left:-330px; margin-top:-50px;"><i class="fa fa-info fa-5x"></i><font size="9px">&nbsp;&nbsp;연말정산 신고기간이 아닙니다.</div></div>');
    $("body").prepend(loading);
}
function blockScreenMsg(msg){
    var loading = $('<div id="blockScreen"   style="filter:Alpha(Opacity=80);opacity:0.8;width:100%;height:100%;position:absolute; top:0px; left:0px;z-index:10000;background-color:black;vertical-align: middle;text-align:center" ><div style="display:block; position:absolute; top:50%; left:50%; margin-left:-330px; margin-top:-50px;"><i class="fa fa-info fa-5x"></i><font size="9px">&nbsp;&nbsp;'+msg+'</div></div>');
    $("body").prepend(loading);
}

function closePopup_fn() {

    self.close();
}
function submit_fn() {
    var text="";
    text+="연말정산 자료제출을 실행하시면 자료 수정이 불가합니다.\n";
    text+="보완 수정 발생시 연말정산 담당자에게 문의하십시요.\n";
    text+="연말정산 자료를 제출하시겠습니까?\n";
    if (confirm(text) == true){    //확인
        submitOK_fn() ;
        //  alert("제출완료");

    }else{   //취소
        return;
    }
}
function submitOK_fn() {

    var year=$("#userForm").find("[name=year]").val();
    var empno=$("#userForm").find("[name=empno]").val();
    var name=$("#userForm").find("[name=name]").val();

    $.ajaxSettings.traditional = true;
    $.ajax({
        type:"POST",
        url: "/mis/tax/submitTax.json",
        data:{
            year:year,
            empno:empno,
            name:name
        },
        success:function(data){
            //alert(data.count);
            alert(data.message);
            $('#tab1').click();
        },

        error:function(e){

        }
    });
}
/**
 * 레이어팝업 by Hoonsik
 *
 * @param _url
 * @param _data
 * @param _width
 * @param _height
 */
function openPopLayerOrg( _url , _data   ,_callback ,  _width , _height , _top , _left , _background  ){

    var date = new Date();
    var _target = "popup_"+date.getDate()+date.getHours()+date.getMinutes()+date.getSeconds()+date.getMilliseconds();
    var callback = '';
    if(!callback){
        callback = _callback
    }
    var datas = "popupId="+_target+"&callback="+callback+'&'+_data;

    if(_background){
        var divBg = '<div id="'+_target+'_bg" class="popup_bg"></div>';
        $("body").prepend(divBg);
    }

    _url = _url + '?' + datas;
    var div = '<div id="'+_target+'" class="popup bg_layer2"><iframe id="'+_target+'_div" src="'+_url+'" style="width:100%;height:100%;" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0>로딩중..</iframe></div>';
    $("body").prepend(div);
    if(_height) $("#"+_target).css("height", _height);
    if(_width)  $("#"+_target).css("width", _width);
    if(_top && _top != null){
        $("#"+_target).css("top", _top );
    }else{
        $("#"+_target).css("top", "50%");
        $("#"+_target).css("margin-top", "-"+ (_height / 2) +"px" );
    }

    if(_left && _left != null){
        $("#"+_target).css("left", _left);

    }else{
        $("#"+_target).css("left", "50%");
    }
    $("#"+_target).css("display", "block");
    $("#"+_target).css("margin-left", "-"+ (_width / 2) +"px" );

}
function closePopupAll(){
    $("[class*=bg_layer2]").remove();
    $(".pop_layBg").remove();
}

function closePopupSelf(){


}
function openPopLayerNoneBlock( _url , _data   , _callback , _width , _height , _top , _left ){
    openPopLayerOrg( _url , _data   , _width , _height , _top , _left , false );
}

function openPopLayer( _url , _data ,  _callback , _width , _height , _top , _left ){
    openPopLayerOrg( _url , _data   ,_callback ,  _width , _height , _top , _left , true );
}

// form data를 Object 형태로 만들어주는 jquery 확장함수
// 예) $("Object").serializeAllObject();
$.fn.serializeAllObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(function(){
	
	//그리드 조회값없을때 디폴트메세지
	//AXConfig.AXGrid.emptyListMSG = "검색된 내용이 없습니다.";
	
	/*select*/
	jQuery('select').each(function(i, val){
//		if ( $(this).parent()[0].nodeName !== "TD" ) {
//			$(this).selectbox()
//			.parent().find(".select-list").mCustomScrollbar({
//				theme:"minimal"
//			});
//		} else {
//			$(this).selectbox();
//		}
//		alert(1);
		
		if($(this).attr('url') && $(this).attr('param')){ 
			 
			var value = "";
			
			if($(this).attr('value')){
				value = $(this).attr('value'); 
			} 
			
			var maxHeight = $(this).attr('maxHeight');
			
			var callback = $(this).attr('callback');
			
			if(maxHeight != '' && maxHeight != undefined){
				
				if(callback != '' && callback != undefined){
					
					
					if($(this).attr('isspace') == 'true'){
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'), 
							maxHeight : maxHeight,
							isspace : true,
							isspaceTitle : $(this).attr('isspaceTitle'),
				            ajaxAsync:true , 
				            onLoad : function(){ 
				            	eval(callback)(); 
				            }
						});  
					}else{
						 
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'),  
							maxHeight : maxHeight,
				            ajaxAsync:true ,
				            setValue: value,
				            onLoad : function(){ 
				            	eval(callback)(); 
				            }
						}); 
					}
					 
					
					
				}else{
					if($(this).attr('isspace') == 'true'){
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'), 
							maxHeight : maxHeight,
							isspace : true,
							isspaceTitle : $(this).attr('isspaceTitle'),
				            ajaxAsync:true ,
				            setValue: value
						});  
					}else{
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'),  
							maxHeight : maxHeight,
				            ajaxAsync:true ,
				            setValue: value
						}); 
					}
				}
				
			}else{
				
				if(callback != '' && callback != undefined){
					
					
					if($(this).attr('isspace') == 'true'){
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'), 
							isspace : true,
							isspaceTitle : $(this).attr('isspaceTitle'),
				            ajaxAsync:true , 
				            onLoad : function(){ 
				            	eval(callback)(); 
				            }
						});  
					}else{
						 
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'),  
				            ajaxAsync:true ,
				            setValue: value,
				            onLoad : function(){ 
				            	eval(callback)(); 
				            }
						}); 
					}
					 
					
					
				}else{
					if($(this).attr('isspace') == 'true'){
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'), 
							isspace : true,
							isspaceTitle : $(this).attr('isspaceTitle'),
				            ajaxAsync:true ,
				            setValue: value
						});  
					}else{
						$(this).bindSelect({
							ajaxUrl:$(this).attr('url'),
							ajaxPars:$(this).attr('param'),  
				            ajaxAsync:true ,
				            setValue: value
						}); 
					}
				}
			}
			
			
			
		}else{   
			$(this).bindSelect({}); 
			if($(this).attr('value')){
				var value = $(this).attr('value'); 
				$(this).bindSelectSetValue(value);
				
			} 
			
		}
		 
	});
	
});


