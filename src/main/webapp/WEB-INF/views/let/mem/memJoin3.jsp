<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	String gubn = (String) request.getParameter("gubn");
	String upper_flg = (String) request.getParameter("upper_flg");
	String donor_name = (String) request.getParameter("donor_name");
	String dhospital_idx = (String) request.getParameter("dhospital_idx");
	String donor_date = (String) request.getParameter("donor_date");
	String donor_birth = (String) request.getParameter("donor_birth");
	String benefi_name = (String) request.getParameter("benefi_name");
	String bhospital_idx = (String) request.getParameter("bhospital_idx");
	String benefi_parts = (String) request.getParameter("benefi_parts");
	String benefi_birth = (String) request.getParameter("benefi_birth");
%>
<head>
<meta http-equiv="refresh"
	content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />

<title>회원가입</title>

<style type="text/css">
</style>

<script id="jscode">
	
	$(function () {

        
        if ($("#upper_flg").val() == "D"){
        	$("#puseagChk").text("위 내용을 읽었으며, 보호자(법정대리인)의 동의하에 “한국장기조직기증원 홈페이지 이용약관＂에 동의합니다.");
        	$("#ppriagChk").text("위 내용을 읽었으며, 보호자(법정대리인)의 동의하에 “개인정보 수집 이용 동의＂에 동의합니다.");
        	$("#pprigvagChk").text("위 내용을 읽었으며, 보호자(법정대리인)의 동의하에 “개인정보의 제3자 동의＂에 동의합니다.");
        	$("#parentChkDiv").css("display","");
        	$("#parentChk").addClass("av-required");
        }else{
        	$("#puseagChk").text("위 내용을 읽었으며, “한국장기조직기증원 홈페이지 이용약관＂에 동의합니다.");
        	$("#ppriagChk").text("위 내용을 읽었으며, “개인정보 수집 이용 동의＂에 동의합니다.");
        	$("#pprigvagChk").text("위 내용을 읽었으며, “개인정보의 제3자 동의＂에 동의합니다.");
        	$("#parentChkDiv").css("display","none");
        	$("#parentChk").removeClass("av-required");
        }

        //var clock = document.getElementById("clock");
        //var now = new Date();
        //var time = now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate() + "일  " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초";
        //clock.innerHTML = time;
        
    });
	
	function checkAgree(){
		if (!$("#useagChk").is(":checked")){
            axf.alert("이용약관에 동의해 주시기 바랍니다");
            $("#useagChk").focus();
		}else if (!$("#priagChk").is(":checked")){
            axf.alert("개인정보 수집이용에 동의해 주시기 바랍니다");
            $("#priagChk").focus();
		}else if (!$("#prigvagChk").is(":checked")){
            axf.alert("개인정보 제3자제공 동의에 동의해 주시기 바랍니다");
            $("#prigvagChk").focus();
		}else if ($("#upper_flg").val() == "D" && !$("#parentChk").is(":checked")){
            axf.alert("14세미만 회원가입 동의에 동희해 주시기 바랍니다");
            $("#parentChk").focus();
		}else{
			$("#frm").submit();
		}
		
	}
	
	$(function(){
	    $("#ckall").click(function(){
	        var chk = $(this).is(":checked");//.attr('checked');
	        if(chk) $(".ck input").prop('checked', true);
	        else  $(".ck input").prop('checked', false);
	    });
	});

</script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->
	<form name="frm" id="frm" action="/mem/memJoin4.l" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn%>" />
	    <input type="hidden" id="upper_flg" name="upper_flg" value="<%=upper_flg%>"/>
		<input type="hidden" id="donor_name" name="donor_name" value="<%=donor_name%>" />
		<input type="hidden" id="dhospital_idx" name="dhospital_idx" value="<%=dhospital_idx%>" />
		<input type="hidden" id="donor_date" name="donor_date" value="<%=donor_date%>" />
		<input type="hidden" id="donor_birth" name="donor_birth" value="<%=donor_birth%>" />
		<input type="hidden" id="benefi_name" name="benefi_name" value="<%=benefi_name%>" />
		<input type="hidden" id="bhospital_idx" name="bhospital_idx" value="<%=bhospital_idx%>" />
		<input type="hidden" id="benefi_parts" name="benefi_parts" value="<%=benefi_parts%>" />
		<input type="hidden" id="benefi_birth" name="benefi_birth" value="<%=benefi_birth%>" />
	</form>
	
	<div class="esignup">
		<div class="wrap">
			<h2 class="e-title">기증자 가족 회원가입</h2>
			<div class="esignup__process">
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-1.png" alt="">
					</div>
					<p>회원구분</p>
				</div>
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2.png" alt="">
					</div>
					<p>회원선택</p>
				</div>
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-3-active.png" alt="">
					</div>
					<p>약관동의</p>
				</div>
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4.png" alt="">
					</div>
					<p>본인인증</p>
				</div>
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-5.png" alt="">
					</div>
					<p>정보입력</p>
				</div>
				<div class="col">
					<div class="icon">
						<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-6.png" alt="">
					</div>
					<p>가입완료</p>
				</div>
			</div>

			<div class="esignup__privacy">

				<div class="allCheck">
					<label for="ckall" class="checkbox" >
						<p onclick ="javascript:allCheck()">한국장기조직기증원의 모든 약관에 동의합니다.</p> <input type="checkbox" hidden
						id="ckall" > <span></span>
					</label>
				</div>

				<div class="section">
					<h3>이용약관</h3>
					<div class="prvbox">제 1 장 총칙 제 1 조 (개인정보의 수집 및 이용목적)
						한국장기기증조직원 홈페이지는 회원님 개인의 정보를 수집목적은 건전하고 최적의 서비스를 제공해드리기 위한 것이며,
						이용목적은 공단 홈페이지 개선방향 모색과 비밀번호 분실시 조치 등에 이용됩니다. 제 2 조 (수집하는 개인정보 항목,
						수집 방법 및 보유기간) 공공기관의 개인정보파일 관리지침을 준수하여 개인정보를 보유하고 있습니다. 한국장기기증조직원
						홈페이지는 최초 회원가입을 하실 때 서비스 제공을 위해 가장 필수적인 개인정보를 받고 있습니다. 회원가입 시에 받는
						정보는 회원님의 이름, 아이디와 패스워드, 생년월일, 주소, 연락처 기타 회원님의 권익 증진을 위해 공단에서 제공할
						필요가 있다고 판단되는 정보를 서비스하기 위한 필요한 항목입니다. 또한, 보유기간은 가입일로 부터 2년간 개 인정보를
						보유하고, 회원가입 탈퇴 시, 회원님의 개인정보는 바로 삭제조치함을 알려드립니다. 기입하신 정보는 서비스 제공이나
						회원님께 사전에 밝힌 목적 이외의 다른 어떠한 목적으</div>
					<div class="ck">
						<label for="useagChk" class="checkbox">
							<p id = "puseagChk">위 내용을 읽었으며, "회원약관"에 동의합니다.</p> 		
							<input type="checkbox" id="useagChk" name="chk"  title= "이용약관" hidden>
							<span></span>							
						</label>
					</div>
				</div>

				<div class="section">
					<h3>개인정보 수집·이용 동의</h3>
					<div class="prvbox">제 1 장 총칙 제 1 조 (개인정보의 수집 및 이용목적)
						한국장기기증조직원 홈페이지는 회원님 개인의 정보를 수집목적은 건전하고 최적의 서비스를 제공해드리기 위한 것이며,
						이용목적은 공단 홈페이지 개선방향 모색과 비밀번호 분실시 조치 등에 이용됩니다. 제 2 조 (수집하는 개인정보 항목,
						수집 방법 및 보유기간) 공공기관의 개인정보파일 관리지침을 준수하여 개인정보를 보유하고 있습니다. 한국장기기증조직원
						홈페이지는 최초 회원가입을 하실 때 서비스 제공을 위해 가장 필수적인 개인정보를 받고 있습니다. 회원가입 시에 받는
						정보는 회원님의 이름, 아이디와 패스워드, 생년월일, 주소, 연락처 기타 회원님의 권익 증진을 위해 공단에서 제공할
						필요가 있다고 판단되는 정보를 서비스하기 위한 필요한 항목입니다. 또한, 보유기간은 가입일로 부터 2년간 개 인정보를
						보유하고, 회원가입 탈퇴 시, 회원님의 개인정보는 바로 삭제조치함을 알려드립니다. 기입하신 정보는 서비스 제공이나
						회원님께 사전에 밝힌 목적 이외의 다른 어떠한 목적으</div>
					<div class="ck">
						<label for="priagChk" class="checkbox">
							<p id="ppriagChk">위 내용을 읽었으며, "개인정보 수집·이용 동의"에 동의합니다.</p>							
                            <input type="checkbox" id="priagChk" name="chk"  title ="개인정보 수집 이용 동의" hidden> 
							<span></span>
						</label>
					</div>
				</div>
				
				<div class="section">
					<h3>개인정보 제3자 제공 동의</h3>
					<div class="prvbox">제 1 장 총칙 제 1 조 (개인정보의 수집 및 이용목적)
						한국장기기증조직원 홈페이지는 회원님 개인의 정보를 수집목적은 건전하고 최적의 서비스를 제공해드리기 위한 것이며,
						이용목적은 공단 홈페이지 개선방향 모색과 비밀번호 분실시 조치 등에 이용됩니다. 제 2 조 (수집하는 개인정보 항목,
						수집 방법 및 보유기간) 공공기관의 개인정보파일 관리지침을 준수하여 개인정보를 보유하고 있습니다. 한국장기기증조직원
						홈페이지는 최초 회원가입을 하실 때 서비스 제공을 위해 가장 필수적인 개인정보를 받고 있습니다. 회원가입 시에 받는
						정보는 회원님의 이름, 아이디와 패스워드, 생년월일, 주소, 연락처 기타 회원님의 권익 증진을 위해 공단에서 제공할
						필요가 있다고 판단되는 정보를 서비스하기 위한 필요한 항목입니다. 또한, 보유기간은 가입일로 부터 2년간 개 인정보를
						보유하고, 회원가입 탈퇴 시, 회원님의 개인정보는 바로 삭제조치함을 알려드립니다. 기입하신 정보는 서비스 제공이나
						회원님께 사전에 밝힌 목적 이외의 다른 어떠한 목적으</div>
					<div class="ck">
						<label for="prigvagChk" class="checkbox">
							<p id="pprigvagChk">위 내용을 읽었으며, "개인정보 제3자 제공 동의"에 동의합니다.</p>							
                            <input type="checkbox" id="prigvagChk" name="chk"  title ="개인정보 제3자 제공 동의" hidden>
							<span></span>
						</label>
					</div>
				</div>
				
				<div  id = "parentChkDiv" style="display:none" class="section">
					<h3>14세 미만 회원가입 동의</h3>
					<div class="prvbox" style="height:80px;">  회원가입을 하시려면 반드시 "부모님(법적보호자)의 동의"를 받으셔야 합니다.</div>
					<div class="ck">
						<label for="parentChk" class="checkbox">
							<p id ="pparentChk">위 내용을 읽었으며, "14세 미만 회원가입 동의"에 동의합니다.</p>							
                            <input type="checkbox" id="parentChk" name="chk" title = "14세 미만 회원가입 동의" hidden>
							<span></span>
						</label>
					</div>
				</div>

				<div class="actions">
					<a class="black" href="javascript:checkAgree();">회원가입</a>
					<a href="javascript:fn_MovePage('/mem/memLogin.l');">취소</a>
				</div>
			</div>
		</div>
	</div>
</body>
