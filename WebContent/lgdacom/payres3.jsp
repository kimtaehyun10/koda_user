<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page
	import="lgdacom.XPayClient.XPayClient, java.util.*, java.text.*,java.io.InputStream"%>
<%@ page import="com.koticobui.dfmc.client.com.util.Payment"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%
request.setCharacterEncoding("euc-kr");
    /*
     * [최종결제요청 페이지(STEP2-2)]
     *
     * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
     */

	/* ※ 중요
	* 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
	* 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
	* 예) [Window 계열] C:\inetpub\wwwroot\lgdacom ==> 절대불가(웹 디렉토리)
	*/
	Properties props = new Properties(); 
 	InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
 	props.load(new java.io.BufferedInputStream(fis));
 	
    String configPath = props.getProperty("configPath3").trim(); //"C:/lgdacom";  //for test, LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf,/conf/mall.conf") 위치 지정.
    //String configPath = "/home/koco/lgdacom"; // for service
    boolean isSuccess = false;
    String ResCode = "";
    String messageStr = "";
    String purchaseKey = "";
    
    /*
     *************************************************
     * 1.최종결제 요청 - BEGIN
     *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");

    //해당 API를 사용하기 위해 WEB-INF/lib/XPayClient.jar 를 Classpath 로 등록하셔야 합니다. 
    XPayClient xpay = new XPayClient();
   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

   	if( !isInitOK ) {
    	//API 초기화 실패 화면처리
        System.out.println( "결제요청을 초기화 하는데 실패하였습니다.<br>");
        System.out.println( "LG유플러스에서 제공한 환경파일이 정상적으로 설치 되었는지 확인하시기 바랍니다.<br>");        
        System.out.println( "mall.conf에는 Mert ID = Mert Key 가 반드시 등록되어 있어야 합니다.<br><br>");
        System.out.println( "문의전화 LG유플러스 1544-7772<br>");
        return;
   	
   	}else{      
   		try{
   			/*
   	   	     *************************************************
   	   	     * 1.최종결제 요청(수정하지 마세요) - END
   	   	     *************************************************
   	   	     */
	    	xpay.Init_TX(LGD_MID);
	    	xpay.Set("LGD_TXNAME", "PaymentByKey");
	    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
	    
	    	//금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
	    	//String DB_AMOUNT = "DB나 세션에서 가져온 금액"; //반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
	    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
	    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
	    
    	}catch(Exception e) {
    		System.out.println("LG유플러스 제공 API를 사용할 수 없습니다. 환경파일 설정을 확인해 주시기 바랍니다. ");
    		System.out.println(""+e.getMessage());    	
    		return;
    	}
   	}

    /*
     * 2. 최종결제 요청 결과처리
     *
     * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
     */
     if ( xpay.TX() ) {
         //1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
         System.out.println( "결제요청이 완료되었습니다.  <br>");
         System.out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
         System.out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");
         
         System.out.println("거래번호 : " + xpay.Response("LGD_TID",0) + "<br>");
         System.out.println("상점아이디 : " + xpay.Response("LGD_MID",0) + "<br>");
         System.out.println("상점주문번호 : " + xpay.Response("LGD_OID",0) + "<br>");
         System.out.println("결제금액 : " + xpay.Response("LGD_AMOUNT",0) + "<br>");
         System.out.println("결과코드 : " + xpay.Response("LGD_RESPCODE",0) + "<br>");
         System.out.println("결과메세지 : " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         
         for (int i = 0; i < xpay.ResponseNameCount(); i++)
         {
        	 System.out.println(xpay.ResponseName(i) + " = ");
             for (int j = 0; j < xpay.ResponseCount(); j++)
             {
            	 System.out.println("\t" + xpay.Response(xpay.ResponseName(i), j) + "<br>");
             }
         }
         System.out.println("<p>");
         
         if( "0000".equals( xpay.m_szResCode ) ) {
         	//최종결제요청 결과 성공 DB처리
         	System.out.println("최종결제요청 결과 성공 DB처리하시기 바랍니다.<br>");
         	
         	HashMap map = new HashMap(); 
         	map.put("purchaseKey",xpay.Response("LGD_OID",0));
         	map.put("payAmt",xpay.Response("LGD_AMOUNT",0));
         	Date now = new Date();
            SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
            String payDate        = format1.format(now);
         	map.put("payDate",payDate);
         	Payment pay = new Payment();
         	
         	Map result = pay.savePay(map);
         	String msg = (String) result.get("result");
         	
         	System.out.println("DB처리결과:" + msg);

         	//최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
         	boolean isDBOK = true; //DB처리 실패시 false로 변경해 주세요.
         	if(	!msg.equals("OK") ) {
         		isDBOK = false;
         	}
         	
         	if( !isDBOK ) {
         		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
         		
         		System.out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
         		System.out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         		
                 if( "0000".equals( xpay.m_szResCode ) ) {
                	 System.out.println("자동취소가 정상적으로 완료 되었습니다.<br>");
                 }else{
                	 System.out.println("자동취소가 정상적으로 처리되지 않았습니다.<br>");
                 }
          		ResCode = xpay.m_szResCode;
          		messageStr = "결제 결과를 DB에 저장하는 것이 실패했습니다.";
          		purchaseKey = xpay.Response("LGD_OID",0);                 
         	} else {
         		// 디자인할 영역
         		isSuccess = true;
         		ResCode = xpay.m_szResCode;
         		messageStr = "결제에 성공했습니다.";
         		purchaseKey = xpay.Response("LGD_OID",0);
         		
         		System.out.println("결제에 성공했습니다.");
         		System.out.println("수납번호:" + xpay.Response("LGD_OID",0));
         		System.out.println("결과 메세지:" + xpay.Response("LGD_RESPMSG",0));
         		
         		
         	}
         }else{
         	//최종결제요청 결과 실패 DB처리
         	ResCode = xpay.m_szResCode;
         	messageStr = xpay.Response("LGD_RESPMSG",0);
         	purchaseKey = xpay.Response("LGD_OID",0);
         	
         	System.out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");            	
         }
     }else {
         //2)API 요청실패 화면처리
         ResCode = xpay.m_szResCode;
         messageStr = xpay.m_szResMsg;
         
         System.out.println( "결제요청이 실패하였습니다.  <br>");
         System.out.println( "TX 결제요청 Response_code = " + xpay.m_szResCode + "<br>");
         System.out.println( "TX 결제요청 Response_msg = " + xpay.m_szResMsg + "<p>");
         
     	//최종결제요청 결과 실패 DB처리
     	System.out.println("최종결제요청 결과 실패 DB처리하시기 바랍니다.<br>");            	            
     }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>전자결제서비스</title>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/common.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/main.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/sub.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/sub_nam.css" />
</head>
<body>
	<div class="wrap">

		<form name="selectOne" method="post">
			<input name="menuNo" type="hidden" value="${resultVO.tempInt}" /> <input
				name="chkURL" type="hidden" value="" />
		</form>

		<!-- #header_wrap : S -->
		<!-- #header : S -->
		<div class="header">
			<div class="header_in">
				<div class="logo">
					<a href="javascript:fn_MovePage('/main');"><h1>
							DFMC <span>D-parking System</span>
						</h1></a>
				</div>

				<div class="nav">
					<ul>
						<li class="res"><a>거주자우선주차</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">미납요금안내</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="vis"><a>방문주차</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="pub"><a>공영주차</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
								<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="reg"><a>견인보관소</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소안내</a></li>
							</ul></li>
						<li class="inf"><a>나의 주차정보</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
							</ul></li>
						<li class="cus"><a>고객지원</a>
							<ul>
								<li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
								<li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
								<li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
								<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="Contents" class="contents">
			<div id="Page" class="page mypage">
				<div class="ct_head">
					<div class="head">
						<div class="title">
							<h1>전자결제서비스</h1>
							<!--<h2><i class="axi axi-keyboard-arrow-right"></i>주차장계약/결제</h2>-->
						</div>
						<div class="log out">
							<!-- 로그인 / 아웃 -->
							<!-- 로그인 이전 -->
							<sec:authorize access="isAnonymous()">
								<div class="in">
									<a class="join"
										href="javascript:fn_MovePage('/mem/memberJoin.c');">회원가입</a>
								</div>
							</sec:authorize>
							<!-- 로그인 이후 -->
							<sec:authorize access="isAuthenticated()">
								<div class="out">
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
					<div class="body full">
						<div class="bd_title">
							<i class="axi axi-label"></i>
							<p>전자결제 결과 정보</p>
						</div>
						<div class="table_box">
							<table class="table">
								<thead>
									<tr>
										<th width="30%">항목</th>
										<th width="70%">정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>결제 결과 코드</th>
										<td><%= ResCode %></td>
									</tr>
									<tr>
										<th>결제 결과 메세지</th>
										<td><%= messageStr %></td>
									</tr>
									<tr>
										<th>수납번호</th>
										<td><%= purchaseKey %></td>
									</tr>
								</tbody>
							</table>
						</div>


						<div class="page_btn">
							<a href='/' class="btn lgreen">홈으로 이동</a>
						</div>
					</div>
				</div>
			</div>

			<div id="footer">
				<div class="section"></div>
			</div>
		</div>

	</div>
</body>

</html>
