<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>주차요금결제 - 나의 주차정보</title>

    <script id="jscode">
    
        var myValidator = new AXValidator();
        
        //주차장 계약정보 그리드
        var fnObj = {
            pageStart: function(){
                fnObj.grid.bind();
            },  
            grid: { 
                target : new AXGrid() ,
                bind: function(){
                    window.myGrid = fnObj.grid.target;
                    myGrid.setConfig({
                        targetID: "grid1",
                        sort        : true, //정렬을 원하지 않을 경우 (tip
                        colHeadTool : false, // column tool use
                        fitToWidth  : true, // 너비에 자동 맞춤  
                        colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
                        colGroup: [
   							{key:"chk",   label:"선택", width:"10",    align:"center" ,   formatter:function(){
   								var value = this.item.purchaseKey + '/' + this.item.esntlId;
								var radioInput = '<input type="radio" name="chk" value="' + value + '">';
                                return radioInput;

                                /*
                                if(this.item.parkingProduct == '03'){
									var radioInput = '<input type="radio" name="chk" value="">';
                                    return radioInput;
                                }else{
									var radioInput = '<input type="radio" name="chk" value="">';
									return radioInput;
                            	}
                                */
							 }
                            },
                                   
                            {key:"carNumber", label:"차량번호", width:"15", align:"center"},
                            {key:"sectionInfo", label:"주차장", width:"30", align:"left", formatter:function(){
                            	if(this.item.parkingProduct == '03'){
                            		return this.item.parkSectionName;
                            	}else{
                            		return this.item.parkSectionName+'/'+this.item.parkBlockName+'/'+this.item.divisionName;
                            	}
                            }},
                            {key:"useDate", label:"이용기간", width:"40", align:"center", formatter:function(){
                                return this.item.useBeginDateStr+'~'+this.item.useEndDateStr;
                            }},
                            {key:"useTime", label:"이용시간", width:"20", align:"left", formatter:function(){
                            	if(this.item.parkingProduct == '02'){
                                    return this.item.useMonthName;
                                }else{
                                    return this.item.useTimeName;
                                }
                            }},
                            //{key:"costComma", label:"이용요금", width:"15", align:"right"},
                            {key:"useStatus", label:"상태", width:"10", align:"center", formatter:function(){
                                if(this.item.statusCd == '02'){
                                    return this.item.statusCdName;
                                }else{
                                    return this.item.useStatus;
                                }
                            }},
                            {key:"parkingProductName", label:"비고", width:"10", align:"center"}
                        ]
                        ,
                        colHead    : {
                            onclick: function() { 
                                myGrid.click(0); 
                            }
                        }, 
                        body : {
                            onclick: function(){
                                //if( this.c != 6 ){ 
                                    //selectRow(this.item);
                                //}
                            } 
                        },
                        page:{
                            paging:true,
                            pageSize:10
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/mypage/selectContractList.json",
                        //ajaxPars: $('#searchFrm').serialize(),
                        onLoad:function(){
                            //fnObj.clickRow(0);
                        }  
                    });
                }  
            },
            clickRow : function(seq){
                myGrid.click(seq);
            },
            reloadList: function(){
                myGrid.reloadList();
            }
        }
        
        //주차장 결제정보 그리드
        var payObj = {
            pageStart: function(){
                payObj.grid.bind();
            },  
            grid: { 
                target : new AXGrid() ,
                bind: function(){
                    window.payGrid = payObj.grid.target;
                    payGrid.setConfig({
                        targetID: "grid2",
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
                            {key:"parkingProductName", label:"상품", width:"80", align:"center"},
                            {key:"carNumber", label:"차량번호", width:"50", align:"center"},
                            {key:"sectionInfo", label:"사용구획", width:"100", align:"left", formatter:function(){
                                if(this.item.parkingProduct == '03'){
                                    return this.item.parkSectionName;
                                }else{
                                    return this.item.parkSectionName+'/'+this.item.divisionName;
                                }
                            }},
                            {key:"costComma", label:"결제금액", width:"80", align:"right"},
                            {key:"useBeginDateStr", label:"이용시작일", width:"80", align:"right"}
                            /*
                            {key:"", label:"선택", width:"10"},
                            {key:"", label:"청구 월", width:"10"},
                            {key:"", label:"차량번호", width:"10"},
                            {key:"", label:"사용구획", width:"10", align:"right"},
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
                        ajaxUrl: "/mypage/selectPaymentList.json",
                        //ajaxPars: $('#searchFrm').serialize(),
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
        });
        
        $(document.body).ready(function(){
            
        	//주차장 계약정보 조회
            fnObj.pageStart();
        	
            //주차장 결제정보 조회
            payObj.pageStart();

            // AXGrid.js 내부 코드 대체용
            $('.isTrLastChild').css('background','');
            
        });
        
        //주차장 결제정보 그리드에서 선택한 오브텍트 전역변수
        var selectPayObj;

        //리스트클릭
        function selectRow(item){ 
            
        	selectPayObj = item;
        	
        	$('#emailAdres').val(item.mberEmailAdres);
        	$('#mberPhone').val(item.mberPhone);
        	
            $("#LGD_AMOUNT").val(selectPayObj.cost);
            $("#LGD_OID").val(selectPayObj.purchaseKey);
            $("#LGD_BUYER").val(selectPayObj.mberNm);
            $("#LGD_PRODUCTINFO").val('동작구 주차장 결제:'+selectPayObj.parkingProductName);
            $("#productCd").val(selectPayObj.parkingProduct);
                    	
        }
        
        //결제하기
        function savePayment(){
            
            var radioCheck = $('input:radio[name=chk]').is(':checked');
            
            if(!radioCheck){
                alert('주차장 결제정보에서 결제하실 건을 선택하세요.');
                return;
            }
            
            //허부장님 콘솔에서 값 확인하시고 뒤에서 가져다 쓰심되요
            console.log(selectPayObj);

            
            var validateResult = myValidator.validate();
            
            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	if($("#emailAdres").val().length == 0) {
            		alert('메일주소를 입력하세요.');
            		$("#emailAdres").focus();
            		return false;
            	}
            	if($("#mberPhone").val().length == 0) {
            		alert('핸드폰번호를 입력하세요.');
            		$("#mberPhone").focus();
            		return false;
            	}            	
            	document.frm.action = "/lgdacom/payreq_crossplatform.jsp";
            	document.frm.submit();
            	
            	/*
            	alert($('#frm').serialize());
                $.ajaxSettings.traditional = true;
                $.ajax({
                    url : "/payreq_crossplatform.jsp",
                    type: "POST", 
                    data: $('#frm').serialize(),
                    dataType:"json", 
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("거주자우선주차 신청에 성공했습니다.");
                            
                            //주차장 계약정보 조회
                            fnObj.pageStart();
                            
                            //주차장 결제정보 조회
                            payObj.pageStart();
                        } else {
                            axf.alert("거주자우선주차 신청에 실패했습니다. 관리자에게 문의해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
                */
            }
        }
        
        function print_visit_parking() {
        	
        	var radioCheck = $('input:radio[name=chk]').is(':checked');
        	if (radioCheck) {

        		var value = $("input:radio[name='chk']:checked").val();
        		if (value) {
        			$("#printValue").val(value);
        		} else {
            		alert('인쇄할 항목을 선택하시기 바랍니다.');
            		return;
        		}
        	} else {
        		alert('인쇄할 항목을 선택하시기 바랍니다.');
        		return;
        	}
        	
        	//var url = getContextPath() + "/mypage/printVisitLabel.jiro?isPrint=Y&" + $('#frm').serialize();
        	var url = "/mypage/printVisitLabel.jiro?" + $('#frm').serialize();
        	var sizeW = 1000;
        	var sizeH = 800;
        	var nLeft = screen.width/2 - sizeW/2 ;
        	var nTop  = screen.height/2 - sizeH/2 ;
        	var opt = 'scrollbars=yes,status=yes,width=' + sizeW + ',height=' + sizeH + ',top='+nTop+',left='+nLeft;
            window.open(url,"gojisuWin",opt);
        }
        
        
    </script>

</head>
<body>
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>나의 주차정보</h1>
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
                <li><a class="on" href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
            </ul>
        </div>

        <div class="body">
            <div class="caption">
                <p>계약정보를 확인하여 결제하실 정보가 있을 시 납기마감일이 지나기 전에 결제해야 합니다.</p>
                <p>납기마감일이 경과되었을 경우 계약된 모든 배정 정보는 취소됩니다.</p>
            </div>

            <form name="contractMenu" id="contractMenu" action="${pageContext.request.contextPath}/mypage/parkingContract.c"></form>
            
            <!-- 주차장 계약정보 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>주차장 계약정보</p>
            </div>
            <div class="table_box">
                <div id="grid1" style="height: 250px;"></div>
            </div>
            <!-- 주차장 계약정보 : END -->

			<div class="page_btn">
                <a class="btn blue" onclick="print_visit_parking();">방문주차권 출력</a><!-- 주차권 출력 -->
                <!--<a class="btn">취소</a> 취소시 돌아갈 페이지 없음. 일단 주석처리 -->
            </div>


            <!-- 계약진행 된 결제가능 한 정보 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>주차장 결제정보</p>
            </div>
            <div class="table_box">
                <div id="grid2" style="height: 250px;"></div>
            </div>
            <!-- 계약진행 된 결제가능 한 정보 : END -->
            
            <form name="frm" id="frm" method=post>
            <input type="hidden" id="LGD_AMOUNT" name="LGD_AMOUNT" />
            <input type="hidden" id="LGD_OID" name="LGD_OID" />
            <input type="hidden" id="LGD_BUYER" name="LGD_BUYER" />
            <input type="hidden" id="LGD_PRODUCTINFO" name="LGD_PRODUCTINFO" />
            <input type="hidden" id="productCd" name="productCd" />
            <input type="hidden" id="pageCd" name="pageCd" value="1" />
            <input type="hidden" id="printValue" name="printValue" />
            
            
            <!-- 결제에 필요한 필수 입력 값 -->
            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>결제 필수 입력값</p>
            </div>
            <!-- 테이블 박스 -->
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