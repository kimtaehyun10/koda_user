<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page
	import="lgdacom.XPayClient.XPayClient, java.util.*, java.text.*,java.io.InputStream"%>
<%@ page import="com.koticobui.dfmc.client.com.util.Payment"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%
request.setCharacterEncoding("euc-kr");
    /*
     * [����������û ������(STEP2-2)]
     *
     * LG���÷������� ���� �������� LGD_PAYKEY(����Key)�� ������ ���� ������û.(�Ķ���� ���޽� POST�� ����ϼ���)
     */

	/* �� �߿�
	* ȯ�漳�� ������ ��� �ݵ�� �ܺο��� ������ ������ ��ο� �νø� �ȵ˴ϴ�.
	* �ش� ȯ�������� �ܺο� ������ �Ǵ� ��� ��ŷ�� ������ �����ϹǷ� �ݵ�� �ܺο��� ������ �Ұ����� ��ο� �νñ� �ٶ��ϴ�. 
	* ��) [Window �迭] C:\inetpub\wwwroot\lgdacom ==> ����Ұ�(�� ���丮)
	*/
	Properties props = new Properties(); 
 	InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
 	props.load(new java.io.BufferedInputStream(fis));
 	
    String configPath = props.getProperty("configPath3").trim(); //"C:/lgdacom";  //for test, LG���÷������� ������ ȯ������("/conf/lgdacom.conf,/conf/mall.conf") ��ġ ����.
    //String configPath = "/home/koco/lgdacom"; // for service
    boolean isSuccess = false;
    String ResCode = "";
    String messageStr = "";
    String purchaseKey = "";
    
    /*
     *************************************************
     * 1.�������� ��û - BEGIN
     *  (��, ���� �ݾ�üũ�� ���Ͻô� ��� �ݾ�üũ �κ� �ּ��� ���� �Ͻø� �˴ϴ�.)
     *************************************************
     */
    
    String CST_PLATFORM                 = request.getParameter("CST_PLATFORM");
    String CST_MID                      = request.getParameter("CST_MID");
    String LGD_MID                      = ("test".equals(CST_PLATFORM.trim())?"t":"")+CST_MID;
    String LGD_PAYKEY                   = request.getParameter("LGD_PAYKEY");

    //�ش� API�� ����ϱ� ���� WEB-INF/lib/XPayClient.jar �� Classpath �� ����ϼž� �մϴ�. 
    XPayClient xpay = new XPayClient();
   	boolean isInitOK = xpay.Init(configPath, CST_PLATFORM);   	

   	if( !isInitOK ) {
    	//API �ʱ�ȭ ���� ȭ��ó��
        System.out.println( "������û�� �ʱ�ȭ �ϴµ� �����Ͽ����ϴ�.<br>");
        System.out.println( "LG���÷������� ������ ȯ�������� ���������� ��ġ �Ǿ����� Ȯ���Ͻñ� �ٶ��ϴ�.<br>");        
        System.out.println( "mall.conf���� Mert ID = Mert Key �� �ݵ�� ��ϵǾ� �־�� �մϴ�.<br><br>");
        System.out.println( "������ȭ LG���÷��� 1544-7772<br>");
        return;
   	
   	}else{      
   		try{
   			/*
   	   	     *************************************************
   	   	     * 1.�������� ��û(�������� ������) - END
   	   	     *************************************************
   	   	     */
	    	xpay.Init_TX(LGD_MID);
	    	xpay.Set("LGD_TXNAME", "PaymentByKey");
	    	xpay.Set("LGD_PAYKEY", LGD_PAYKEY);
	    
	    	//�ݾ��� üũ�Ͻñ� ���ϴ� ��� �Ʒ� �ּ��� Ǯ� �̿��Ͻʽÿ�.
	    	//String DB_AMOUNT = "DB�� ���ǿ��� ������ �ݾ�"; //�ݵ�� �������� �Ұ����� ��(DB�� ����)���� �ݾ��� �������ʽÿ�.
	    	//xpay.Set("LGD_AMOUNTCHECKYN", "Y");
	    	//xpay.Set("LGD_AMOUNT", DB_AMOUNT);
	    
    	}catch(Exception e) {
    		System.out.println("LG���÷��� ���� API�� ����� �� �����ϴ�. ȯ������ ������ Ȯ���� �ֽñ� �ٶ��ϴ�. ");
    		System.out.println(""+e.getMessage());    	
    		return;
    	}
   	}

    /*
     * 2. �������� ��û ���ó��
     *
     * ���� ������û ��� ���� �Ķ���ʹ� �����޴����� �����Ͻñ� �ٶ��ϴ�.
     */
     if ( xpay.TX() ) {
         //1)������� ȭ��ó��(����,���� ��� ó���� �Ͻñ� �ٶ��ϴ�.)
         System.out.println( "������û�� �Ϸ�Ǿ����ϴ�.  <br>");
         System.out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         System.out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
         System.out.println("�ŷ���ȣ : " + xpay.Response("LGD_TID",0) + "<br>");
         System.out.println("�������̵� : " + xpay.Response("LGD_MID",0) + "<br>");
         System.out.println("�����ֹ���ȣ : " + xpay.Response("LGD_OID",0) + "<br>");
         System.out.println("�����ݾ� : " + xpay.Response("LGD_AMOUNT",0) + "<br>");
         System.out.println("����ڵ� : " + xpay.Response("LGD_RESPCODE",0) + "<br>");
         System.out.println("����޼��� : " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         
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
         	//����������û ��� ���� DBó��
         	System.out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");
         	
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
         	
         	System.out.println("DBó�����:" + msg);

         	//����������û ��� ���� DBó�� ���н� Rollback ó��
         	boolean isDBOK = true; //DBó�� ���н� false�� ������ �ּ���.
         	if(	!msg.equals("OK") ) {
         		isDBOK = false;
         	}
         	
         	if( !isDBOK ) {
         		xpay.Rollback("���� DBó�� ���з� ���Ͽ� Rollback ó�� [TID:" +xpay.Response("LGD_TID",0)+",MID:" + xpay.Response("LGD_MID",0)+",OID:"+xpay.Response("LGD_OID",0)+"]");
         		
         		System.out.println( "TX Rollback Response_code = " + xpay.Response("LGD_RESPCODE",0) + "<br>");
         		System.out.println( "TX Rollback Response_msg = " + xpay.Response("LGD_RESPMSG",0) + "<p>");
         		
                 if( "0000".equals( xpay.m_szResCode ) ) {
                	 System.out.println("�ڵ���Ұ� ���������� �Ϸ� �Ǿ����ϴ�.<br>");
                 }else{
                	 System.out.println("�ڵ���Ұ� ���������� ó������ �ʾҽ��ϴ�.<br>");
                 }
          		ResCode = xpay.m_szResCode;
          		messageStr = "���� ����� DB�� �����ϴ� ���� �����߽��ϴ�.";
          		purchaseKey = xpay.Response("LGD_OID",0);                 
         	} else {
         		// �������� ����
         		isSuccess = true;
         		ResCode = xpay.m_szResCode;
         		messageStr = "������ �����߽��ϴ�.";
         		purchaseKey = xpay.Response("LGD_OID",0);
         		
         		System.out.println("������ �����߽��ϴ�.");
         		System.out.println("������ȣ:" + xpay.Response("LGD_OID",0));
         		System.out.println("��� �޼���:" + xpay.Response("LGD_RESPMSG",0));
         		
         		
         	}
         }else{
         	//����������û ��� ���� DBó��
         	ResCode = xpay.m_szResCode;
         	messageStr = xpay.Response("LGD_RESPMSG",0);
         	purchaseKey = xpay.Response("LGD_OID",0);
         	
         	System.out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	
         }
     }else {
         //2)API ��û���� ȭ��ó��
         ResCode = xpay.m_szResCode;
         messageStr = xpay.m_szResMsg;
         
         System.out.println( "������û�� �����Ͽ����ϴ�.  <br>");
         System.out.println( "TX ������û Response_code = " + xpay.m_szResCode + "<br>");
         System.out.println( "TX ������û Response_msg = " + xpay.m_szResMsg + "<p>");
         
     	//����������û ��� ���� DBó��
     	System.out.println("����������û ��� ���� DBó���Ͻñ� �ٶ��ϴ�.<br>");            	            
     }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>���ڰ�������</title>

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
						<li class="res"><a>�����ڿ켱����</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/res/parkingIntro.c');">������Ұ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/enforcementBasis.c');">����ٰ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/regulateBasis.c');">�ܼӱٰ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/parkingCondition.c');">��������Ȳ</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/moduparkingIntro.c');">�����������Ұ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">�̳���ݾȳ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/residentRequest.c');">�̿��û</a></li>
							</ul></li>
						<li class="vis"><a>�湮����</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/vst/visitParking.c');">�湮�����Ұ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/vst/visitRequest.c');">�̿��û</a></li>
							</ul></li>
						<li class="pub"><a>��������</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingIntro.c');">������Ұ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingCondition.c');">��������Ȳ</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">�̳���ݾȳ�</a></li>
								<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">�̿�ȳ�</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/publicRequest.c');">�̿��û</a></li>
							</ul></li>
						<li class="reg"><a>���κ�����</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/tow/towStorageInfo.c');">���κ����Ҿȳ�</a></li>
							</ul></li>
						<li class="inf"><a>���� ��������</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingContract.c');">������ݰ���</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingCharge.c');">������ȯ�ҽ�û</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/standbyStatus.c');">�����Ȳ��ȸ</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">��������</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/outReconfirm.c');">ȸ��Ż��</a></li>
							</ul></li>
						<li class="cus"><a>������</a>
							<ul>
								<li><a href="javascript:fn_MovePage('/sup/notice.c');">��������</a></li>
								<li><a href="javascript:fn_MovePage('/sup/qna.c');">���ֹ�������</a></li>
								<li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">��ȭ��ȣ�ȳ�</a></li>
								<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">ã�ƿ��ô±�</a></li>
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
							<h1>���ڰ�������</h1>
							<!--<h2><i class="axi axi-keyboard-arrow-right"></i>��������/����</h2>-->
						</div>
						<div class="log out">
							<!-- �α��� / �ƿ� -->
							<!-- �α��� ���� -->
							<sec:authorize access="isAnonymous()">
								<div class="in">
									<a class="join"
										href="javascript:fn_MovePage('/mem/memberJoin.c');">ȸ������</a>
								</div>
							</sec:authorize>
							<!-- �α��� ���� -->
							<sec:authorize access="isAuthenticated()">
								<div class="out">
									<p>
										<span>${user.mberNm}</span>�� ȯ���մϴ�!
									</p>
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
							<p>���ڰ��� ��� ����</p>
						</div>
						<div class="table_box">
							<table class="table">
								<thead>
									<tr>
										<th width="30%">�׸�</th>
										<th width="70%">����</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>���� ��� �ڵ�</th>
										<td><%= ResCode %></td>
									</tr>
									<tr>
										<th>���� ��� �޼���</th>
										<td><%= messageStr %></td>
									</tr>
									<tr>
										<th>������ȣ</th>
										<td><%= purchaseKey %></td>
									</tr>
								</tbody>
							</table>
						</div>


						<div class="page_btn">
							<a href='/' class="btn lgreen">Ȩ���� �̵�</a>
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
