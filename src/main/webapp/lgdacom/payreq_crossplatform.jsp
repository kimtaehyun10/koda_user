<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.security.MessageDigest, java.util.*, java.text.*,java.io.InputStream" %>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%
	request.setCharacterEncoding("utf-8");
    /*
     * [���� ������û ������(STEP2-1)]
     *
     * ���������������� �⺻ �Ķ���͸� ���õǾ� ������, ������ �ʿ��Ͻ� �Ķ���ʹ� �����޴����� �����Ͻþ� �߰� �Ͻñ� �ٶ��ϴ�.
     */

    /*
     * 1. �⺻���� ������û ���� ����
     *
     * �⺻������ �����Ͽ� �ֽñ� �ٶ��ϴ�.(�Ķ���� ���޽� POST�� ����ϼ���)
     */
 	Properties props = new Properties(); 
 	InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
 	props.load(new java.io.BufferedInputStream(fis));

 	System.out.println("LGD_BUYER:"+request.getParameter("LGD_BUYER"));
    String productCd = request.getParameter("productCd");
    String pageCd = request.getParameter("pageCd");
    int iConfigCd = 0; //lgdacom1~3 config ���� �����ڿ� ����� ��ȣ
    
    String CST_MID = null;
    String LGD_MERTKEY = null;
    String payres = null;
    if(pageCd.equals("1")) { // from parkingContract.jsp
    	
		
		
//		if(productCd.equals("01"))    { // ������ �켱
    		iConfigCd = 1;
    		CST_MID              = "dongjak04835"; 
    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY1").trim();
    		payres = "payres1.jsp";
    	} // else if(productCd.equals("02")) { //�湮����
//    		iConfigCd = 1;
//    		CST_MID              = "dongjak04835"; 
//    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY1").trim();
//    		payres = "payres1.jsp";
//    	}	else if(productCd.equals("03")) { //��������������
//    		iConfigCd = 2;
//    		CST_MID              = "dongjak104835"; 
//    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY2").trim();
//    		payres = "payres2.jsp";
//    	}
//    }
	
	else if(pageCd.equals("2")) { // from parkingCharge.jsp
//		if(productCd.equals("04")) { // ��������
			iConfigCd = 3;
			CST_MID              = "dongjak204835"; 
			LGD_MERTKEY          = props.getProperty("LGD_MERTKEY3").trim();
			payres = "payres3.jsp";
    	}
		
	 /*	
		else if(productCd.equals("05")) { //�ð�����
    		iConfigCd = 2;
    		CST_MID              = "dongjak104835"; 
    		LGD_MERTKEY          = props.getProperty("LGD_MERTKEY2").trim();
    		payres = "payres2.jsp";
    	}
       */


 //   }
        		
    //String CST_PLATFORM         = "test";                 //LG���÷��� �������� ����(test:�׽�Ʈ, service:����)
    String CST_PLATFORM         = props.getProperty("CST_PLATFORM").trim(); //"service"; //service:����

	//String CST_MID              = "dongjak04835";                      //LG���÷����� ���� �߱޹����� �������̵� �Է��ϼ���.
    
	
	
	String LGD_MID              = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;  //�׽�Ʈ ���̵�� 't'�� �����ϰ� �Է��ϼ���.
                                                                                        //�������̵�(�ڵ�����)
    String LGD_OID              = request.getParameter("LGD_OID");                      //�ֹ���ȣ(�������� ����ũ�� �ֹ���ȣ�� �Է��ϼ���)
    String LGD_AMOUNT           = request.getParameter("LGD_AMOUNT");                   //�����ݾ�("," �� ������ �����ݾ��� �Է��ϼ���)
    //String LGD_MERTKEY          = props.getProperty("LGD_MERTKEY").trim(); // "d5bf5ae423cdf4e77adf4cb9630e4855";                  	//����MertKey(mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
    String LGD_BUYER            = request.getParameter("LGD_BUYER");                    //�����ڸ�
    String LGD_PRODUCTINFO      = request.getParameter("LGD_PRODUCTINFO");              //��ǰ��
    String LGD_BUYEREMAIL       = request.getParameter("LGD_BUYEREMAIL");               //������ �̸���
    Date now = new Date();
    SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMddHHmmss");
    String LGD_TIMESTAMP        = format1.format(now); //request.getParameter("LGD_TIMESTAMP");                //Ÿ�ӽ�����
    String LGD_CUSTOM_USABLEPAY = "SC0010"; // �ſ�ī�� request.getParameter("LGD_CUSTOM_USABLEPAY");        	//�������� �ʱ��������
    String LGD_CUSTOM_SKIN      = "red";                                                //�������� ����â ��Ų(red, yellow, purple)
    String LGD_CUSTOM_SWITCHINGTYPE = "IFRAME"; // request.getParameter("LGD_CUSTOM_SWITCHINGTYPE"); //�ſ�ī�� ī��� ���� ������ ���� ��� (�����Ұ�)
    String LGD_WINDOW_VER		= "2.5";												//����â ��������
    String LGD_WINDOW_TYPE      = "iframe"; // request.getParameter("LGD_WINDOW_TYPE");               //����â ȣ�� ��� (�����Ұ�)

    /*
     * �������(������) ���� ������ �Ͻô� ��� �Ʒ� LGD_CASNOTEURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�.
     */
    //String LGD_CASNOTEURL		= "http://221.149.1.134:8090/lgdacom/cas_noteurl.jsp"; //test
    String LGD_CASNOTEURL		= props.getProperty("LGD_CASNOTEURL").trim(); //"http://221.149.1.134:8090/lgdacom/cas_noteurl.jsp"; //service

    /*
     * LGD_RETURNURL �� �����Ͽ� �ֽñ� �ٶ��ϴ�. �ݵ�� ���� �������� ������ ����Ʈ�� ��  ȣ��Ʈ�̾�� �մϴ�. �Ʒ� �κ��� �ݵ�� �����Ͻʽÿ�.
     */
    //String LGD_RETURNURL		= "http://221.149.1.134:8090/lgdacom/returnurl.jsp";// test FOR MANUAL
    String LGD_RETURNURL		= props.getProperty("LGD_RETURNURL").trim(); //"http://221.149.1.134:8090/lgdacom/returnurl.jsp"; // service
    /*
     *************************************************
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - BEGIN
     *
     * MD5 �ؽ���ȣȭ�� �ŷ� �������� �������� ����Դϴ�.
     *************************************************
     *
     * �ؽ� ��ȣȭ ����( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY )
     * LGD_MID          : �������̵�
     * LGD_OID          : �ֹ���ȣ
     * LGD_AMOUNT       : �ݾ�
     * LGD_TIMESTAMP    : Ÿ�ӽ�����
     * LGD_MERTKEY      : ����MertKey (mertkey�� ���������� -> ������� -> ���������������� Ȯ���ϽǼ� �ֽ��ϴ�)
     *
     * MD5 �ؽ������� ��ȣȭ ������ ����
     * LG���÷������� �߱��� ����Ű(MertKey)�� ȯ�漳�� ����(lgdacom/conf/mall.conf)�� �ݵ�� �Է��Ͽ� �ֽñ� �ٶ��ϴ�.
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
     * 2. MD5 �ؽ���ȣȭ (�������� ������) - END
     *************************************************
     */
     
     
     
     
  	 Map payReqMap = new HashMap();
     
     payReqMap.put("CST_PLATFORM"                , CST_PLATFORM );                   	// �׽�Ʈ, ���� ����
     payReqMap.put("CST_MID"                     , CST_MID );                        	// �������̵�
     payReqMap.put("LGD_WINDOW_TYPE"             , LGD_WINDOW_TYPE );                        	
     payReqMap.put("LGD_MID"                     , LGD_MID );                        	// �������̵�
     payReqMap.put("LGD_OID"                     , LGD_OID );                        	// �ֹ���ȣ
     payReqMap.put("LGD_BUYER"                   , LGD_BUYER );                      	// ������
     payReqMap.put("LGD_PRODUCTINFO"             , LGD_PRODUCTINFO );                	// ��ǰ����
     payReqMap.put("LGD_AMOUNT"                  , LGD_AMOUNT );                     	// �����ݾ�
     payReqMap.put("LGD_BUYEREMAIL"              , LGD_BUYEREMAIL );                 	// ������ �̸���
     payReqMap.put("LGD_CUSTOM_SKIN"             , LGD_CUSTOM_SKIN );                	// ����â SKIN
     payReqMap.put("LGD_CUSTOM_PROCESSTYPE"      , LGD_CUSTOM_PROCESSTYPE );         	// Ʈ����� ó�����
     payReqMap.put("LGD_TIMESTAMP"               , LGD_TIMESTAMP );                  	// Ÿ�ӽ�����
     payReqMap.put("LGD_HASHDATA"                , LGD_HASHDATA );      	           	// MD5 �ؽ���ȣ��
     payReqMap.put("LGD_RETURNURL"   			, LGD_RETURNURL );      			   	// �������������
     payReqMap.put("LGD_VERSION"         		, "JSP_SmartXPay_1.0");			   	   	// �������� (�������� ������)
     payReqMap.put("LGD_CUSTOM_USABLEPAY"  		, LGD_CUSTOM_USABLEPAY );				// ����Ʈ �������� (�ش� �ʵ带 ������ ������ �������� ���� UI �� ���̰� �˴ϴ�.)
     payReqMap.put("LGD_CUSTOM_SWITCHINGTYPE"  	, LGD_CUSTOM_SWITCHINGTYPE );			// �ſ�ī�� ī��� ���� ������ ���� ���
     payReqMap.put("LGD_WINDOW_VER"  			, LGD_WINDOW_VER );						// ����â �������� 

     
     // �������(������) ���������� �Ͻô� ���  �Ҵ�/�Ա� ����� �뺸�ޱ� ���� �ݵ�� LGD_CASNOTEURL ������ LG ���÷����� �����ؾ� �մϴ� .
     payReqMap.put("LGD_CASNOTEURL"          , LGD_CASNOTEURL );               // ������� NOTEURL

    /*Return URL���� ���� ��� ���� �� ���õ� �Ķ���� �Դϴ�.*/
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

<title>���ڰ�������</title>

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
* �����Ұ�.
*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	var lgdwin = '';
	
/*
* �����Ұ�
*/
function launchCrossPlatform(){
	lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
}
/*
* FORM ��  ���� ����
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * ������� ó��
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
		alert("LGD_RESPCODE (����ڵ�) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (����޽���): " + fDoc.document.getElementById('LGD_RESPMSG').value);
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
                    <img src="${pageContext.request.contextPath}/resource/images/logo.png" alt="���۱��ü��������� �����ü�" />
                </a>
            </div>

            <div class="nav">
                <ul>
                    <li class="res">
                        <a>�����ڿ켱����</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/res/parkingIntro.c');">������Ұ�</a></li>
                            <li><a href="javascript:fn_MovePage('/res/enforcementBasis.c');">����ٰ�</a></li>
                            <li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">�ܼӱٰ�</a></li>
                            <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">��������Ȳ</a></li>
                            <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">�����������Ұ�</a></li>
                            <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">��ݳ��ξȳ�</a></li>
                            <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">�̿��û</a></li>
                        </ul>
                    </li>
                    <li class="vis">
                        <a>�湮����</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/vst/visitParking.c');">�湮�����Ұ�</a></li>
                            <li><a href="javascript:fn_MovePage('/vst/visitRequest.c');">�̿��û</a></li>
                        </ul>
                    </li>
                    <li class="pub">
                        <a>��������</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/pub/parkingIntro.c');">������Ұ�</a></li>
                            <li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">��������Ȳ</a></li>
                            <li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">�̳���ݾȳ�</a></li>
                            <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">�̿�ȳ�</a></li>-->
                            <li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">�̿��û</a></li>
                        </ul>
                    </li>
                    <li class="reg">
                        <a>���κ�����</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/tow/towStorageInfo.c');">���κ����Ҿȳ�</a></li>
                        </ul>
                    </li>
                    <li class="inf">
                        <a>���� ��������</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">������ݰ���</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">������ȯ�ҽ�û</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">�����Ȳ��ȸ</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">��������</a></li>
                            <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">ȸ��Ż��</a></li>
                        </ul>
                    </li>
                    <li class="cus">
                        <a>������</a>
                        <ul>
                            <li><a href="javascript:fn_MovePage('/sup/notice.c');">��������</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/qna.c');">���ֹ�������</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">��ȭ��ȣ�ȳ�</a></li>
                            <li><a href="javascript:fn_MovePage('/sup/visitMap.c');">ã�ƿ��ô±�</a></li>
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
                        <h1>���ڰ�������</h1>
                        <!--<h2><i class="axi axi-keyboard-arrow-right"></i>��������/����</h2>-->
                    </div>
                    <div class="log">
                        <!-- �α��� ���� -->
                        <sec:authorize access="isAnonymous()">
                            <div class="in">
                                <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">ȸ������</a>
                            </div>
                        </sec:authorize>
                        <!-- �α��� ���� -->
                        <sec:authorize access="isAuthenticated()">
                            <div class="out">
                                <p><span>${user.mberNm}</span>�� ȯ���մϴ�!</p>
                                <a class="btn red" href="<c:url value='/logout'/>">�α׾ƿ�</a>
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body full">
                    <div class="bd_title">
                        <i class="axi axi-label"></i>
                        <p>���ڰ��� ���� ����</p>
                    </div>
                    <form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO" action="<%=payres%>">
                        <div class="table_box">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th width="30%">�׸�</th>
                                        <th width="70%">��������</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>������ �̸� </th>
                                        <td><%= LGD_BUYER %></td>
                                    </tr>
                                    <tr>
                                        <th>��ǰ���� </th>
                                        <td><%= LGD_PRODUCTINFO %></td>
                                    </tr>
                                    <tr>
                                        <th>�����ݾ� </th>
                                        <td><%= LGD_AMOUNT %></td>
                                    </tr>
                                    <tr>
                                        <th>������ �̸��� </th>
                                        <td><%= LGD_BUYEREMAIL %></td>
                                    </tr>
                                    <tr>
                                        <th>�ֹ���ȣ </th>
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
                        <a class="btn lgreen" onclick="launchCrossPlatform();">�ſ�ī�����</a><!-- ������û -->
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
