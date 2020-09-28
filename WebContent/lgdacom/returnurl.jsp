<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*,java.io.InputStream" %>
<%
request.setCharacterEncoding("euc-kr");

String LGD_RESPCODE = request.getParameter("LGD_RESPCODE");
String LGD_RESPMSG 	= request.getParameter("LGD_RESPMSG");

Map payReqMap = request.getParameterMap();
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<head>
	<script type="text/javascript">

		function setLGDResult() {
			parent.payment_return();
			try {
			} catch (e) {
				alert(e.message);
			}
		}
		
	</script>

	<style>
		.result { margin: 100px auto; width: 400px; text-align: center; }
		.result h1 { margin-bottom: 50px; }
		.result p { font-size: 18px; }
		.result p.s { color: #2c82c9; }
		.result p.f { color: #d14841; }
	</style>
</head>
<body onload="setLGDResult()">
<div class="result">
<h1>인증결과</h1>
<% //디자인할 영역 %>
<% if(LGD_RESPCODE.equals("0000")) { %>
<p class="s">정상적 결제가 진행되고 있습니다.</p>
<% } else { %>
<p class="f">결제가 처리되지 못했습니다.</p>
<% } %>
</div>
<!-- 
<p>LGD_RESPCODE (결과코드) : <%= LGD_RESPCODE %></p>
<p>LGD_RESPMSG (결과메시지): <%= LGD_RESPMSG %></p>
 -->
	<form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO">
	<%
	for (Iterator i = payReqMap.keySet().iterator(); i.hasNext();) {
		Object key = i.next();
		if (payReqMap.get(key) instanceof String[]) {
			String[] valueArr = (String[])payReqMap.get(key);
			for(int k = 0; k < valueArr.length; k++)
				out.println("<input type='hidden' name='" + key + "' id='"+key+"'value='" + valueArr[k] + "'/>");
		} else {
			String value = payReqMap.get(key) == null ? "" : (String) payReqMap.get(key);
			out.println("<input type='hidden' name='" + key + "' id='"+key+"'value='" + value + "'/>");
		}
	}
	%>
	</form>
</div>
</body>
</html>