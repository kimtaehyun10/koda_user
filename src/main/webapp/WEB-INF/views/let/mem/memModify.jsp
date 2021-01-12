<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<head>
	<meta http-equiv="refresh" content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />
	<script type="text/javascript" src="<spring:eval expression="@appConfig['daum.addr.js.path']"/>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

	<title>회원가입</title>

    <script id="jscode">

   		var myValidator = new AXValidator();

    	var monthtext=['1','2','3','4','5','6','7','8','9','10','11','12'];
    	
    	//닉네임 중복 확인용 변수
        var nickCheck = 'Y';
        var checkFinishNick = '';

        $(document.body).ready(function () {
			
            //가족관계 조회			
            $.ajax({
                url: "/com/searchCommonCode.json",
                type: "POST",
                dataType: "json",
                data: {gubn:"01"},
                success: function (data, textStatus, jqXHR) {
					if (data.length>0){
						
					}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
            
            myValidator.setConfig({
                targetFormName: "frm"
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
            
            //내정보 조회		
            $.ajax({
                url: "/let/searchMember.json",
                type: "POST",
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
					$("#id").html(data.id);
					checkFinishNick
					$("#name").html(data.name);
					$("input:radio[name='gender']:radio[value='" + data.gender + "']").attr("checked",true);
					$("#nick_name").val(data.nickName);
					checkFinishNick = data.nickName;
					$("#post").val(data.post);
					$("#address").val(data.address);
					$("#address_detail").val(data.addressDetail);
					$("#p_phone").html(data.phone);
					$("#phone").val(data.phone);
					
					$("#email").val(data.email);
					$("#email_pre").val((data.email).split('@')[0]);
					$("#email_suf").val((data.email).split('@')[1]);					
					$("#email_suf_sel").val((data.email).split('@')[1]).prop("selected",true);
					if ($("#email_suf_sel").val() == null || $("#email3_suf_sel").val() == ""){
						$("#email_suf_sel").val("1").prop("selected",true);
					}

					$("#email2").val(data.email2);
					$("#email2_pre").val((data.email2).split('@')[0]);
					$("#email2_suf").val((data.email2).split('@')[1]);					
					$("#email2_suf_sel").val((data.email2).split('@')[1]).prop("selected",true);
					if ($("#email2_suf_sel").val() == null || $("#email2_suf_sel").val() == "" ){
						$("#email2_suf_sel").val("1").prop("selected",true);
					}

					$("#birthday").val(data.birthday);
					$("#birthday_yy").val((data.birthday).split('-')[0]);
					$("#birthday_mm").val((data.birthday).split('-')[1]);
					$("#birthday_dd").val((data.birthday).split('-')[2]);

					$("input:radio[name='email_flag']:radio[value='" + data.emailFlag + "']").attr("checked",true);
					$("input:radio[name='sms_flag']:radio[value='" + data.smsFlag + "']").attr("checked",true);
					$("input:radio[name='news_flag']:radio[value='" + data.newsFlag + "']").attr("checked",true);

					$("#email3").val(data.email3);
					$("#email3_pre").val((data.email3).split('@')[0]);
					$("#email3_suf").val((data.email3).split('@')[1]);					
					$("#email3_suf_sel").val((data.email3).split('@')[1]).prop("selected",true);
					if ($("#email3_suf_sel").val() == null || $("#email3_suf_sel").val() == ""){
						$("#email3_suf_sel").val("1").prop("selected",true);
					}
					
	            	$("#div_donor_relation").html(donorHtml);
					
					//14세미만 부모 동의
					if (data.prtName == null || data.prtName == ""){
		            	$("#parentChkDiv").css("display","none");
		            	$("#prt_name").removeClass("av-required");
		            	$("#prt_birthday").removeClass("av-required");
		            	$("#prt_phone").removeClass("av-required");
					}else{
		            	$("#parentChkDiv").css("display","");
		            	$("#prt_name").addClass("av-required");
		            	$("#prt_birthday").addClass("av-required");
		            	$("#prt_phone").addClass("av-required");

						$("#p_prt_name").html(data.prtName);
						$("#p_prt_birthday").html(data.prtBirthday);
						$("#p_prt_gender").html(function(){
							if (data.prtGender == "M"){
								return "남성";
							}else{
								return "여성";
							}		
						});
						$("#p_prt_phone").html(data.prtPhone);
						
						$("#prt_name").val(data.prtName);
						$("#prt_birthday").val(data.prtBirthday);
						$("#prt_gender").val(data.prtGender);
						$("#prt_phone").val(data.prtPhone);
					}
					

					//기증자 정보
					if (data.donorName == null || data.donorName == ""){
		            	$("#donorChkDiv").css("display","none");
					}else{
						$("#donorChkDiv").css("display","");
						
						$("#p_donor_name").html(data.donorName);
						$("#p_donor_hospital").html(data.donorHospital);
						$("#p_donor_date").html(data.donorDate);
						$("#p_donor_birth").html(data.donorBirth);
						
						//기증자 관계
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
					}
					

					//수혜자 정보
					if (data.benefiName == null || data.benefiName == ""){
		            	$("#benefiChkDiv").css("display","none");
					}else{
						$("#benefiChkDiv").css("display","");
						
						$("#p_benefi_name").html(data.benefiName);
						$("#p_benefi_hospital").html(data.benefiHospital);
						$("#p_benefi_part").html(data.benefiPart);
						$("#p_benefi_birth").html(data.benefiBirth);
					}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
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
        
        
        //닉네임 중복확인

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
        function updateMember() {

            var validateResult = myValidator.validate();

            if (!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            } else {

               
                if (nickCheck != 'Y') {
                    axf.alert("닉네임 중복확인을 해주세요.");
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
                    url: "/let/updateMember.json",
                    type: "POST",
                    data: $('#frm').serialize(),
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("정보수정이 완료 되었습니다. 다시 로그인 해주십시요.");
                    		document.getElementById('logout-form').submit();     
                        } else {
                            axf.alert("수정에 실패했습니다.");
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
	<form name="frm" id="frm" method="post">
		<input type="hidden" id="email" name="email" value="" />
		<input type="hidden" id="email2" name="email2" value="" />
		<input type="hidden" id="email3" name="email3" value="" />
		<input type="hidden" id="birthday" name="birthday" value="" />

		<div class="esignup">
			<div class="wrap">
				<h2 class="e-title">내 정보</h2>
				<div class="esignup-form">

					<div class="esignup-form-section">
						<h2>내 정보 관리</h2>
						<div class="form">
							<div class="form-row">
								<h3 class="require">아이디</h3>
								<div class="box">
									<div class="row">
										<p id="id"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">이름</h3>
								<div class="box">
									<div class="row">
										<p id="name"></p>
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
											type="radio" name="gender" id="gender_true" value ="M" hidden>
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
										<p id="p_phone"></p><button type="button" onclick="">휴대전화번호 변경</button>
										<input type="text" id="phone" name="phone" title="핸드폰번호" value=""
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
												class="av-required" disabled>
												<option value="">년 선택</option>
											</select>
										</div>
										<div class="select ml-4">
											<select name="birthday_mm" id="birthday_mm"
												class="av-required" disabled>
												<option value="">월 선택</option>
											</select>
										</div>
										<div class="select ml-4">
											<select name="birthday_dd" id="birthday_dd"
												class="av-required" disabled>
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
										</label> <label for="email_flag_false" class= "radio"> <input
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
						<h2>보호자 동의</h2>
						<div class="form">
							<div class="form-row">
								<h3 class="require">보호자 이름</h3>
								<div class="box">
									<div class="row">
										<p id="p_prt_name"></p>
										<div class="input">
											<input type="hidden" id="prt_name" name="prt_name"
												title="보호자이름" disabled>
										</div>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">보호자 생년월일</h3>
								<div class="box">
									<div class="row">
										<p id="p_prt_birthday"></p>
										<div class="input">
											<input type="hidden" id="prt_birthday" name="prt_birthday" placeholder="ex)2020-11-24"
												title="보호자생년월일" disabled>
										</div>
									</div>
								</div>
							</div>

							<div class="form-row">
								<h3 class="">보호자성별</h3>
								<div class="box">
									<div class="row">
										<p id="p_prt_gender"></p>
										<div class="input">
											<input type="hidden" id="prt_gender" name="prt_gender"
												title="" disabled value = "">
										</div>
									</div>
								</div>
							</div>

							<div class="form-row">
								<h3 class="require">휴대전화번호</h3>
								<div class="box">
									<div class="row">
										<p id="p_prt_phone"></p><button type="button" onclick="mberNickNameDuplCheck();">휴대전화번호 변경</button>
										<div class="input">
											<input type="hidden" id="prt_phone" name="prt_phone"
												title="보호자 핸드폰번호" placeholder="ex)010-1111-2222" disabled>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<!-- 기증자 정보 -->
					<div id = "donorChkDiv" class="esignup-form-section mt-12" style="display:none">
						<h2>기증자 정보</h2>
						<div class="form">
							<div class="form-row">
								<h3 class="require">기증자 이름</h3>
								<div class="box">
									<div class="row">
										<p id="p_donor_name"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">기증병원</h3>
								<div class="box">
									<div class="row">
										<p id="p_donor_hospital"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="">기증일</h3>
								<div class="box">
									<div class="row">
										<p id="p_donor_date"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">기증자 생년월일</h3>
								<div class="box">
									<div class="row">
										<p id="p_donor_birth"></p>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					<!-- 수혜자 정보 -->
					<div id = "benefiChkDiv" class="esignup-form-section mt-12" style="display:none">
						<h2>수혜자 정보</h2>
						<div class="form">
							<div class="form-row">
								<h3 class="require">수혜자 이름</h3>
								<div class="box">
									<div class="row">
										<p id="p_benefi_name"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">수혜병원</h3>
								<div class="box">
									<div class="row">
										<p id="p_benefi_hospital"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="">수혜장기</h3>
								<div class="box">
									<div class="row">
										<p id="p_benefi_part"></p>
									</div>
								</div>
							</div>
							<div class="form-row">
								<h3 class="require">수혜자 생년월일</h3>
								<div class="box">
									<div class="row">
										<p id="p_benefi_birth"></p>
									</div>
								</div>
							</div>
						</div>
					</div>

            <div class="actions mt-12">
						<a href="javascript:updateMember();" class="black">수정하기</a> <a
							href="javascript:fn_MovePage('/let/ㅣletterMain.l');">취소</a>
            </div>
        </div>
    </div>
    </div>

	</form>
</body>
