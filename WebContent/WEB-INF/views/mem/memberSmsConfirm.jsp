<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
<%
	NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
	
	String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
	
	String sSmsSiteCode = (String)request.getAttribute("sSmsSiteCode");
	String sSmsSitePassword = (String)request.getAttribute("sSmsSitePassword");
	String param_r1 = request.getParameter("param_r1");
	
	String sCipherTime = "";                 // 복호화한 시간
	String sRequestNumber = "";          // 요청 번호
	String sResponseNumber = "";         // 인증 고유번호
	String sAuthType = "";                 // 인증 수단
	String sName = "";                           // 성명
	String sDupInfo = "";                        // 중복가입 확인값 (DI_64 byte)
	String sConnInfo = "";                   // 연계정보 확인값 (CI_88 byte)
	String sBirthDate = "";                  // 생일
	String sGender = "";                         // 성별
	String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
	String sMessage = "";
	String sPlainData = "";
	String sMobileNo = "";
	
	int iReturn = niceCheck.fnDecode(sSmsSiteCode, sSmsSitePassword, sEncodeData);
	
	if( iReturn == 0 )
	{
	    sPlainData = niceCheck.getPlainData();
	    sCipherTime = niceCheck.getCipherDateTime();
	    
	    // 데이타를 추출합니다.
	    java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
	    
	    sRequestNumber  = (String)mapresult.get("REQ_SEQ");
	    sResponseNumber = (String)mapresult.get("RES_SEQ");
	    sAuthType           = (String)mapresult.get("AUTH_TYPE");
	    sName                   = (String)mapresult.get("NAME");
	    sBirthDate          = (String)mapresult.get("BIRTHDATE");
	    sGender                 = (String)mapresult.get("GENDER");
	    sNationalInfo   = (String)mapresult.get("NATIONALINFO");
	    sDupInfo                = (String)mapresult.get("DI");
	    sConnInfo           = (String)mapresult.get("CI");
	    sMobileNo           = (String)mapresult.get("MOBILENO");
	    
	    String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	    if(!sRequestNumber.equals(session_sRequestNumber))
	    {
	        sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	        sResponseNumber = "";
	        sAuthType = "";
	    }
	}
	else if( iReturn == -1)
	{
	    sMessage = "복호화 시스템 에러입니다.";
	}    
	else if( iReturn == -4)
	{
	    sMessage = "복호화 처리오류입니다.";
	}    
	else if( iReturn == -5)
	{
	    sMessage = "복호화 해쉬 오류입니다.";
	}    
	else if( iReturn == -6)
	{
	    sMessage = "복호화 데이터 오류입니다.";
	}    
	else if( iReturn == -9)
	{
	    sMessage = "입력 데이터 오류입니다.";
	}    
	else if( iReturn == -12)
	{
	    sMessage = "사이트 패스워드 오류입니다.";
	}    
	else
	{
	    sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	}

%>
<%!
	public String requestReplace (String paramValue, String gubun) {
	    String result = "";
	    
	    if (paramValue != null) {
	        
	        paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	
	        paramValue = paramValue.replaceAll("\\*", "");
	        paramValue = paramValue.replaceAll("\\?", "");
	        paramValue = paramValue.replaceAll("\\[", "");
	        paramValue = paramValue.replaceAll("\\{", "");
	        paramValue = paramValue.replaceAll("\\(", "");
	        paramValue = paramValue.replaceAll("\\)", "");
	        paramValue = paramValue.replaceAll("\\^", "");
	        paramValue = paramValue.replaceAll("\\$", "");
	        paramValue = paramValue.replaceAll("'", "");
	        paramValue = paramValue.replaceAll("@", "");
	        paramValue = paramValue.replaceAll("%", "");
	        paramValue = paramValue.replaceAll(";", "");
	        paramValue = paramValue.replaceAll(":", "");
	        paramValue = paramValue.replaceAll("-", "");
	        paramValue = paramValue.replaceAll("#", "");
	        paramValue = paramValue.replaceAll("--", "");
	        paramValue = paramValue.replaceAll("-", "");
	        paramValue = paramValue.replaceAll(",", "");
	        
	        if(gubun != "encodeData"){
	            paramValue = paramValue.replaceAll("\\+", "");
	            paramValue = paramValue.replaceAll("/", "");
	        paramValue = paramValue.replaceAll("=", "");
	        }
	        
	        result = paramValue;
	        
	    }
	    return result;
	}
%>

<% 

if( iReturn == 0 ) {
%>
    try {
    	window.opener.document.smsObj.sDupInfo.value = "<%= sDupInfo %>";                        //di 정보
        window.opener.document.smsObj.sName.value = "<%= sName %>";                    //사용자명
        window.opener.document.smsObj.sGender.value = "<%= sGender %>";                        //성별
        window.opener.document.smsObj.age.value = "";                                            //나이
        window.opener.document.smsObj.sBirthDate.value = "<%= sBirthDate %>";      // 생년월일
        window.opener.document.smsObj.sNationalInfo.value = "<%= sNationalInfo %>";  //국적
        window.opener.document.smsObj.sConnInfo.value = "<%= sConnInfo %>";       //ci정보
        window.opener.document.smsObj.virtualNo.value = "";                                       //가상번호
        window.opener.document.smsObj.sMobileNo.value ="<%= sMobileNo %>";               //핸드폰번호
        window.opener.document.smsObj.param_r1.value ="<%= param_r1 %>";               //핸드폰번호
        
        window.opener.smsConfirm();
		
	} catch (err){
	    alert("처리 중 오류["+err+"]");
	}
	
	window.close();
	
<% } else { %>

    <% if (iReturn == 0) { %>
        alert("본인인증 실패[<%= sAuthType %>]");       
    <% } else { %>
        alert("처리 중 오류[<%= iReturn %>,<%=sMessage %>]");
    <% } %>
    
    window.close();
    
<% } %>
</script>