<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.InputStream"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>환불신청 - 나의 주차정보</title>

<script id="jscode">
	var myValidator = new AXValidator();

	//주차요금 결제정보 그리드
	var payObj = {
		pageStart : function() {
			payObj.grid.bind();
		},
		grid : {
			target : new AXGrid(),
			bind : function() {
				window.payGrid = payObj.grid.target;
				payGrid
						.setConfig({
							targetID : "grid1",
							sort : true, //정렬을 원하지 않을 경우 (tip
							colHeadTool : false, // column tool use
							fitToWidth : true, // 너비에 자동 맞춤  
							colHeadAlign : "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
							colGroup : [
									{
										key : "chk",
										label : "선택",
										width : "30",
										align : "center",
										formatter : function() {
											var radioInput = '<input type="radio" name="chk" value="">';
											return radioInput;
										}
									}, {
										key : "carNumber",
										label : "차량번호",
										width : "70",
										align : "center"
									}, {
										key : "useBeginDate",
										label : "이용시작일",
										width : "60",
										align : "center"
									}, {
										key : "useEndDate",
										label : "이용종료일",
										width : "60",
										align : "center"
									}, {
										key : "payDate",
										label : "결제일",
										width : "60",
										align : "center"
									}, {
										key : "payAmtStr",
										label : "결제금액",
										width : "50",
										align : "right"
									}, {
										key : "refundRcvDate",
										label : "결제요청일",
										width : "60",
										align : "center"
									}, {
										key : "refundStatusStr",
										label : "상태",
										width : "60",
										align : "center"
									}, {
										key : "refundApprovalDate",
										label : "처리일",
										width : "60",
										align : "center"
									} ],
							colHead : {
								onclick : function() {
									payGrid.click(0);
								}
							},
							body : {
								onclick : function() {
									//if( this.c != 6 ){ 
									selectRow(this.item);
									//}
								}
							},
							page : {
								paging : true,
								pageSize : 10
							}
						});
				payGrid.setList({
					ajaxUrl : "/mypage/selectRequestRefund.json",
					ajaxPars : $('#searchFrm').serialize(),
					onLoad : function() {

					}
				});
			}
		},
		clickRow : function(seq) {
			payGrid.click(seq);
		},
		reloadList : function() {
			payGrid.reloadList();
		}
	}

	$(function() {
		myValidator.setConfig({
			targetFormName : "frm"
		});

		$("#useEndDate").bindDate({
			align : "right",
			valign : "top",
			onChange : function() {
				calcRefundAmt();
			}
		});
	});

	function calcRefundAmt() {

		var radioCheck = $('input:radio[name=chk]').is(':checked');

		if (!radioCheck) {
			alert('거주자 우선주차 계약정보에서 환불신청할 항목을 선택해주세요.');
			return;
		}

    	if($("#searchRefundCode").val() == '05') {
    		$("#refundAmount").val(selectPayObj.payAmt);
    		$("#refundAmt").val(numberWithCommas(selectPayObj.payAmt));
    		return;
    	}
		
		var rate = selectPayObj.discountRate;
		var unitCost = selectPayObj.unitCost;
		var quarter = selectPayObj.quarterSeq;
		
		var endDate = $("#useEndDate").val();

		if (!endDate) {
			return;
		}
		
    	var endYear = endDate.substring(0,4);
    	var endMonth = eval(endDate.substring(5,7));
    	var endDay = eval(endDate.substring(8,10));
    	var endMonthDayCount = getDay(endYear, endMonth);
    	
    	var dayCnt = 0; //남은 일수 (이용종료 월의 남은 일수만 계산) - 2018-03-13 시설관리공단 요청으로 계산 방식 변경
    	dayCnt = endMonthDayCount - endDay;
    	
    	var monthCnt = 0; //남은 월수
    	
    	//4분기 계산용 extra
    	var extra = 0;
    	if(endMonth == 1 || endMonth == 2) {
    		extra = 12;
    	}
    	monthCnt = (quarter * 3 + 2) - (endMonth + extra);
    	
		//할증 또는 할인율
    	var irate = 0;
    	if (rate != null) {
    		irate = eval(rate);
    	} 
    	
    	//월 단가 산정
    	var monthlyPayAmt = eval(unitCost);
    	if (irate <= 100 && irate > 0) {
    		monthlyPayAmt = monthlyPayAmt - (monthlyPayAmt * Math.floor(irate * 0.1) * 0.1);
    	} else if (irate > 100) {
    		monthlyPayAmt = monthlyPayAmt * Math.floor(irate * 0.1) * 0.1;
    	}
    	
    	//환불 금액 = (남은 일수 * 일할단가) + (남은 월수 * 월 단가)
    	var day = Math.floor((monthlyPayAmt/endMonthDayCount)*100) / 100;
    	var daytemp = 0;
    	daytemp = (dayCnt * day);
    	
    	var temp = 0;
    	temp = Math.floor(daytemp/100)*100; 
    	
    	var calAmt = 0;
		calAmt = temp + (monthCnt * monthlyPayAmt);
		var amount = Math.floor(calAmt/100)*100;
		
		$("#refundAmount").val(amount);
		$("#refundAmt").val(numberWithCommas(amount));
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

    function getDay(intThisYear, intThisMonth) {
    	if (intThisMonth == 4 || intThisMonth==6 || intThisMonth==9 || intThisMonth==11)
    	{
    		intLastDay=30;
    	}
    	else if (intThisMonth==2 && !(intThisYear % 4 == 0))
    	{
    		intLastDay=28;
    	}
    	else if (intThisMonth==2 && intThisYear % 4 == 0)
    	{
    		if (intThisYear % 100 == 0)
    		{
    			if (intThisYear % 400 == 0)
    				intLastDay=29;
    			else
    				intLastDay=28;
    		}
    		else
    		{
    			intLastDay=29;
    		}
    	}
    	else
    	{
    		intLastDay=31;
    	}
    	return (intLastDay);

    }

    function setRefundAll() {
		var radioCheck = $('input:radio[name=chk]').is(':checked');

		if (!radioCheck) {
			alert('거주자 우선주차 계약정보에서 환불신청할 항목을 선택해주세요.');
			return;
		}
    	
    	if($("#searchRefundCode").val() == '05') {
    		$("#refundAmount").val(selectPayObj.payAmt);
    		$("#refundAmt").val(numberWithCommas(selectPayObj.payAmt));
    	} else if ($("#searchRefundCode").val() == ''){
    		$("#refundAmount").val(0);
    		$("#refundAmt").val('0');
    	} else {
    		calcRefundAmt();
    	}
    }
    
	//차량번호 검색
	function searchGrid() {

		var searchCarNumber = $('#searchCarNumber').val();

		if (searchCarNumber == '') {
			alert('차량번호 입력후 검색해주세요.');
			$('#searchCarNumber').focus();
			return;
		}

		$("form").each(function() {
			if (this.id == "frm") {
				//this.reset();
			}
		});
		
		// 마스크 제거
		$('.before_mask').css('display', 'none');

		payObj.pageStart();

		// AXGrid.js 내부 코드 대체용
		$('.isTrLastChild').css('background', '');
	}

	//주차장 결제정보 그리드에서 선택한 오브텍트 전역변수
	var selectPayObj;

	//리스트클릭
	function selectRow(item) {
		selectPayObj = item;

		$('#purchaseKey').val(item.purchaseKey);
		$('#paymentKey').val(item.paymentKey);
		
		var radioCheck = $('input:radio[name=chk]').is(':checked');
		if (radioCheck) {
			var status = selectPayObj.refundStatus;
			if(status) {
				if (status == '01') {
					alert('환불요청 상태에서는 환불신청할 수 없습니다.');
					return;
				}
				if (status == '02') {
					alert('이미 환불처리된 상태에서는 환불신청할 수 없습니다.');
					return;
				}
			}
			calcRefundAmt();	
		}
	}

	//환불신청
	function saveRequest() {

		var radioCheck = $('input:radio[name=chk]').is(':checked');

		if (!radioCheck) {
			alert('차량번호 검색 후 계약정보에서 환불할 항목을 선택후 신청하시기 바랍니다.');
			return;
		}
		
		var status = selectPayObj.refundStatus;
		if(status) {
			if (status == '01') {
				alert('환불요청 상태에서는 환불신청할 수 없습니다.');
				return;
			}
			if (status == '02') {
				alert('이미 환불처리된 상태에서는 환불신청할 수 없습니다.');
				return;
			}
		}
		
		var validateResult = myValidator.validate();
		validateResult = true; //for test

		if (!validateResult) {
			var msg = myValidator.getErrorMessage();
			AXUtil.alert(msg);
			myValidator.getErrorElement().focus();
			return false;
		} else {
			if ($("#refundDepositor").val().length == 0) {
				alert('예금주명을 입력해 주시기 바랍니다.');
				$("#refundDepositor").focus();
				return false;
			}
			
			if($("#searchRefundCode").val() == '') {
				alert('환불사유를 선택해 주시기 바랍니다.');
				$("#searchRefundCode").focus();
				return false;
			}
			
			if ($("#useEndDate").val().length == 0) {
				alert('이용종료일자를 선택해 주시기 바랍니다.');
				$("#useEndDate").focus();
				return false;
			}
			
			if($("#searchBankCode").val() == '') {
				alert('은행 명을 선택해 주시기 바랍니다.');
				$("#searchBankCode").focus();
				return false;
			}

			if ($("#depositNo").val().length == 0) {
				alert('계좌번호를 입력해주시기 바랍니다.');
				$("#depositNo").focus();
				return false;
			}
			
			if($("#chkAgree1").prop("checked") == false) {
				alert('개인정보의 수집이용에 관한 일반사항에 동의해 주시기 바랍니다.');
				$("#chkAgree1").focus();
				return false;
			}
			
			if($("#chkAgree2").prop("checked") == false) {
				alert('동의하지 않을 권리 및 미동의시 불이익에 동의해 주시기 바랍니다.');
				$("#chkAgree2").focus();
				return false;
			}

			if($("#chkAgree3").prop("checked") == false) {
				alert('모두 동의함에 동의해 주시기 바랍니다.');
				$("#chkAgree3").focus();
				return false;
			}
			
			if(confirm("환불 신청 시 승인 후 약 2주 후 환불 처리됩니다.\r환불 신청 하시겠습니까?") == false) {
				return;
			}

			$.ajaxSettings.traditional = true;
			$.ajax({
			    url : "/mypage/refundRequest.json",
			    type: "POST", 
			    data: $('#frm').serialize(),
			    dataType:"json", 
			    success : function(data, textStatus, jqXHR) {
			        if (data.result == "OK") {
			            axf.alert("환불 신청을 완료하였습니다.");
			            
			            $('#contractMenu').submit();
			        } else {
			            axf.alert("환불 신청중 오류가 발생했습니다. 관리자에게 문의해주세요.");
			        }
			    },
			    error : function(jqXHR, textStatus, errorThrown){
			        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
			    }
			});
		}
	}
</script>

</head>
<body>
	<div id="Page" class="page mypage">
		<div class="ct_head">
			<div class="head">
				<div class="title">
					<h1>나의 주차정보</h1>
					<h2>
						<i class="axi axi-keyboard-arrow-right"></i>거주자 환불신청
					</h2>
				</div>
				<div class="log in">
					<!-- 로그인 이전 -->
					<sec:authorize access="isAnonymous()">
						<div class="in">
							<a class="join"
								href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
						</div>
					</sec:authorize>
					<!-- 로그인 이후 -->
					<sec:authorize access="isAuthenticated()">
						<div class="out">
							<sec:authentication var="user" property="principal" />
							<p>
								<span>${user.mberNm}</span>님 환영합니다!
							</p>
							<a class="btn red" href="<c:url value='/logout'/>">로그아웃</a>
						</div>
					</sec:authorize>
				</div>
			</div>
		</div>
		<div class="ct_body">
			<div class="sub_nav">
				<ul>
					<li><a
						href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
					<li><a class="on"
						href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
					<li><a
						href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
					<li><a
						href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
					<li><a
						href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
				</ul>
			</div>

			<div class="body">
				<div class="caption">
					<p>거주자 우선주차 계약 후 결제를 환불신청 할 수 있습니다.</p>
					<p>본인의 차량번호를 입력하여 환불 신청할 항목을 검색해 주십시오.</p>
				</div>

				<form name="contractMenu" id="contractMenu"	action="${pageContext.request.contextPath}/res/parkingIntro.c"></form>

				<form name="searchFrm" id="searchFrm">
					<!-- 주차요금 검색 -->
					<div class="bd_title">
						<i class="axi axi-label"></i>
						<p>환불신청 차량 검색</p>
					</div>
					<div class="block">
						<div class="line">
							<label for="">차량번호</label> <input type="text"
								name="searchCarNumber" id="searchCarNumber" maxlength="15"
								class="AXInput" /> <a class="btn dblue" onclick="searchGrid();">차량번호
								검색</a>
						</div>
					</div>
					<!-- 주차요금 검색 : END -->
				</form>

				<!-- 미수 또는 무단주차로 발생된 결제정보 -->
				<div class="bd_title">
					<i class="axi axi-label"></i>
					<p>거주자 우선주차 계약정보</p>
				</div>
				<div class="table_box">
					<div id="grid1" style="height: 250px;"></div>
					<!-- 그리드 부르기 전 마스크 처리 -->
					<div class="before_mask" style="line-height: 250px;">차량번호 입력
						후 검색 버튼을 눌러주세요.</div>
				</div>

				<form name="frm" id="frm" method=post>
					<input type="hidden" id="purchaseKey" name="purchaseKey" /> 
					<input type="hidden" id="paymentKey" name="paymentKey" />
					<input type="hidden" id="refundAmount" name="refundAmount" />

					<div class="bd_title">
						<i class="axi axi-label"></i>
						<p>환불신청 필수 입력값</p>
					</div>
					<!-- 테이블 박스 -->
					<div class="block">
						<div class="line">
							<label for="refundDepositor">예금주명</label> <input type="text"
								name="refundDepositor" id="refundDepositor" value=''
								title="예금주명" maxlength="50" class="AXInput" />

							<div class="axi_box">
								<label for="searchRefundCode">환불사유</label> <select
									id="searchRefundCode" name="searchRefundCode" isspace="true"
									isspaceTitle="선택" class="AXSelect"
									url="${pageContext.request.contextPath}/com/searchRefundCodeCombo.json"
									param="codeId=1" onChange="setRefundAll();"></select>
							</div>
						</div>
						<div class="line">
							<label for="useEndDate">이용종료일자</label> <input id="useEndDate"
								name="useEndDate" type="text" class="AXInput av-required"
								placeholder="이용종료일" label="이용종료일" readonly="readonly" /> <label
								for="refundAmt">환불금액</label> <input type="text" name="refundAmt"
								id="refundAmt" value='' title="환불금액" maxlength="20"
								class="AXInput" readonly="readonly" />
						</div>

						<div class="line">
							<label for="searchBankCode">은행 명</label> <select
								id="searchBankCode" name="searchBankCode" isspace="true"
								isspaceTitle="선택" class="AXSelect"
								url="${pageContext.request.contextPath}/com/searchBankCodeCombo.json"
								param="codeId=1"></select> <label for="depositNo">계좌번호</label> <input
								type="text" name="depositNo" id="depositNo" value=''
								title="계좌 번호" maxlength="40" class="AXInput" />
						</div>
					</div>
					<!-- 결제에 필요한 필수 입력 값 : END -->
				</form>

				<!-- 결제 방식 = 현재는 1개 신용카드결제 -->
				<div class="bd_title">
					<i class="axi axi-label"></i>
					<p>환불신청 개인정보 이용동의</p>
				</div>
				<!-- 테이블 박스 -->
				<div class="caption">
					<p style="font-weight:bold;font_size:41px;line-height:30px;">개인정보의 수집·이용에 관한 일반사항</p>
					<p style="text-indent:20px;">-개인정보의 수집·이용 목적 : 환불처리</p>
					<p style="text-indent:20px;">-수집·이용할 개인정보의 항목 : 성명, 차량번호, 계좌번호</p>
					<p style="text-indent:20px;">-개인정보의 보유 및 이용기간 : 5년(대금결제 및 재화등의 공급에 관한 기록)</p>
					<p style="text-indent:20px;">▶ 개인정보 제공 동의 <input name="chkAgree1" id="chkAgree1" type="checkbox" /><label for="chkAgree1"><span></span>동의함</label></p>


					<p style="font-weight:bold;font_size:41px;line-height:30px;padding-top:40px;">동의하지 않을 권리 및 미동의시 불이익</p>
					<p style="text-indent:20px;">-환불신청자는 개인정보의 수집·이용에 대한 동의를 거부할 권리가 있으나,</p>
					<p style="text-indent:20px;">동의하지 않을 경우 환불 접수가 거부될 수 있습니다.</p>
					<p style="text-indent:20px;">▶ 개인정보 제공 동의 <input name="chkAgree2" id="chkAgree2" type="checkbox" /><label for="chkAgree2"><span></span>동의함</label></p>

					<p style="font-weight:bold;font_size:41px;padding-top:40px;">본인은 개인정보 수집·이용에 관한 동의를 잘 읽어 보았으며 위 내용에 동의합니다.
						<input name="chkAgree3" id="chkAgree3" type="checkbox" /><label for="chkAgree3"><span></span>모두 동의함</label>
					</p>

				</div>


				<div class="page_btn">
					<a class="btn lgreen" onclick="saveRequest();">환불신청</a>
					<!-- 결제버튼 -->
					<!--<a class="btn">취소</a> 취소시 돌아갈 페이지 없음. 일단 주석처리 -->
				</div>
			</div>

		</div>
	</div>
</body>
</html>
