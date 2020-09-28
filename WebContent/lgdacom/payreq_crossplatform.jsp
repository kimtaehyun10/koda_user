<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.security.MessageDigest, java.util.*, java.text.*,java.io.InputStream" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%
	request.setCharacterEncoding("utf-8");
    /*
     * [결제 인증요청 페이지(STEP2-1)]
     *
     * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
     */

    /*
     * 1. 기본결제 인증요청 정보 변경
     *
     * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
     */
 	Properties props = new Properties(); 
 	InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
 	props.load(new java.io.BufferedInputStream(fis));

 	System.out.println("LGD_BUYER:"+request.getParameter("LGD_BUYER"));
    String productCd = request.getParameter("productCd");
    String pageCd = request.getParameter("pageCd");
    int iConfigCd = 0; //lgdacom1~3 config 파일 지시자와 연결된 번호
    
    String CST_MID = null;
    String LGD_MERTKEY = null;
    String payres = null;
    if(pageCd.equals("1")) { // from parkingContract.jsp
    	
		
		
//		if(productCd.equals("01"))    { // 거주자 우선
    		iConfigCd = 1;
    		CST_MID              = "dongjak04835"; 
    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY1").trim();
    		payres = "payres1.jsp";
    	} // else if(productCd.equals("02")) { //방문주차
//    		iConfigCd = 1;
//    		CST_MID              = "dongjak04835"; 
//    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY1").trim();
//    		payres = "payres1.jsp";
//    	}	else if(productCd.equals("03")) { //공영주차월정기
//    		iConfigCd = 2;
//    		CST_MID              = "dongjak104835"; 
//    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY2").trim();
//    		payres = "payres2.jsp";
//    	}
//    }
	
	else if(pageCd.equals("2")) { // from parkingCharge.jsp
//		if(productCd.equals("04")) { // 부정주차
			iConfigCd = 3;
			CST_MID              = "dongjak204835"; 
			LGD_MERTKEY          = props.getProperty("LGD_MERTKEY3").trim();
			payres = "payres3.jsp";
    	}
		
	 /*	
		else if(productCd.equals("05")) { //시간주차
    		iConfigCd = 2;
    		CST_MID              = "dongjak104835"; 
    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY2").trim();
    		payres = "payres2.jsp";
    	}
       */


 //   }
        		
    //String CST_PLATFORM         = "test";                 //LG유플러스 결제서비스 선택(test:테스트, service:서비스)
    String CST_PLATFORM         = props.getProperty("CST_PLATFORM").trim(); //"service"; //service:서비스

	//String CST_MID              = "dongjak04835";                      //LG유플러스로 부터 발급받으신 상점아이디를 입력하세요.
    
	
	
	String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //테스트 아이디는 't'를 제외하고 입력하세요.
                                                                                        //상점아이디(자동생성)
    String LGD_OID              = request.getParameter("LGD_OID");                      //주문번호(상점정의 유니크한 주문번호를 입력하세요)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //결제금액("," 를 제외한 결제금액을 입력하세요)
    //String LGD_MERTKEY          = props.getProperty("LGD_MERTKEY").trim(); // "d5bf5ae423cdf4e77adf4cb9630e4855";                  	//상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //구매자명
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //상품명
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //구매자 이메일
    Date now = new Date();
    SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMddHHmmss");
    String LGD_TIMESTAMP        = format1.format(now); //request.getParameter("LGD_TIMESTAMP");                //타임스탬프
    String LGD_CUSTOM_USABLEPAY = "SC0010"; // 신용카드 request.getParameter("LGD_CUSTOM_USABLEPAY");        	//상점정의 초기결제수단
    String LGD_CUSTOM_SKIN      = "red";                                                //상점정의 결제창 스킨(red, yellow, purple)
    String LGD_CUSTOM_SWITCHINGTYPE = "IFRAME"; // request.getParameter("LGD_CUSTOM_SWITCHINGTYPE"); //신용카드 카드사 인증 페이지 연동 방식 (수정불가)
    String LGD_WINDOW_VER		= "2.5";												//결제창 버젼정보
    String LGD_WINDOW_TYPE      = "iframe"; // request.getParameter("LGD_WINDOW_TYPE");               //결제창 호출 방식 (수정불가)

    /*
     * 가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다.
     */
    //String LGD_CASNOTEURL		= "http://221.149.1.134:8090/lgdacom/cas_noteurl.jsp"; //test
    String LGD_CASNOTEURL		= props.getProperty("LGD_CASNOTEURL").trim(); //"http://221.149.1.134:8090/lgdacom/cas_noteurl.jsp"; //service

    /*
     * LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
     */
    //String LGD_RETURNURL		= "http://221.149.1.134:8090/lgdacom/returnurl.jsp";// test FOR MANUAL
    String LGD_RETURNURL		= props.getProperty("LGD_RETURNURL").trim(); //"http://221.149.1.134:8090/lgdacom/returnurl.jsp"; // service
    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
     *
     * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
     *************************************************
     *
     * 해쉬 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : 상점아이디
     * LGD_OID          : 주문번호
     * LGD_AMOUNT       : 금액
     * LGD_TIMESTAMP    : 타임스탬프
     * LGD_MERTKEY      : 상점MertKey (mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인하실수 있습니다)
     *
     * MD5 해쉬데이터 암호화 검증을 위해
     * LG유플러스에서 발급한 상점키(MertKey)를 환경설정 파일(lgdacom/conf/mall.conf)에 반드시 입력하여 주시기 바랍니다.
     */
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i=0 ; i < digest.length ; i++) {
        int c = digest[i] & 0xff;
        if (c <= 15){
            strBuf.append("0");
        }
        strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
    String LGD_CUSTOM_PROCESSTYPE = "TWOTR";
    /*
     *************************************************
     * 2. MD5 해쉬암호화 (수정하지 마세요) - END
     *************************************************
     */
     
     
     
     
  	 Map payReqMap = new HashMap();
     
     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM );                   	// 테스트, 서비스 구분
     payReqMap.put("CST_MID"                     , CST_MID );                        	// 상점아이디
     payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                        	
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// 상점아이디
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// 주문번호
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// 구매자
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// 상품정보
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// 결제금액
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// 구매자 이메일
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// 결제창 SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// 트랜잭션 처리방식
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// 타임스탬프
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 해쉬암호값
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// 응답수신페이지
     payReqMap.put("LGD_VERSION"         		, "JSP_SmartXPay_1.0");			   	   	// 버전정보 (삭제하지 마세요)
     payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// 디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)
     payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// 신용카드 카드사 인증 페이지 연동 방식
     payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// 결제창 버젼정보 

     
     // 가상계좌(무통장) 결제연동을 하시는 경우  할당/입금 결과를 통보받기 위해 반드시 LGD_CASNOTEURL 정보를 LG 유플러스에 전송해야 합니다 .
     payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // 가상계좌 NOTEURL

    /*Return URL에서 인증 결과 수신 시 셋팅될 파라미터 입니다.*/
	 payReqMap.put("LGD_RESPCODE"  		 , "" );
	 payReqMap.put("LGD_RESPMSG"  		 , "" );
	 payReqMap.put("LGD_PAYKEY"  		 , "" );

	 session.setAttribute("PAYREQ_MAP", payReqMap);

 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>전자결제서비스</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub_nam.css"/>

<script language="javascript" src="https://xpay.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<script type="text/javascript">

/*
* 수정불가.
*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	var lgdwin = '';
	
/*
* 수정불가
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
	
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
		
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
		
			document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			document.getElementById("LGD_PAYINFO").target = "_self";
			document.getElementById("LGD_PAYINFO").action = "<%=payres%>";
			document.getElementById("LGD_PAYINFO").submit();
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

</script>
</head>
<body>
<div class="wrap">

    <form name="selectOne" method="post">
        <input name="menuNo" type="hidden" value="${resultVO.tempInt}"/>
        <input name="chkURL" type="hidden" value=""/>
    </form>

    <!-- #header_wrap : S -->
    <!-- #header : S -->
    <div class="header">
        <div class="header_in">
            <div class="logo">
                <a href="javascript:fn_MovePage('/main');">
                    <img src="${pageContext.request.contextPath}/resource/images/logo.png" alt="동작구시설관리공단 주차시설" />
                </a>
            </div>

            <div class="nav">
                <ul>
                    <li class="res">
                        <a>거주자우선주차</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
                            <li><a href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
                            <li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
                            <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
                            <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                            <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                            <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
                        </ul>
                    </li>
                    <li class="vis">
                        <a>방문주차</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
                            <li><a href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
                        </ul>
                    </li>
                    <li class="pub">
                        <a>공영주차</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
                            <li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
                            <li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
                            <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
                            <li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
                        </ul>
                    </li>
                    <li class="reg">
                        <a>견인보관소</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소안내</a></li>
                        </ul>
                    </li>
                    <li class="inf">
                        <a>나의 주차정보</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
                        </ul>
                    </li>
                    <li class="cus">
                        <a>고객지원</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
                        </ul>
                    </li>
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
                    <div class="log">
                        <!-- 로그인 이전 -->
                        <sec:authorize access="isAnonymous()">
                            <div class="in">
                                <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
                            </div>
                        </sec:authorize>
                        <!-- 로그인 이후 -->
                        <sec:authorize access="isAuthenticated()">
                            <div class="out">
                                <p><span>${user.mberNm}</span>님 환영합니다!</p>
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
                        <p>전자결제 서비스 정보</p>
                    </div>
                    <form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="<%=payres%>">
                        <div class="table_box">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th width="30%">항목</th>
                                        <th width="70%">결제정보</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>구매자 이름 </th>
                                        <td><%= LGD_BUYER %></td>
                                    </tr>
                                    <tr>
                                        <th>상품정보 </th>
                                        <td><%= LGD_PRODUCTINFO %></td>
                                    </tr>
                                    <tr>
                                        <th>결제금액 </th>
                                        <td><%= LGD_AMOUNT %></td>
                                    </tr>
                                    <tr>
                                        <th>구매자 이메일 </th>
                                        <td><%= LGD_BUYEREMAIL %></td>
                                    </tr>
                                    <tr>
                                        <th>주문번호 </th>
                                        <td><%= LGD_OID %></td>
                                    </tr>
                                </tbody>
                            </table>
                            <%
                                for(Iterator i = payReqMap.keySet().iterator(); i.hasNext();){
                                    Object key = i.next();
                                    out.println("<input type='hidden' name='" + key + "' id='"+key+"' value='" + payReqMap.get(key) + "'>" );
                                }
                            %>
                        </div>
                    </form>

                    <div class="page_btn">
                        <a class="btn lgreen" onclick="launchCrossPlatform();">신용카드결제</a><!-- 인증요청 -->
                    </div>
                </div>
            </div>
        </div>

        <div id="footer">
            <div class="section">
            </div>
        </div>
    </div>

</div>
</body>

</html>
