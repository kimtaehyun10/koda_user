<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.InputStream" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>주차딘속 조회 및 결제</title>
    
    <script id="jscode">
		var carNumber = '${param.carNumber}';
        var myValidator = new AXValidator();
    
        //주차요금 결제정보 그리드
	    var payObj = {
	        pageStart: function(){
	            payObj.grid.bind();
	        },  
	        grid: { 
	            target : new AXGrid() ,
	            bind: function(){
	                window.payGrid = payObj.grid.target;
	                payGrid.setConfig({
	                    targetID: "grid1",
	                    sort        : true, //정렬을 원하지 않을 경우 (tip
	                    colHeadTool : false, // column tool use
	                    fitToWidth  : true, // 너비에 자동 맞춤  
	                    colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
	                    colGroup: [
	                        {key:"chk",   label:"선택", width:"30",    align:"center" , 
	                            formatter:function(){
	                                var radioInput = '<input type="radio" name="chk" value="">';
	                                return radioInput;
	                            }
	                        },

					//		{key:"statCdName", label:"상품", width:"80", align:"center"},	              
					//		{key:"productCdName", label:"상품", width:"80", align:"center"},
	                        {key:"carNumber", label:"차량번호", width:"50", align:"center"},
	                        {key:"carOwnName", label:"성명", width:"50", align:"center"},
	                        {key:"", label:"주차장", width:"100", align:"left", formatter:function(){
	                            if(this.item.productCd == '04'){ //부정주차
	                                return this.item.parkSectionName;
	                            }else{
	                                return this.item.parkSectionName+'/'+this.item.divisionName;
	                            }
	                        }},
	                        {key:"", label:"이용(단속)시간", width:"100", align:"center", formatter:function(){
                                if(this.item.productCd == '05'){ //시간주차
                                    return this.item.enterDateTimeStr+'~'+this.item.outTimeStr;
                                }else{
                                    return this.item.regulateDateTimeStr;
                                }
                            }},
	                        
	                        {key:"costComma", label:"결제금액", width:"80", align:"right"},
	                        {key:"payLimitDtStr", label:"납기마감일", width:"80", align:"center"}
	                        /*
	                        {key:"", label:"선택", width:"10"},
	                        {key:"", label:"청구 월", width:"10"},
	                        {key:"", label:"차량번호", width:"10"},
	                        {key:"", label:"사용구획", width:"10", align:"right"},
	                        {key:"", label:"이용시간", width:"20", align:"right"},<!-- 일자 및 시간 (yyyy.mm.dd hh:mm~hh:mm) -->
	                        {key:"", label:"결제금액", width:"10", align:"right"},
	                        {key:"", label:"납기마감일", width:"10", align:"right"},
	                        {key:"", label:"결제", width:"10", align:"right"}
	                        */
	                    ]
	                    ,
	                    colHead    : {
	                        onclick: function() { 
	                            payGrid.click(0); 
	                        }
	                    }, 
	                    body : {
	                        onclick: function(){
	                            //if( this.c != 6 ){ 
	                                selectRow(this.item);
	                            //}
	                        } 
	                    },
	                    page:{
	                        paging:true,
	                        pageSize:10
	                    }
	                });
	                payGrid.setList({
	                    ajaxUrl: "/sup/selectRegulateService.json",
	                    
	                    ajaxPars: $('#searchFrm').serialize(),
	                    onLoad:function(){
	                        //payObj.clickRow(0);
	                    }  
	                });
	            }  
	        },
	        clickRow : function(seq){
	            payGrid.click(seq);
	        },
	        reloadList: function(){
	            payGrid.reloadList();
	        }
	    }
        
	    $(function(){ 
            myValidator.setConfig({
                targetFormName : "frm"
            });
            
            $('#searchCarNumber').val(carNumber);
            searchGrid();
        });
        
	    //차량번호 검색
        function searchGrid(){
	    	
        	var searchCarNumber = $('#searchCarNumber').val();
        	
        	if(searchCarNumber == ''){
        		alert('차량번호 입력후 검색해주세요.');
        		$('#searchCarNumber').focus();
        		return;
        	}
        	
        	$("form").each(function() {  
        	    if(this.id == "frm") this.reset();  
            });

            // 마스크 제거
            $('.before_mask').css('display', 'none');
            
        	payObj.pageStart();

            // AXGrid.js 내부 코드 대체용
            $('.isTrLastChild').css('background','');
        }
        
	    
	    //주차장 결제정보 그리드에서 선택한 오브텍트 전역변수
        var selectPayObj;

        //리스트클릭
        function selectRow(item){ 
            
            selectPayObj = item;
            
            $('#mberPhone').val(item.carTel);
            
            $("#LGD_AMOUNT").val(selectPayObj.cost);
            $("#LGD_OID").val(selectPayObj.purchaseKey);
            $("#LGD_BUYER").val(selectPayObj.carOwnName);
            $("#LGD_PRODUCTINFO").val('동작구 시설공단 주차요금');
            $("#productCd").val(selectPayObj.productCd);
        }
        
        //결제하기
        function savePayment(){
            
            var radioCheck = $('input:radio[name=chk]').is(':checked');
            
            if(!radioCheck){
                alert('주차요금 결제정보에서 결제하실 건을 선택하세요.');
                return;
            }
            
            //허부장님 콘솔에서 값 확인하시고 뒤에서 가져다 쓰심되요
            console.log(selectPayObj);

            var validateResult = myValidator.validate();
            validateResult = true; //for test
            
            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	if($("#LGD_BUYER").val().length == 0) {
            		alert('결제자명을 입력하세요.');
            		$("#LGD_BUYER").focus();
            		return false;
            	}            	
            	if($("#emailAdres").val().length == 0) {
            		alert('메일주소를 입력하세요.');
            		$("#emailAdres").focus();
            		//return false; // for test
            	}
            	if($("#mberPhone").val().length == 0) {
            		alert('핸드폰번호를 입력하세요.');
            		$("#mberPhone").focus();
            		return false;
            	}            	
            	document.frm.action = "/lgdacom/payreq_crossplatform.jsp";
            	document.frm.submit();
                
            	/*
                $.ajaxSettings.traditional = true;
                $.ajax({
                    url : "/mypage/savePayment.json",
                    type: "POST", 
                    data: $('#frm').serialize(),
                    dataType:"json", 
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("주차요금 결제에 성공했습니다.");
                            
                            //주차요금 결제정보 조회
                            payObj.pageStart();
                        } else {
                            axf.alert("주차요금 결제에 실패했습니다. 관리자에게 문의해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
                */
            }
        }
        
    </script>

</head>
<body>
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>주차단속 조회/결제</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>주차요금결제</h2>
            </div>
            <div class="log in">
                <!-- 로그인 이전 -->
                <sec:authorize access="isAnonymous()">
                    <div class="in">
                        <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
                    </div>
                </sec:authorize>
                <!-- 로그인 이후 -->
                <sec:authorize access="isAuthenticated()">
                    <div class="out">
                        <sec:authentication var="user" property="principal" />
                        <p><span>${user.mberNm}</span>님 환영합니다!</p>
                        <a class="btn red" href="<c:url value='/logout'/>">로그아웃</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
    </div>
    <div class="ct_body">
        <div class="sub_nav">
            <ul>
            <!-- 
                <li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차장계약/결제</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/mypage/parkingCharge.c');">주차요금결제</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
            -->
            </ul>
        </div>

        <div class="body">
            <div class="caption">
                <p>공영주차장 이용 후 미결된 주차요금 또는 주차단속에 대한 결제를 할 수 있습니다.</p>
                <p>본인의 차량번호를 확인하여 주시기 바랍니다.</p>
            </div>
            
            <form name="contractMenu" id="contractMenu" action="${pageContext.request.contextPath}/mypage/parkingContract.c"></form>
            
            <form name="searchFrm" id="searchFrm">
            <!-- 주차요금 검색 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>주차요금 검색</p>
            </div>
            <div class="block">
                <div class="line">
                    <label for="">차량번호</label>
                    <input type="text" name="searchCarNumber" id="searchCarNumber" maxlength="15" class="AXInput" />
                    <a class="btn dblue" onclick="searchGrid();">차량번호 검색</a>
                </div>
            </div>
            <!-- 주차요금 검색 : END -->
            </form>

            <!-- 미수 또는 무단주차로 발생된 결제정보 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>주차요금 결제정보</p>
            </div>
            <div class="table_box">
                <div id="grid1" style="height: 250px;"></div>
                <!-- 그리드 부르기 전 마스크 처리 -->
                <div class="before_mask" style="line-height: 250px;">차량번호 입력 후 검색 버튼을 눌러주세요.</div>
            </div>
            <!-- 결제정보 : END -->
            
            <form name="frm" id="frm" method=post>
            <input type="hidden" id="LGD_AMOUNT" name="LGD_AMOUNT" />
            
			
			<input type="hidden" id="LGD_OID" name="LGD_OID" />
             
			
			
			<input type="hidden" id="LGD_PRODUCTINFO" name="LGD_PRODUCTINFO" />
            <input type="hidden" id="productCd" name="productCd" />
            <input type="hidden" id="pageCd" name="pageCd" value="2" />
            
			
			
			<input type="hidden" name="CST_MID" id="CST_MID" value="dongjak204835">
            <input type="hidden" name="LGD_MID" id="LGD_MID" value="dongjak204835">
			
			
			
			<!-- 결제에 필요한 필수 입력 값 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>결제 필수 입력값</p>
            </div>
            <!-- 테이블 박스 -->
            <div class="block">
                <div class="line">
                    <label for="LGD_BUYER">결제자명</label>
                    <input type="text" name="LGD_BUYER" id="LGD_BUYER" value='' title="결제자명" maxlength="50" class="AXInput av-required av-email" />
                </div>
            </div>

            <div class="block">
                <div class="line">
                    <label for="emailAdres">이메일</label>
                    <input type="text" name="LGD_BUYEREMAIL" id="emailAdres" value='' title="이메일" maxlength="50" class="AXInput av-required av-email" />

                    <label for="mberPhone">핸드폰 번호</label>
                    <input type="text" name="mberPhone" id="mberPhone" value='' title="핸드폰 번호" maxlength="20" class="AXInput av-required av-phone" />
                </div>
            </div>
            <!-- 결제에 필요한 필수 입력 값 : END -->
            </form>

            <!-- 결제 방식 = 현재는 1개 신용카드결제 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>결제 방식</p>
            </div>
            <!-- 테이블 박스 -->
            <div class="block">
                <div class="caption">
                    <p>현재 '신용카드결제'만 사용 하실 수 있습니다.</p>
                </div>

                <div class="multiple_selection">
                    <ul>
                        <li class="selection">
                            <input id="payWay" name='payWay' type="radio" value="02" checked disabled />
                            <label for="payWay"><span></span>신용카드결제</label>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 결제 방식 : END -->

            <div class="page_btn">
                <a class="btn lgreen" onclick="savePayment();">결제하기</a><!-- 결제버튼 -->
                <!--<a class="btn">취소</a> 취소시 돌아갈 페이지 없음. 일단 주석처리 -->
            </div>
        </div>

    </div>
</div>
</body>
</html>
