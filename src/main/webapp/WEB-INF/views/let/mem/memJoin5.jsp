<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
	<meta http-equiv="refresh" content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />
	<script type="text/javascript" src="<spring:eval expression="@appConfig['daum.addr.js.path']"/>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

	<title>회원가입</title>

    <script id="jscode">

   		var myValidator = new AXValidator();

    	var monthtext=['1','2','3','4','5','6','7','8','9','10','11','12'];
        

        $(document.body).ready(function () {
			
			//회원종류 및 14미만 아동에 따라 dp control
            if ($("#upper_flg").val() == "D"){
            	$("#parentChkDiv").css("display","");
            	$("#prt_name").addClass("av-required");
            	$("#prt_birthday").addClass("av-required");
            	$("#prt_phone").addClass("av-required");
            	$("input:radio[id='prt_gender_true']").prop("checked", true);
            }else{
            	$("#parentChkDiv").css("display","none");
            	$("#prt_name").removeClass("av-required");
            	$("#prt_birthday").removeClass("av-required");
            	$("#prt_phone").removeClass("av-required");
            	$("input:radio[id='prt_gender_true']").prop("checked", false);
            }    
            
            if ($("#gubn").val() == "D"){

            	var donorHtml = "";
            	donorHtml = donorHtml + ' <h3 class="require">관계</h3>';
            	donorHtml = donorHtml + ' <div class="box">';
            	donorHtml = donorHtml + ' <div class="row">';
            	donorHtml = donorHtml + ' <div class="select" style="max-width: 280px;">';
            	donorHtml = donorHtml + ' <select name="donor_relation" id="donor_relation" title="관계"';
            	donorHtml = donorHtml + ' class="av-required">';
            	donorHtml = donorHtml + ' <option value="">가족</option>';
            	donorHtml = donorHtml + ' class="av-required">';
            	donorHtml = donorHtml + ' </div></div></div>';
            	
            	$("#div_donor_relation").html(donorHtml);
            	
            	/*$("#donorChkDiv").css("display","");
            	$("#donor_name").addClass("av-required");
            	$("#hospital_idx").addClass("av-required");
            	$("#donor_date").addClass("av-required");
            	$("#donor_birth").addClass("av-required");*/
            }else{
            	/*$("#donorChkDiv").css("display","none");
            	$("#donor_name").removeClass("av-required");
            	$("#hospital_idx").removeClass("av-required");
            	$("#donor_date").removeClass("av-required");
            	$("#donor_birth").removeClass("av-required");*/
            }  
            
            //가족관계 조회			
            $.ajax({
                url: "/com/searchCommonCode.json",
                type: "POST",
                dataType: "json",
                data: {gubn:"01"},
                success: function (data, textStatus, jqXHR) {

                    var htmlSum = "";
                    for (var i = 0; i < data.list.length; i++) {

                        var html = "";
    					html = html + '<option value="' + data.list[i].code + '" >' + data.list[i].name + '</option>';
                        
                        htmlSum = htmlSum + html;
                    }

                    $("#donor_relation").html(htmlSum);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
            
            myValidator.setConfig({
                targetFormName: "frm"
            });
            

			//병원정보 조회			
            $.ajax({
                url: "/com/searchHospitalCombo.json",
                type: "POST",
                dataType: "json",
                success: function (data, textStatus, jqXHR) {

                    var htmlSum = "";
                    for (var i = 0; i < data.list.length; i++) {

                        var html = "";
						html = html + '<option value="' + data.list[i].hospitalIdx + '" >' + data.list[i].hospitalName + '</option>';
                        
                        htmlSum = htmlSum + html;
                    }

                    $("#hospital_idx").html(htmlSum);

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
			
            //이메일1 컨트롤
            $('#email_suf_sel').change(function(){
            	$("#email_suf_sel option:selected").each(function () {
            		if($(this).val()== '1'){ //직접입력일 경우 
            			$("#email_suf").val(''); //값 초기화 
            			$("#email_suf").attr("disabled",false); //활성화
            		}else{ //직접입력이 아닐경우 
            			$("#email_suf").val($(this).text()); //선택값 입력 
            			$("#email_suf").attr("disabled",true); //비활성화
            		} });
            });
            
          //이메일2 컨트롤
            $('#email2_suf_sel').change(function(){
            	$("#email2_suf_sel option:selected").each(function () {
            		if($(this).val()== '1'){ //직접입력일 경우 
            			$("#email2_suf").val(''); //값 초기화 
            			$("#email2_suf").attr("disabled",false); //활성화
            		}else{ //직접입력이 아닐경우 
            			$("#email2_suf").val($(this).text()); //선택값 입력 
            			$("#email2_suf").attr("disabled",true); //비활성화
            		} });
            });
          
          //이메일3 컨트롤
            $('#email3_suf_sel').change(function(){ 
            	$("#email3_suf_sel option:selected").each(function () {
            		if($(this).val()== '1'){ //직접입력일 경우 
            			$("#email3_suf").val(''); //값 초기화 
            			$("#email3_suf").attr("disabled",false); //활성화
            		}else{ //직접입력이 아닐경우 
            			$("#email3_suf").val($(this).text()); //선택값 입력 
            			$("#email3_suf").attr("disabled",true); //비활성화
            		} });
            });
          

            populatedropdown("birthday_dd", "birthday_mm", "birthday_yy");
        });
        
      	//날짜 콤보박스
        function populatedropdown(dayfield, monthfield, yearfield){

        var today=new Date()

        var dayfield=document.getElementById(dayfield)

        var monthfield=document.getElementById(monthfield)

        var yearfield=document.getElementById(yearfield)

            for (var i=0; i<31; i++)

                dayfield.options[i]=new Option(i+1, i+1)

                dayfield.options[today.getDate()]=new Option(today.getDate(), today.getDate(), true, true) //select today's day

            for (var m=0; m<12; m++)

                monthfield.options[m]=new Option(monthtext[m], monthtext[m])

                monthfield.options[today.getMonth()]=new Option(monthtext[today.getMonth()], monthtext[today.getMonth()], true, true) //select today's month

        var thisyear=today.getFullYear()

            for (var y=0; y<70; y++){

                yearfield.options[y]=new Option(thisyear, thisyear)

                thisyear-=1

            }

            yearfield.options[0]=new Option(today.getFullYear(), today.getFullYear(), true, true) //select today's year

        }


        //아이디중복체크
        var idCheck = 'N';
        var checkFinishId = '';

        function mberIdDuplCheck() {

            var mberId = $("#id").val();

            if (mberId == '') {
                axf.alert('아이디를 입력 해 주세요.');
                return;
            }

            //아이디 정규식 체크
            var acceptMberId = /^[A-Za-z0-9+]{3,20}$/;

            if (acceptMberId.test(mberId) == false) {

                axf.alert('아이디는 3~20자의 영문/숫자만 입력 가능합니다.');
                $("#id").focus();
                return;
            }

            $.ajax({
                url: "/mem/mberIdDuplCheck.json",
                type: "POST",
                dataType: "json",
                data: {id: $("#id").val()},
                success: function (data, textStatus, jqXHR) {
                    if (data == "0") {
                        axf.alert("사용가능한 ID 입니다.");
                        idCheck = 'Y';
                        checkFinishId = mberId;
                    } else {
                        axf.alert("사용이 불가능한 ID 입니다.");
                        idCheck = 'N';
                        checkFinishId = '';
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }

        function mberIdDuplCheckFalse() {
            idCheck = 'N';
        }
        
        //닉네임 중복확인
        var nickCheck = 'N';
        var checkFinishNick = '';

        function mberNickNameDuplCheck() {

            var mberNick = $("#nick_name").val();

            if (mberNick == '') {
                axf.alert('닉네임을 입력 해 주세요.');
                return;
            }

            //아이디 닉네임 체크
            if (mberNick == $("#id").val()) {
                axf.alert('닉네임과 아이디는 같을 수 없습니다.');
                $("#nick_name").focus();
                return;
            }            
			
            //닉네임 이름 체크
            if (mberNick == $("#name").val()) {
                axf.alert('닉네임과 이름은 같을 수 없습니다.');
                $("#nick_name").focus();
                return;
            }

            $.ajax({
                url: "/mem/mberNickNameDuplCheck.json",
                type: "POST",
                dataType: "json",
                data: {nick_name: $("#nick_name").val()},
                success: function (data, textStatus, jqXHR) {
                    if (data == "0") {
                        axf.alert("사용가능한 닉네임입니다.");
                        nickCheck = 'Y';
                        checkFinishNick = mberNick;
                    } else {
                        axf.alert("사용이 불가능한 닉네임입니다.");
                        idCheck = 'N';
                        checkFinishNick = '';
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }

        function mberNickNameDuplCheckFalse() {
        	nickCheck = 'N';
        }

        //회원가입
        function saveMember() {

            var validateResult = myValidator.validate();

            if (!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            } else {

                if (idCheck != 'Y') {
                    axf.alert("아이디 중복확인을 해주세요.");
                    return;
                }

                if (nickCheck != 'Y') {
                    axf.alert("닉네임 중복확인을 해주세요.");
                    return;
                }
                
                if ($("#id").val() != checkFinishId) {
                    axf.alert("입력한 아이디와 중복확인 완료한 아이디가 같지않습니다. 확인해주세요.");
                    return;
                }

                if ($("#nick_name").val() != checkFinishNick) {
                    axf.alert("입력한 닉네임과 중복확인 완료한 닉네임이 같지않습니다. 확인해주세요.");
                    return;
                }

                if ($("#password").val() != $("#passwordCheck").val()) {
                    axf.alert("비밀번호와 비밀번호 확인이 같지않습니다. 확인해주세요.");
                    return;
                }

                //비밀번호 정규식 체크
                var password = $("#password").val();
                var acceptPassword = /^.*(?=^.{9,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

                if (acceptPassword.test(password) == false) {

                    axf.alert("비밀번호는 영문/숫자/특수문자를 포함한 9~16글자만 가능합니다.");

                    //$("#password").val("");
                    //$("#passwordCheck").val("");
                    $("#password").focus();
                    return;
                }
        		
                //기증자 정보 확인
                if ($("#gubn").val() == "D"){
                	if($("#donor_name").val() == "" || $("#dhospital_idx").val() == "" || $("#donor_date").val() == "" || $("#donor_birth").val() == ""){
                		axf.alert("기증자 정보가 올바르지 않습니다.");
                		return;
                	}
                }else{
                //수혜자 정보 확인
                	if($("#benefi_name").val() == "" || $("#bhospital_idx").val() == "" || $("#benefi_parts").val() == "" || $("#benefi_birth").val() == ""){
                		axf.alert("수혜자 정보가 올바르지 않습니다.");
                		return;
                	}
                }
                
                //뉴스레터 동의인 경우 email3필수
                if($("input[name='news_flag']:checked").val() == "Y"){
                	if($("#email3_pre").val() == "" || $("#email3_suf").val() == ""){
                		axf.alert("뉴스레터 수신 메일정보가 올바르지 않습다.");
                		email3_pre.focus();
                		return;
                	}
                }
                
                //변수 결합
                $("#email").val($("#email_pre").val() +"@" + $("#email_suf").val());

                if ($("#email2_pre").val() == ""){
                	$("#email2").val("");
                }else{
                    $("#email2").val($("#email2_pre").val() +"@" + $("#email2_suf").val());
                }
                
                if ($("#email3_pre").val() == ""){
                	$("#email3").val("");
                }else{
                    $("#email3").val($("#email3_pre").val() +"@" + $("#email3_suf").val());                	
                }
                
                $("#birthday").val($("#birthday_yy").val() +"-" + $("#birthday_mm").val() +"-" + $("#birthday_dd").val());
                
                $.ajaxSettings.traditional = true;
                $.ajax({
                    url: "/mem/saveMember.json",
                    type: "POST",
                    data: $('#frm').serialize(),
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                        	$("#sid").val($("#id").val());
                        	$("#sname").val($("#name").val());
                        	$("#snick_name").val($("#nick_name").val());
                        	
                        	$("#frm_end").attr("action", "/mem/memJoin6.l");
                        	
                        	$("#frm_end").submit();
                        } else {
                            axf.alert("등록 실패했습니다.");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                    }
                });
            }
        }

    </script>
</head>

<body>
<!-- <form name="user" method="post"> -->
<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
<!-- </form> -->
	<form name="frm_end" id="frm_end" method="post">
		<input type="hidden" id="sid" name="sid" value="" /> 
		<input type="hidden" id="sname" name="sname" value="" />
		<input type="hidden" id="snick_name" name="snick_name" value="" />
	</form>
	<form name="frm" id="frm" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn%>" /> 
		<input type="hidden" id="upper_flg" name="upper_flg" value="<%=upper_flg%>" />
		<input type="hidden" id="donor_name" name="donor_name" value="<%=donor_name%>" />
		<input type="hidden" id="dhospital_idx" name="dhospital_idx" value="<%=dhospital_idx%>" />
		<input type="hidden" id="donor_date" name="donor_date" value="<%=donor_date%>" />
		<input type="hidden" id="donor_birth" name="donor_birth" value="<%=donor_birth%>" />
		<input type="hidden" id="benefi_name" name="benefi_name" value="<%=benefi_name%>" />
		<input type="hidden" id="bhospital_idx" name="bhospital_idx" value="<%=bhospital_idx%>" />
		<input type="hidden" id="benefi_parts" name="benefi_parts" value="<%=benefi_parts%>" />
		<input type="hidden" id="benefi_birth" name="benefi_birth" value="<%=benefi_birth%>" />
		<input type="hidden" id="email" name="email" value="" />
		<input type="hidden" id="email2" name="email2" value="" />
		<input type="hidden" id="email3" name="email3" value="" />
		<input type="hidden" id="birthday" name="birthday" value="" />


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
							<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-3.png" alt="">
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
							<img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-5-active.png" alt="">
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

				<div class="esignup-form">

					<div class="esignup-form-section">
						<div class="form">
							<div class="form-row">
								<h3 class="require">아이디</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="id" name="id" title="아이디"
												onclick="javascript:mberIdDuplCheckFalse();"
												placeholder="최소 3자이상(영문자, 숫자,_만 가능)" class="av-required">
										</div>
										<button type="button" onclick="mberIdDuplCheck();">아이디
											중복확인</button>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">이름</h3>
								<div class="box">
									<div class="row">
										<p>홍길동</p>
										<input type="text" id="name" name="name" title="이름" value="홍길동"
											class="av-required" hidden>
									</div>
								</div>
							</div>
							<div class="form-row" id ="div_donor_relation">
							</div>							
							<div class="form-row">
								<h3 class="">성별</h3>
								<div class="box">
									<div class="row">
										<label for="gender_true" class="radio mr-6"> <input
											type="radio" name="gender" id="gender_true" value ="M" checked hidden>
											<span></span>
											<p>남성</p>
										</label> <label for="gender_false" class="radio"> <input
											type="radio" name="gender" id="gender_false" value ="F" hidden>
											<span></span>
											<p>여성</p>
										</label>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">닉네임</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="nick_name" name="nick_name"
												onclick="javascript:mberNickNameDuplCheckFalse();"
												placeholder="개인정보 유출 가능성이 있는 닉네임은 사용 불가능합니다."
												title="닉네임"
												class="av-required">											
										</div>
										<button type="button" onclick="mberNickNameDuplCheck();">닉네임
												중복확인</button>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">비밀번호</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="password" id="password" name="password"
												title="비밀번호" placeholder="9자이상~16자이하(영문자+숫자+특수문자 조합)"
												class="av-required">
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">비밀번호 확인</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="password" id="passwordCheck"
												name="passwordCheck" title="비밀번호 확인" class="av-required">
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">주소</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="post" name="post" readonly
												title="우편번호" class="av-required">
										</div>
										<button type="button"
											onclick="execDaumPostcode_UserEdit('post','address','address_detail', 'adresNewYn')">우편번호
											검색</button>
										<input type="hidden" name="adresNewYn" id="adresNewYn" />
									</div>
									<div class="row">
										<div class="input">
											<input type="text" id="address" name="address" readonly
												title="주소" class="av-required">
										</div>
									</div>
									<div class="row">
										<div class="input">
											<input type="text" id="address_detail" name="address_detail"
												title="주소" class="av-required">
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">휴대폰전화번호</h3>
								<div class="box">
									<div class="row">
										<p>010-2222-3333</p>
										<input type="text" id="phone" name="phone" title="핸드폰번호" value="010-2222-3333"
											class="av-required" hidden>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">이메일</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="email_pre" name="email_pre" class="av-required"
												title="이메일 주소">
										</div>
										<span class="mx-4">@</span>
										<div class="input ml-4">
											<input type="text" id="email_suf" name = "email_suf" disabled value="naver.com" class="av-required"/>
										</div>
										<div class="select ml-4">
											<select name="email_suf_sel" id="email_suf_sel">
												<option value="1">직접입력</option>
												<option value="naver.com" selected>naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="freechal.com">freechal.com</option>
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="korea.com">korea.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="paran.com">paran.com</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="input">
											<input type="text" id="email2_pre" name="email2_pre"
												title="이메일 주소">
										</div>
										<span class="mx-4">@</span>			
										<div class="input ml-4">
											<input type="text" id="email2_suf" name = "email2_suf" disabled value="naver.com"/>
										</div>
										<div class="select ml-4">
											<select name="email2_suf_sel" id="email2_suf_sel">
												<option value="1">직접입력</option>
												<option value="naver.com" selected>naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="freechal.com">freechal.com</option>
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="korea.com">korea.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="paran.com">paran.com</option>
											</select>
										</div>
									</div>
									<div class="row">
										<p>※ 이메일 한가지는 필수입력</p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">생년월일</h3>
								<div class="box">
									<div class="row">
										<div class="select">
											<select name="birthday_yy" id="birthday_yy"
												class="av-required">
												<option value="">년 선택</option>
											</select>
										</div>
										<div class="select ml-4">
											<select name="birthday_mm" id="birthday_mm"
												class="av-required">
												<option value="">월 선택</option>
											</select>
										</div>
										<div class="select ml-4">
											<select name="birthday_dd" id="birthday_dd"
												class="av-required">
												<option value="">일 선택</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="">이메일 수신</h3>
								<div class="box">
									<div class="row">
										<label for="email_flag_true" class="radio mr-6"> <input
											type="radio" name="email_flag" id="email_flag_true" hidden
											checked value = "Y"> <span></span>
											<p>동의</p>
										</label> <label for="email_flag_false" class="radio"> <input
											type="radio" name="email_flag" id="email_flag_false" value = "N" hidden>
											<span></span>
											<p>거부</p>
										</label>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="">SMS 수신</h3>
								<div class="box">
									<div class="row">
										<label for="sms_flag_true" class="radio mr-6"> <input
											type="radio" name="sms_flag" id="sms_flag_true" hidden
											checked value = "Y"> <span></span>
											<p>동의</p>
										</label> <label for="sms_flag_false" class="radio"> <input
											type="radio" name="sms_flag" id="sms_flag_false" hidden value = "N">
											<span></span>
											<p>거부</p>
										</label>
									</div>
									<div class="row">
										<p>※ 이메일/SMS 수신을 거부 할 경우 사용에 제한이 발생할 수 있습니다.</p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="">뉴스레터 수신</h3>
								<div class="box">
									<div class="row">
										<label for="news_flag_true" class="radio mr-6"> <input
											type="radio" name="news_flag" id="news_flag_true" hidden value = "Y"
											checked> <span></span>
											<p>동의</p>
										</label> <label for="news_flag_false" class="radio"> <input
											type="radio" name="news_flag" id="news_flag_false" hidden value = "N">
											<span></span>
											<p>거부</p>
										</label>
									</div>
									<div class="row">
										<div class="input">
											<input type="text" id="email3_pre" name="email3_pre"
												title="이메일 주소">
										</div>
										<span class="mx-4">@</span>
										<div class="input ml-4">
											<input type="text" id="email3_suf" name = "email3_suf" disabled value="naver.com"/>
										</div>
										<div class="select ml-4">
											<select name="email3_suf_sel" id="email3_suf_sel">
												<option value="1">직접입력</option>
												<option value="naver.com" selected>naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="freechal.com">freechal.com</option>
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="korea.com">korea.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="paran.com">paran.com</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div id = "parentChkDiv" class="esignup-form-section mt-12" style="display:none">
						<h2>* 만 14세 미만의 어린이는 보호자 동의가 필요합니다.</h2>
						<div class="form">
							<div class="form-row">
								<h3 class="require">보호자 이름</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="prt_name" name="prt_name"
												title="보호자이름">
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">보호자 생년월일</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="prt_birthday" name="prt_birthday" placeholder="ex)2020-11-24"
												title="보호자생년월일">
										</div>
									</div>
								</div>
							</div>

							<div class="form-row">
								<h3 class="">보호자성별</h3>
								<div class="box">
									<div class="row">
										<label for="prt_gender_true" class="radio mr-6"> <input
											type="radio" name="prt_gender" id="prt_gender_true" value ="M" hidden>
											<span></span>
											<p>남성</p>
										</label> <label for="prt_gender_false" class="radio"> <input
											type="radio" name="prt_gender" id="prt_gender_false" value ="F" hidden>
											<span></span>
											<p>여성</p>
										</label>
									</div>
								</div>
							</div>

							<div class="form-row">
								<h3 class="require">휴대전화번호</h3>
								<div class="box">
									<div class="row">
										<div class="input">
											<input type="text" id="prt_phone" name="prt_phone"
												title="보호자 핸드폰번호" placeholder="ex)010-1111-2222">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="actions mt-12">
						<a href="javascript:saveMember();" class="black">가입완료</a> <a
							href="javascript:fn_MovePage('/mem/memLogin.l');">취소</a>
					</div>
				</div>
			</div>
		</div>

	</form>
</body>
