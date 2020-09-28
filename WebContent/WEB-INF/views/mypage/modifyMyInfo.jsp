<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>

    <title>정보수정</title>
    
    <script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

    <script id="jscode">

        var myValidator = new AXValidator();

        $(function(){
            myValidator.setConfig({
                targetFormName : "frm"
            });
        });

        $(document.body).ready(function () {
        	
        	//사용자정보 조회
        	$.ajax({
                url: "/mypage/searchMemberInfo.json",
                type: "POST",
                data: {},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	
                    $("#mberId").val(data.mberId);
                    $("#mberNm").val(data.mberNm);
                    $("#mberBirth").val(data.mberBirth);
                    $("#mberEmailAdres").val(data.mberEmailAdres);
                    $("#mberPhone").val(data.mberPhone);
                    $("#mbtlnum").val(data.mbtlnum);
                    $("#zip").val(data.zip);
                    $("#adres").val(data.adres);
                    $("#adresNewYn").val(data.adresNewYn);
                    $("#detailAdres").val(data.detailAdres);
                	$("#noticeZip").val(data.noticeZip);
                    $("#noticeAdres").val(data.noticeAdres);
                    $("#noticeDetailAdres").val(data.noticeDetailAdres);
                    $("#noticeAdresNewYn").val(data.noticeAdresNewYn);
                    $("#carKey").val(data.carKey);
                    $("#carNumber").val(data.carNumber);
                    $("#carName").val(data.carName);
                    $("#carZip").val(data.carZip);
                    $("#carAdres").val(data.carAdres);
                    $("#carDetailAdres").val(data.carDetailAdres);
                    $("#carAdresNewYn").val(data.carAdresNewYn);
                },
                complete: function (data) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //Error시, 처리
                }
            });

            //생년월일
            $("#mberBirth").bindDate({
                align: "right", valign: "top", separator: "-", selectType: "d"
            });

            // 고지주소 집주소와 동일
            $("#samAdresChk").change(function() {
                if (axf.isEmpty($("#zip").val() && $("#detailAdres").val())) {
                    axf.alert("집주소가 입력되지 않았습니다.");
                    $("#samAdresChk").attr('checked', false);
                    return;
                } else {
                    if (this.checked) {
                        $("#noticeZip").val($("#zip").val());
                        $("#noticeAdres").val($("#adres").val());
                        $("#noticeDetailAdres").val($("#detailAdres").val());
                        $("#noticeAdresNewYn").val($("#adresNewYn").val());
                    } else {
                        $("#noticeZip").val("");
                        $("#noticeAdres").val("");
                        $("#noticeDetailAdres").val("");
                        $("#noticeAdresNewYn").val("");
                    }
                }
            });

            //할인항목 조회
            searchDiscountItemList();
        });

        //할인항목 - 할인항목 조회
        function searchDiscountItemList() {

            $.ajax({
                url: "/com/searchUseDiscountItemList.json",
                type: "POST",
                data: {
                    discountBusiness: "02", //거주자 : 02, 공용 : 03
                    discountDivision: "01" //할인 : 01, 할증 : 02
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {

                    var htmlSum = "";

                    for (var i = 0; i < data.list.length; i++) {

                        var html = "";

                        html = html + '<li class="selection">';
                        
                        if(data.list[i].myDiscountItemCnt == '0'){
                        	html = html + '<input type="checkbox" name="discountItemList" id="' + data.list[i].discountItemKey + '" value="' + data.list[i].discountItemKey + '" />';
                        }else{
                        	html = html + '<input type="checkbox" name="discountItemList" id="' + data.list[i].discountItemKey + '" value="' + data.list[i].discountItemKey + '" checked />';
                        }
                        
                        html = html + '<label for="' + data.list[i].discountItemKey + '">';
                        html = html + '<span></span>';
                        html = html + data.list[i].discountName + '</label>';
                        html = html + '</li>';

                        htmlSum = htmlSum + html;
                    }

                    $("#discountItemUl").html(htmlSum);

                },
                complete: function (data) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //Error시, 처리
                }
            });
        }
        
        //차량주소 집주소와 동기화
        function carAdresSync() {
            if (axf.isEmpty($("#zip").val() && $("#detailAdres").val())) {
                axf.alert("집주소가 입력되지 않았습니다.");
                return;
            } else {
                $("#carZip").val($("#zip").val());
                $("#carAdres").val($("#adres").val());
                $("#carDetailAdres").val($("#detailAdres").val());
                $("#carAdresNewYn").val($("#adresNewYn").val());
            }
        }

        //회원수정
        function updateMember() {

            var validateResult = myValidator.validate();

            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	
            	if($("#password").val() != '' && $("#passwordCheck").val() == ''){
                    axf.alert("비밀번호를 변경하시려면 [변경 비밀번호 확인]을 입력해주세요.");
                    return;
                }

                if($("#password").val() != $("#passwordCheck").val()){
                    axf.alert("비밀번호와 비밀번호 확인이 같지않습니다. 확인해주세요.");
                    return;
                }
                
                //비밀번호 정규식 체크
                var password = $("#password").val();
                if(password != ''){
                	var acceptPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

                    if(acceptPassword.test(password) == false){

                        axf.alert('비밀번호는 영문/숫자/특수문자를 포함한 8~15글자만 가능합니다.');

                        //$("#password").val("");
                        //$("#passwordCheck").val("");
                        $("#password").focus();
                        return;
                    }
                }

                var mberId = $("#mberId").val();
                var password = $("#password").val();
                var mberNm = $("#mberNm").val();
                var mberBirth = $("#mberBirth").val().replace(/-/gi, '');
                var mberEmailAdres = $("#mberEmailAdres").val();
                var mberPhone = $("#mberPhone").val();
                var mbtlnum = $("#mbtlnum").val();
                var adresNewYn = $("#adresNewYn").val();
                var zip = $("#zip").val();
                var adres = $("#adres").val();
                var detailAdres = $("#detailAdres").val();
                var noticeAdresNewYn = $("#noticeAdresNewYn").val();
                var noticeZip = $("#noticeZip").val();
                var noticeAdres = $("#noticeAdres").val();
                var noticeDetailAdres = $("#noticeDetailAdres").val();
                var carKey = $("#carKey").val();
                var carNumber = $("#carNumber").val();
                var carName = $("#carName").val();
                var carAdresNewYn = $("#carAdresNewYn").val();
                var carZip = $("#carZip").val();
                var carAdres = $("#carAdres").val();
                var carDetailAdres = $("#carDetailAdres").val();
                var lentCarYn = $("#lentCarYn").val();
                var arrDiscountItemKey= [];
                $('input[name="discountItemList"]:checkbox:checked').each(function(){
                    arrDiscountItemKey.push($(this).val());
                });

                $.ajaxSettings.traditional = true;
                $.ajax({
                    url : "/mypage/updateMember.json",
                    type: "POST",
                    data: {
                        mberId : mberId,
                        password : password,
                        mberNm : mberNm,
                        mberBirth : mberBirth,
                        mberEmailAdres : mberEmailAdres,
                        mberPhone : mberPhone,
                        mbtlnum : mbtlnum,
                        adresNewYn : adresNewYn,
                        zip : zip,
                        adres : adres,
                        detailAdres : detailAdres,
                        noticeAdresNewYn : noticeAdresNewYn,
                        noticeZip : noticeZip,
                        noticeAdres : noticeAdres,
                        noticeDetailAdres : noticeDetailAdres,
                        carKey : carKey,
                        carNumber : carNumber,
                        carName : carName,
                        carAdresNewYn : carAdresNewYn,
                        carZip : carZip,
                        carAdres : carAdres,
                        carDetailAdres : carDetailAdres,
                        lentCarYn : lentCarYn,
                        arrDiscountItemKey : arrDiscountItemKey
                    },
                    dataType:"json",
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("회원정보를 수정 성공했습니다.");
                            fn_MovePage('/main');
                        } else {
                            axf.alert("회원정보를 수정 실패했습니다.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
        }

    </script>
</head>
<body>
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>정보수정</h1>
                <!--<h2><i class="axi axi-keyboard-arrow-right"></i>정보수정</h2>-->
            </div>
        </div>
    </div>
    <div class="ct_body">
        
        <form name="frm" id="frm">
        <div class="body full">
            <div class="body full">
                <div class="caption"><!-- 전체 페이지 설명 -->
                    <p>동작구시설관리공단 주차관리시스템에 오신걸 환영합니다!</p>
                    <p>사용자의 정보를 작성한 후 [회원가입] 버튼을 눌러 신청하십시오.</p>
                    <p>* 필수 항목을 꼭 작성하셔야 회원가입이 가능합니다.</p>
                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>사용자 정보 작성</p>
                </div>

                <div class="block" id="memberInfo"><!-- 특별한 목적 없이 어디든 사용하는 컨테이너 -->
                    <div class="line"><!-- 항목별로 나눠서 라인정렬 할 때 -->
                        <label for="mberId">사용자 아이디</label>
                        <input type="text" name="mberId" id="mberId" class="AXInput av-required" maxlength="20" onclick="javascript:mberIdDuplCheckFalse();" readonly />
                    </div>
                    <!-- 
                    <div class="line">
                        <label for="password">기존 비밀번호</label>
                        <input type="password" name="password" id="password" maxlength="15" class="AXInput av-required" />
                    </div>
                     -->
                    <div class="line">
                        <label for="password">변경 비밀번호</label>
                        <input type="password" name="password" id="password" maxlength="15" class="AXInput" />
                        <span class="disc">비밀번호는 영문/숫자/특수문자를 포함한  8~15글자만 가능합니다.</span>
                    </div>
                    <div class="line">
                        <label for="passwordCheck">변경 비밀번호 확인</label>
                        <input type="password" name="passwordCheck" id="passwordCheck" title="비밀번호 확인" maxlength="15" class="AXInput" />
                    </div>
                    <div class="line">
                        <label for="mberNm">이름</label>
                        <input type="text" name="mberNm" id="mberNm" maxlength="16" class="AXInput av-required" readonly />
                        <div class="axi_box">
                            <label for="mberBirth">생년월일</label>
                            <input type="text" name="mberBirth" id="mberBirth" title="생년월일" class="AXInput av-required" readonly />
                        </div>
                        <label for="mberEmailAdres">이메일</label>
                        <input type="text" name="mberEmailAdres" id="mberEmailAdres" title="이메일" maxlength="50" class="AXInput av-required av-email" />
                    </div>
                    <div class="line">
                        <label for="mberPhone">핸드폰 번호</label>
                        <input type="text" name="mberPhone" id="mberPhone" title="핸드폰 번호" maxlength="20" class="AXInput av-required av-phone" />
                        <label for="mbtlnum">전화번호</label>
                        <input type="text" name="mbtlnum" id="mbtlnum" title="전화번호" maxlength="20" class="AXInput av-phone" />
                        <span class="disc">핸드폰 / 전화번호 중 하나는 필히 작성합니다.</span>
                    </div>
                    <div class="line">
                        <label for="">집주소</label>
                        <a class="btn dblue" onclick="execDaumPostcode_UserEdit('zip','adres','detailAdres', 'adresNewYn')">우편번호 검색</a>
                        <input type="hidden" name="adresNewYn" id="adresNewYn"/>
                        <input type="text" name="zip" id="zip" value="" class="wid100 AXInput av-required" title="우편번호" readonly />
                        <input type="text" name="adres" id="adres" value="" class="wid300 AXInput av-required" title="주소" readonly />
                        <input type="text" name="detailAdres" id="detailAdres" value="" class="wid300 AXInput av-required" placeholder="상세주소" />
                    </div>
                    <div class="line">
                        <label for="">고지주소</label>
                        <input type="hidden" name="noticeAdresNewYn" id="noticeAdresNewYn"/>
                        <a class="btn dblue" onclick="execDaumPostcode_UserEdit('noticeZip','noticeAdres','noticeDetailAdres', 'noticeAdresNewYn')">우편번호 검색</a>
                        <input type="text" name="noticeZip" id="noticeZip" value="" class="wid100 AXInput av-required" title="고지우편번호" readonly />
                        <input type="text" name="noticeAdres" id="noticeAdres" value="" class="wid300 AXInput av-required" title="고지주소" readonly />
                        <input type="text" name="noticeDetailAdres" id="noticeDetailAdres" value="" class="wid300 AXInput av-required" placeholder="고지상세주소" />
                        <input name="samAdresChk" id="samAdresChk" type="checkbox" />
                        <label for="samAdresChk"><span></span>집주소 동일</label>
                    </div>
                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>차량 정보 작성</p>
                </div>
                <div class="block" id="carInfo">
                    <div class="line add"><!-- 라인을 추가할 때 사용 -->
                        <input type="hidden" name="carKey" id="carKey" value="" />
                        <input type="text" name="carNumber" id="carNumber" class="wid100 AXInput av-required" maxlength="13" placeholder="차량번호" />
                        <input type="text" name="carName" id="carName" class="wid200 AXInput av-required" maxlength="33" placeholder="차량모델" />

                        <a class="btn dblue" onclick="execDaumPostcode_UserEdit('noticeZip','noticeAdres','noticeDetailAdres', 'noticeAdresNewYn')">우편번호</a>
                        <input type="hidden" name="carAdresNewYn" id="carAdresNewYn"/>
                        <input type="text" name="carZip" id="carZip" value="" class="wid100 AXInput av-required" title="차량우편번호" readonly />
                        <input type="text" name="carAdres" id="carAdres" value="" class="AXInput av-required" title="차량주소" readonly />
                        <input type="text" name="carDetailAdres" id="carDetailAdres" value="" class="AXInput av-required" placeholder="차량등록 상세주소" />
                        <a class="btn green" onclick="carAdresSync();">상동</a>

                        <input name="lentCarYn" id="lentCarYn" type="checkbox" value="Y"/>
                        <label for="lentCarYn"><span></span>임대차량 체크</label>

                        <!--
	                    <a class="btn dblue add"><i class="axi axi-add"></i>차량추가</a>
	                     -->
                    </div>

                    <!-- 추가된 항목
                    <div class="line add">
                        <input id="" class="wid100" type="text" placeholder="차량번호" />
                        <input id="" class="wid100" type="text" placeholder="차량모델" />

                        <a class="btn dblue">우편번호</a>
                        <input id="" class="wid100" type="text" readonly />
                        <input id="" type="text" readonly />
                        <input id="" type="text" placeholder="차량주소" />
                        <a class="btn green">상동</a>

                        <input id="" type="checkbox" value=""/>
                        <label for=""><span></span>임대차량 체크</label>

                        <a class="btn red add"><i class="axi axi-remove"></i>차량삭제</a>
                    </div>
                     -->

                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>할인항목 선택</p>
                </div>

                <div class="block">
                    <div class="caption"><!-- 블럭 안에 캡션은 스타일 달라짐 -->
                        <p>사용자가 해당사항 있는 할인 적용 항목을 모두 선택해 주십시오. (다중선택)</p>
                    </div>

                    <div class="multiple_selection">
                        <ul id="discountItemUl">
                        </ul>
                    </div>
                </div>

                <div class="page_btn">
                    <a class="btn red" onclick="updateMember();">회원정보수정</a>
                    <a class="btn" href="javascript:fn_MovePage('/main');">취소</a>
                </div>
            </div>
        </div>
        </form>
        
    </div>
</div>
</body>