<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	String gubn = request.getParameter("gubn")==null ? "N" : (String)request.getParameter("gubn");
	String returnflg = request.getParameter("returnflg")==null ? "N" : (String)request.getParameter("returnflg");
	String tempflg = request.getParameter("tempflg")==null ? "N" : (String)request.getParameter("tempflg");
	String rletter_id = request.getParameter("letter_id")==null ? "" : (String)request.getParameter("letter_id");
	String curPage = request.getParameter("letter_id")==null ? "1" : (String)request.getParameter("curPage");
%>
<head>
      <script src="${pageContext.request.contextPath}/resource/ckeditor/ckeditor.js"></script>

<title>생명나눔편지함</title>

<script id="jscode">

   		var myValidator = new AXValidator();
        

        $(document.body).ready(function(){
        	

            //CKEDITOR.replace('content', {
            //    //첨부파일 or 이미지 업로드를 사용하겠다. 그리고 호출하는 URL는 이쪽이다. 
			//	filebrowserUploadUrl : '${pageContext.request.contextPath}/let/fileupload.l',
			//	// textarea에서 엔터키 옵션.
	        //    enterMode : CKEDITOR.ENTER_BR,
	        //    height:500
			//});

            
            $(document).on('click', '.email__lnb a', function () {
                $('a').removeClass("active");
                $(this).addClass("active");
            })
        	
            $(document).on('click', '.mobile-emenu-content .links a', function () {
                $('.links a').removeClass("active");
                $(this).addClass("active");
            })
            


            $.ajax({
                url: "/let/searchReceiverByMath.json",
                type: "POST",
                data:{returnflg:$("#returnflg").val()
                	, tempflg:$("#tempflg").val()
                	, rletter_id:$("#rletter_id").val()
                	, gubn:$("#gubn").val()},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                   $("#receiver_name").html(data.receiverName);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
            
            //답장의 경우 제목 내용 조회
            if ($("#returnflg").val() == "Y" || $("#tempflg").val() == "Y"){
            	$.ajax({
                    url: "/let/searchLetterView.json",
                    type: "POST",
                    data: {returnflg:$("#returnflg").val()
                    	, tempflg:$("#tempflg").val()
                    	, letter_id:$("#rletter_id").val()
                    	, gubn:$("#gubn").val()},
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                    	
                    	if ($("#returnflg").val() == "Y"){
							//제목
	                        $("#title").val("[RE]" + data.title);
							
							//내용
							var tempcontent = "";
							tempcontent = tempcontent + " ----------------------------------<br>";
							tempcontent = tempcontent + " From : " + data.sendreciname + "<br>";
							tempcontent = tempcontent + " sent : " + data.senderDate + "<br>";
							tempcontent = tempcontent + " subject : " + data.title + "<br>";
							tempcontent = tempcontent + " subject : " + data.content + "<br>";
							
							CKEDITOR.instances.content.setData(tempcontent);                    		
                    	}else{
	                        $("#title").val(data.title);
							CKEDITOR.instances.content.setData(data.content);
                    	}
						
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                    }
                });
            }
            
            searchLetterTot('N');
            
        });
        
        //편지함별 총계 조회		
        //"R" : 받은 편지함
        //"N" : 안읽은 편지함
        //"S" : 보낸편지함
        //"T" : 임시보관함
        function searchLetterTot(gubn) {     
            $.ajax({
                url: "/let/searchLetterListTot.json",
                type: "POST",
                data: {gubn:gubn},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	$("#noReadTot1").html(data.noReadTot);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }       
        
        //편지함 이동
        function toLetterBox(gubn,searchflg){
        	if(searchflg != undefined && searchflg != "" && searchflg == "T"){
        		if ($("#searchTxt").val()==""){
        			axf.alert("검색어를 입력하십시요.");
        			return;
        		}else{
        			$("#p_searchTxt").val($("#searchTxt").val());
        		}
        	}
        	$("#gubn").val(gubn);
        	$("#frm_move").attr("action", "/let/letterMain.l");
        	$("#frm_move").submit();
        }
        
        //널체크
        function ckEmpty(str){
            
            if(typeof str == undefined || str == null || str == "")
                return "";
            else
                return str ;
        }
        
        //편지보내기, 임시저장
        function sendLetter(gubn){
        	
        	//유효성 검사
        	if ($("#receiver_name").html() == ""){
        		axf.alert("받는사람 매칭 처리가 되어 있지 않습니다. 관리자에게 문의하세요.");
        	 	return;
        	}
        	
        	if ($("#title").val() ==""){
        		axf.alert("제목을 입력하세요");
        		$("#title").focus();
        	 	return;
        	}
        	
        	if (CKEDITOR.instances.content.getData().length <1){
        		axf.alert("내용을 입력하세요");      
        		return;
        	}else{
        		$("#content").val(CKEDITOR.instances.content.getData());
        	}
        	
        	var formData = new FormData($("#frm")[0]);
        	formData.append("gubn", gubn); //보내기, 임시저장 플래그
        	formData.append("returnflg", $("#returnflg").val()); //답장 플래그
        	formData.append("tempflg", $("#tempflg").val()); //임시저장 플래그
        	formData.append("rletter_id", $("#rletter_id").val()); //답장/임시저장 대상 편지함

        	$.ajax({
                url: "/let/sendLetter.json",
                type: "POST",
                data: formData,    
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	if(data.result=="OK"){
                		if (gubn == "S"){
                			axf.alert("편지를 발송하였습니다.");
                            toLetterBox("S");
                		}else{
                			axf.alert("편지를 임시저장하였습니다.");
                            toLetterBox("T");
                		}
                	}else{
                		if ((data.Message).length> 0){
                			axf.alert(data.Message);	
                		}else{
                    		if (gubn == "S"){
                    			axf.alert("편지 발송에 실패하였습니다.");
                    		}else{
                    			axf.alert("편지 임시저장에 실패하였습니다");
                    		}
                		}
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }
        
        
 </script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->


	<form name="frm_move" id="frm_move" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn %>" />
		<input type="hidden" id="returnflg" name="returnflg" value="<%=returnflg %>" />
		<input type="hidden" id="tempflg" name="tempflg" value="<%=tempflg %>" />
		<input type="hidden" id="rletter_id" name="rletter_id" value="<%=rletter_id %>" />
		<input type="hidden" id="curPage" name="curPage" value="<%=curPage%>" />
		<input type="hidden" id="p_searchTxt" name="p_searchTxt" value="" />
	</form>
	<form name="frm" id="frm" enctype="multipart/form-data">
		<div class="emailcontainer">
		    <div class="email__lnb">
        		<div class="top" onclick="javascript:fn_MovePage('/let/letterWrite.l');" style="cursor:pointer">편지쓰기</div>
		        <a href="javascript:toLetterBox('R');">받은편지함 <strong><label id = "noReadTot1"></label></strong>
		        </a>
		        <a href="javascript:toLetterBox('N');">안읽은 편지함</a>
		        <a href="javascript:toLetterBox('S');">보낸편지함</a>
		        <a href="javascript:toLetterBox('T');">임시보관함</a>
		    </div>
		    
	        <div class="email__content">
	            <div class="top">
	                <div class="top__actions">
	                    <a href="javascript:sendLetter('S');" class="action submit">보내기</a>
	                    <a href="javascript:sendLetter('T');" class="action">임시저장</a>
	                </div>
	                <div class="search" style="margin-left: 10px;">
	                 <input type="text" id="searchTxt" name="searchTxt" placeholder="메일 검색">
		                <button type="button" onclick="javascript:toLetterBox('R','T');"><img src="${pageContext.request.contextPath}/resource/assets/images/search-icon.png" alt=""></button>
	                </div>
	            </div>
	            <div class="emailwrite">
	                <div class="section">
	                    <div class="row">
	                        <h3> 받는사람</h3>
	                        <div>
	                        	<label id="receiver_name"></label>
	                        </div>
	                    </div>
	                </div>
	                <div class="section">
	                    <div class="row">
	                        <h3>제목</h3>
	                        <div>
	                    		<input style="width:100%" type="text" id ="title" name = "title" value ="" />
	                        </div>
	                    </div>
	                </div>
	                <div class="section">
	                    <div class="row">
	                        <h3>파일첨부 #1</h3>
	                        <div>
	                            <input type="file" id="file1" name="file1">
	                        </div>
	                    </div>
	                    <div class="row">
	                        <h3>파일첨부 #2</h3>
	                        <div>
	                            <input type="file" id="file2" name="file2">
	                        </div>
	                    </div>
	                    <div class="row">
	                        <h3>파일첨부 #3</h3>
	                        <div>
	                            <input type="file" id="file13" name="file3">
	                        </div>
	                    </div>
	                </div>
	
	                <div class="section" id ="editor">
	                </div>
	                    <textarea class="ckeditor" name="content" id="content" ></textarea>
	            </div>
	        </div>
		</div>
		
	</form>
	
</body>