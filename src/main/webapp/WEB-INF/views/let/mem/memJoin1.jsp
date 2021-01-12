<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<head>
	<meta http-equiv="refresh" content="<%=session.getMaxInactiveInterval()%>;url=/mem/memLogin.l?loginError=04" />

	<title>회원가입</title>

    <script id="jscode">

    var monthtext=['1','2','3','4','5','6','7','8','9','10','11','12'];
    
    $(document.body).ready(function () {

        var myValidator = new AXValidator();
        
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

                $("#dhospital_idx").html(htmlSum);
                $("#bhospital_idx").html(htmlSum);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
            }
        });
		
		////기증 장기 조회
        $.ajax({
            url: "/com/searchCommonCode.json",
            type: "POST",
            dataType: "json",
            data: {gubn:"02"},
            success: function (data, textStatus, jqXHR) {

                var htmlSum = "";
                for (var i = 0; i < data.list.length; i++) {

                    var html = "";
					html = html + '<option value="' + data.list[i].code + '" >' + data.list[i].name + '</option>';
                    
                    htmlSum = htmlSum + html;
                }

                $("#benefi_parts").html(htmlSum);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
            }
        });
		
		//기증일, 생년월일, 
		
        myValidator.setConfig({
            targetFormName: "frm"
        });
		
        populatedropdown("dday", "dmonth", "dyear");
        populatedropdown("dbday", "dbmonth", "dbyear");
        populatedropdown("bbday", "bbmonth", "bbyear");
        
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

    //기증자 확인
    function checkDonor(){
    	////기증 장기 조회
        /*$.ajax({
            url: "/com/checkdonor.json",
            type: "POST",
            data: $("#frm_donor").serialize(),
            dataType: "json",
            success: function (data, textStatus, jqXHR) {
            	$("#gubn").val("D");
            	
                axf.alert("기증자 가족 확인이 완료 되었습니다.");

            	$("#frm").submit();

            },
            error: function (jqXHR, textStatus, errorThrown) {
                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
            }
        });*/
        
    	$("#gubn").val("D");
        $("#pdonor_name").val($("#donor_name").val());
        $("#pdhospital_idx").val($("#dhospital_idx").val());
        $("#pdonor_date").val($("#dyear").val() + "-" + $("#dmonth").val() + "-" + $("#dday").val());
        $("#pdonor_birth").val($("#dbyear").val() + "-" + $("#dbmonth").val() + "-" + $("#dbday").val());
        
    	
        axf.alert("기증자 가족 확인이 완료 되었습니다.");

    	$("#frm").submit();

    	
    }
    
   //수혜자 확인
    function checkBenefi(){
    	////기증 장기 조회
        /*$.ajax({
            url: "/com/checkbenefi.json",
            type: "POST",
            data: $("#frm_benefi").serialize(),
            dataType: "json",
            success: function (data, textStatus, jqXHR) {
            	$("#gubn").val("B");
            	
                axf.alert("수혜자 확인이 완료 되었습니다.");

            	$("#frm").submit();

            },
            error: function (jqXHR, textStatus, errorThrown) {
                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
            }
        });*/
        
    	$("#gubn").val("B");
        $("#pbenefi_name").val($("#benefi_name").val());
        $("#pbhospital_idx").val($("#bhospital_idx").val());
        $("#pbenefi_parts").val($("#benefi_parts").val());
        $("#pbenefi_birth").val($("#bbyear").val() + "-" + $("#bbmonth").val() + "-" + $("#bbday").val());
        
        axf.alert("수혜자 확인이 완료 되었습니다.");

    	$("#frm").submit();

    	
    }
        
    </script>
</head>

<body>
<!-- <form name="user" method="post"> -->
<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
<!-- </form> -->
	<form name="frm" id="frm" action="/mem/memJoin2.l" method="post">
		<input type="hidden" id="gubn" name="gubn" value="" />
		<input type="hidden" id="pdonor_name" name="pdonor_name" value="" />
		<input type="hidden" id="pdhospital_idx" name="pdhospital_idx" value="" />
		<input type="hidden" id="pdonor_date" name="pdonor_date" value="" />
		<input type="hidden" id="pdonor_birth" name="pdonor_birth" value="" />
		<input type="hidden" id="pbenefi_name" name="pbenefi_name" value="" />
		<input type="hidden" id="pbhospital_idx" name="pbhospital_idx" value="" />
		<input type="hidden" id="pbenefi_parts" name="pbenefi_parts" value="" />
		<input type="hidden" id="pbenefi_birth" name="pbenefi_birth" value="" />
		
	</form>
	<div class="esignup">
		<div class="wrap">
			<h2 class="e-title">회원가입</h2>
			<div class="esignup__process">
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-1-active.png"
							alt="">
					</div>
					<p>회원구분</p>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2.png"
							alt="">
					</div>
					<p>회원선택</p>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-3.png"
							alt="">
					</div>
					<p>약관동의</p>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4.png"
							alt="">
					</div>
					<p>본인인증</p>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-5.png"
							alt="">
					</div>
					<p>정보입력</p>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/eprocess-6.png"
							alt="">
					</div>
					<p>가입완료</p>
				</div>
			</div>

			<div class="einfo">
				· 기증자 또는 수혜자 구분을 합니다.<br /> · 기증자 및 수혜자 정보는 KONOS(질병관리본부)의 정보를 이용하되
				여부만 확인합니다<br /> · 어린이 회원은 부모닙(법적대리인)의 동의하에 부모님(법적대리인)이 본인인증을 하셔야만
				본인인증 절차를 마무리 할 수 있습니다.<br />
			</div>

			<div class="esignup-type">
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/esignup-type1.png"
							alt="">
					</div>
					<h2>기증자</h2>
					<h3>(가족 3인까지)</h3>
					<p>기증자 회원은 기증자 가족 3인까지 가입이 가능합니다.</p>
					<a href="javascript:$('#esignup-1').css('display', 'flex')">기증자
						가입하기</a>
				</div>
				<div class="col">
					<div class="icon">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/esignup-type2.png"
							alt="">
					</div>
					<h2>수혜자</h2>
					<h3>(본인)</h3>
					<p>수혜자 회원은 본인만 가입이 가능합니다.</p>
					<a href="javascript:$('#esignup-2').css('display', 'flex')"
						class="rsv">수해자 가입하기</a>
				</div>
			</div>
		</div>
	</div>

	<div class="modal modal--eisngup" style="display: none;" id="esignup-1">
		<div class="modal__content">
			<header>
				<img
					src="${pageContext.request.contextPath}/resource/assets/images/esignup-logo.png"
					alt="">
				<button class="close" onclick="$('.modal--eisngup').hide();"></button>
			</header>
			<div class="modal__body">
				<form name="frm_donor" id="frm_donor">
					<div class="top">
						<h2>기증자 정보</h2>
						<p>※ 기증자 정보가 일치해야 회원으로 승인 됩니다.</p>
					</div>

					<div class="form">
						<table>
							<colgroup>
								<col class="w1">
								<col>
								<col>
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><strong>기증자명</strong></th>
									<td colspan="3">
										<div class="input">
											<input type="text" id="donor_name" name="donor_name" title="기증자명">
										</div>
									</td>
								</tr>
								<tr>
									<th><strong>기증병원</strong></th>
									<td colspan="3">
										<div class="select">
											<select id="dhospital_idx" name="dhospital_idx" title="기증병원">
											</select>
										</div>
									</td>
								</tr>

								<tr>
									<th><strong>기증일</strong></th>
									<td>
										<div class="select">
											<select name="dyear" id="dyear" title="연도">
												<option value="">년</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="dmonth" id="dmonth" title="월">
												<option value="">월</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="dday" id="dday" title="일">
												<option value="">일</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th><strong>생년월일</strong></th>
									<td>
										<div class="select">
											<select name="dbyear" id="dbyear" title="년">
												<option value="">년</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="dbmonth" id="dbmonth" title="월">
												<option value="">월</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="dbday" id="dbday" title="일">
												<option value="">일</option>
											</select>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<button type="button" class="submit" onclick="javascript:checkDonor()">확인</button>
				</form>
			</div>
		</div>
	</div>

	<div class="modal modal--eisngup" style="display: none;" id="esignup-2">
		<div class="modal__content">
			<header>
				<img
					src="${pageContext.request.contextPath}/resource/assets/images/esignup-logo.png"
					alt="">
				<button class="close" onclick="$('.modal--eisngup').hide();"></button>
			</header>
			<div class="modal__body">
				<form name="frm_benefi" id="frm_benefi">
					<div class="top">
						<h2>수혜자 정보</h2>
						<p>※ 수혜자 정보가 일치해야 회원으로 승인 됩니다.</p>
					</div>

					<div class="form">
						<table>
							<colgroup>
								<col class="w1">
								<col>
								<col>
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><strong>수혜자명</strong></th>
									<td colspan="3">
										<div class="input">
											<input type="text" id="benefi_name" name="benefi_name" title="수혜자명">
										</div>
									</td>
								</tr>
								<tr>
									<th><strong>수혜병원</strong></th>
									<td colspan="3">
										<div class="select">
											<select id="bhospital_idx" name="bhospital_idx" title="기증병원">
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th><strong>수혜장기</strong></th>
									<td colspan="3">
										<div class="select">
											<select id="benefi_parts" name="benefi_parts" title="수혜장기">
												<option value="">선택하세요.</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th><strong>생년월일</strong></th>
									<td>
										<div class="select">
											<select name="bbyear" id="bbyear" title="년">
												<option value="">년</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="bbmonth" id="bbmonth" title="월">
												<option value="">월</option>
											</select>
										</div>
									</td>
									<td>
										<div class="select">
											<select name="bbday" id="bbday" title="일">
												<option value="">일</option>
											</select>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<button type="button" class="submit" onclick="javascript:checkBenefi()">확인</button>
				</form>
			</div>
		</div>
	</div>	
</body>
