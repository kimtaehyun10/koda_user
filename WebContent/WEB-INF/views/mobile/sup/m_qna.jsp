<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Referrer" content="origin">

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>자주묻는질문 - 고개지원</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_main.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_sub.css"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobile/m_common.js"></script>

    <script>

        $(document).ready(function () {

            $('.qna > ul > li > .q').click(function () {
                if($(this).parent().hasClass('active') == false){
                    $('.qna > ul > li').removeClass('active');
                    $(this).parent().addClass('active');
                }
            });
        });

    </script>
</head>
<body>
<div class="wrap">
    <div class="header">
        <sec:authorize access="isAnonymous()">
            <a class="add_login" title="로그인화면 호출"></a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a class="add_login on" title="로그인화면 호출"></a>
        </sec:authorize>

        <a class="add_menu" title="메뉴화면 호출"></a>
        <div class="logo" onclick="fn_MovePage('/m/main');">
            <img src="${pageContext.request.contextPath}/resource/images/mobile/m_logo.png" alt="동작구시설관리공단 주차시설 로고" />
        </div>
    </div>

    <div class="contents">
        <div class="page sup">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>고개지원</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>자주묻는질문</h2>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body">
                    <div class="caption">
                        <p>고객님들께서 자주 궁금해 하시는 내용만을 모아 놓았습니다.</p>
                    </div>

                    <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                        <i class="axi axi-label"></i>
                        <p>Q&A</p>
                    </div>
                    <div class="block">
                        <div class="caption">
                            <p>궁금하신 해당 항목을 클릭하여 답변을 확인해 주십시오.</p>
                        </div>
                        <div class="qna">
                            <ul>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>민원안내 전화번호는?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>거주자우선주차 832-2445~6</p>
                                            <p>공영주차 832-2445~6</p>
                                            <p>견인보관소 855-8611~2</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자우선주차란?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>주택가의 주차난 해소와 무질서한 주차질서를 바로 잡기 위해, 이면도로에 주차구획을 설치하고 관리번호를 지정하여 사용 신청자에게 주차면을 배정한 후 일정액의 사용요금을 납부하고 사용토록 하는 제도입니다.</p>
                                            <p>이면도로의 기능이 상실되면 소방차 등 긴급차량의 통행이 불가능하게 되므로, 이에 대한 교통 환경을 개선하는 등 부정주차 차량으로 인명과 재산의 피해를 최소화 할 목적으로 시행하고 있습니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자우선주차를 신청하는 방법은?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>1. 구비서류</p>
                                            <p>주민등록증(등본), 자동차등록증, 사업자등록증(사업자), 장애인등록증(해당자), 국가유공자증명서(해당자)</p>
                                            <br>
                                            <p>2. 신청방법</p>
                                            <p>1) 방 문 신 청 : 동작구도시시설관리공단 방문후(구비서류 지참), 신청서 작성</p>
                                            <p>2) 팩 스 신 청 : 신청서 수신/작성후, 구비서류 포함하여 공단에 팩스 송신</p>
                                            <p>3) 인터넷신청 : 공단홈페이지 거주자우선주차 화면에서 이용신청 메뉴 이용</p>
                                            <br>
                                            <p>3. 신청접수 및 배정절차</p>
                                            <p>접수확인 -> 대기자등록 -> 미배정구획 검색 -> 우선순위에 의한 배정(전화확인) -> 주차요금 지로고지서 발송 -> 고지서 납부 -> 주차증(고지서영수증) 부착후 사용</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자요금 환불신청은 어떻게 해야 하나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>1. 환불사유 : 이사, 공사등으로 인한 삭선, 차량매매, 사용포기, 기타 (장애인 및 경차 적용, 주차방법 변경 등)</p>
                                            <br>
                                            <p>2. 환불절차 : 해당 환불사유 발생시 주차장 사용 종료일을 기준으로 공단에 내방해서 환불신청서 작성하시면 잔여기간을 일할계산하여 신청일 기준 14일 이내에 거주자우선주차 사용자에게 계좌입금해 드립니다.</p>
                                            <br>
                                            <p>3. 구비서류(FAX로 제출가능)</p>
                                            <p>❶ 환불신청서 1부.</p>
                                            <p>❷ 주차증(주차요금 납부영수증)</p>
                                            <p>❸ 통장사본 (거주자우선주차 신청인 명의)</p>
                                            <p>※ 대리인 통장으로 신청시에는 신청인과 같이 등재된 주민등록등본 또는 의료보험증 지참</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자우선주차장 사용시 차량소유주가 본인으로 되어 있어야 하나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>차량소유는 본인으로 되어있는 것이 원칙이나, 타인 소유라 할지라도 신청인과의 관계를 증빙할수 있는 근거자료(회사차량일 경우 재직증명서, 렌트차량일 경우 임대계약서 등) 제출을 통해 배정이 가능합니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자우선주차장에서 차량이 훼손되었을 경우 어떻하나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>관리자가 상주하지 않는 거주자우선주차장의 경우 차량 훼손으로 인한 책임은 차량소유자인 본인에게 있습니다. (주차장법제10조의2에 의거)</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 거주자우선주차제 이용시 지켜야할 사항은 무엇인가요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>❶ 주차요금을 납입기한내 납부해야함.</p>
                                            <p>※ 납부독려후 미납시 자동취소 처리됨</p>
                                            <p>❷ 요금납부후 소인처리된 지로영수증을 주차증으로 사용하시기 바랍니다.</p>
                                            <p>❸ 주차증은 운전석 좌측앞 유리창 하단에 부착하시기 바랍니다.</p>
                                            <p>❹ 배정된 구획안에 배정된 차량으로서 지정시간에만 주차할수 있으며 지정시간외 주차시 단속(견인)될 수 있습니다.</p>
                                            <p>※ 전일 : 24시간, 주간 : 09시 ~ 18시, 야간 : 19시 ~ 익일08시</p>
                                            <p>❺ 배정차량 변경시 주차증을 공단에서 교체하시기 바랍니다.</p>
                                            <p>※ 구비서류 : 변경신청서, 신규자동차등록증</p>
                                            <p>※ FAX로 신청시 공단홈페이지에서 주차증 출력 가능함.</p>
                                            <p>❻ 주차증 미부착시 요금납부한 차량도 단속(견인)될 수 있습니다.</p>
                                            <p>❼ 주차증은 양도 할 수 없으며, 중도해지시 반납하시기 바랍니다.</p>
                                            <p>❽ 주차증은 복사하여 사용할 수 없으며, 복사한 주차증 및 소인처리 안된 주차증을 사용시 단속(견인) 될 수 있습니다.</p>
                                            <p>❾ 배정된 주차구획내 청소는 사용자 책임이오니 관리를 해주시기 바랍니다.</p>
                                            <p>❿ 주차장을 차량주차 외 타용도로 사용시 차후 주차장 배정에서 배제됩니다. (주차후 여유공단에 적치물등을 방치하는 행위 등)</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 경차 할인에 대한 적용은 몇 CC부터 되는건가요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>1,000CC 미만 차량에 대해서만 적용됩니다. 자동차관리법 제3조 및 동법시행규칙 제2조의 규정에 의한 경형 자동차(1,000cc 미만의 승용/승합/화물/특수 자동차로서 길이 3.5미터/너비 1.5미터/높이 2.0미터 이하의 것)가 이에 해당됩니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 버스나 대형차량 주차가 가능합니까?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>현재 동작구의 거주자우선주차장은 버스주차 및 대형차량 주차가 불가합니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 부정주차로 견인될 경우 과태료가 부과 되나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>부정주차로 단속되어 견인되면 견인료 및 보관료만 납부하시면 됩니다. 과태료는 부과되지 않습니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 주간이나 야간만 배정받았을 경우에 주차시간을 지키지 않으면 단속이 되나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p><b>예</b>. 주간배정자는 주간에만 주차가 가능하며, 야간 배정자는 야간에만 주차가 가능합니다. 해당 시간을 지키지 않을 경우는 견인될 수 있으니 해당시간을 지켜주시기 바랍니다.</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 주차단속 신고는 어떻게 하나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>주자우선주차장을 이용하시는 주민들의 편의를 위해 상설단속반을 24시간 운영하고 있으며, 단속이 필요한 경우 언제든지 연락주시면 신속한 처리를 위해 노력하겠습니다.거주자단속 상황실 820-9209</p>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a class="q">
                                        <span>Q</span>
                                        <div>
                                            <p>[거주자우선주차] 주차 단속은 어떻게 하나요?</p>
                                        </div>
                                    </a>
                                    <div class="a">
                                        <span>A</span>
                                        <div>
                                            <p>거주자우선주차제 시행구간에서 배정받지 않은 차량이 주차구획내에 주차하는 경우에는 부정주차로서 주차장법제8조의2규정에 따라 견인조치하고 있습니다. 또한 주민불편 해소차원에 대해서는 전화 계도 등의 경고 없이 즉시 견인을 하고 있습니다.</p>
                                            <p>그리고, 도로교통법 등 주차단속법규에서는 단속 전 경고방송이나 경고장 부착을 규정하지 않고 있습니다. </p>
                                            <p>또한, 거주자우선주차 구획내 부정주차에 대해서는 신고에 의한 단속외에 순찰식 합동단속을 병행하여 운영하고 있으니 단속반으로 연락주시기 바랍니다.</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="ft_img">
            <img src="${pageContext.request.contextPath}/resource/images/mobile/m_footer_img.png" alt="자동자 아이콘 이미지" />
        </div>
        <div class="ft_box">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/resource/images/mobile/m_logo_footer.png" alt="동작구시설관리공단 주차시설 흑백 로고" />
            </div>
            <address>서울시 동작구 보라매 5길 28 (신대방2동 395번지) 공단본부</address>
                <span>TEL)
                    <a href="tel:+8228322445" title="동작구시설관리공단 공단본부 전화번호">02-832-2445</a>
                </span>
            <span>FAX) 02-832-2963</span>

            <p>COPYRIGHT ⓒ 2016 동작구시설관리공단 ALL RIGHTS RESERVED</p>
        </div>
    </div>
</div>
</div>

<!-- 이곳 부터 숨겨져있는 화면 -->
<div id="bgMask" class="mask" style="display:none;"></div>

<!-- 호출되는 로그인 화면 -->
<div id="loginContainer" class="login">
    <div class="head">
        <a class="close_container" title="닫기"></a>
        <h1>로그인</h1>
    </div>
    <div class="body">
        <!-- 로그인 이전 -->
        <sec:authorize access="isAnonymous()">
            <form id="loginForm" name="loginForm" action="<c:url value='/loginProc'/>" method="post">
                <div class="login_box">
                    <input id="user_id" name="user_id" class="text" type="text" placeholder="아이디" />
                    <input id="user_pw" name="user_pw" class="text" type="password" placeholder="비밀번호" />
                    <a class="btn in green submit" onclick="javascript:loginProc();">로그인</a>

                    <p>모바일버전은 읽기전용 사이트 입니다.</p>
                    <p>회원가입 및 각 이용신청은 PC버전을 통해서만 가능합니다.</p>
                </div>
            </form>
        </sec:authorize>

        <!-- 로그인 이후 -->
        <sec:authorize access="isAuthenticated()">
            <div class="login_box">
                <sec:authentication var="user" property="principal" />
                <p><span>${user.mberNm}</span>님 환영합니다.</p>
                <a class="btn in red submit" href="<c:url value='/logout'/>">로그아웃</a>

                <p>모바일버전은 읽기전용 사이트 입니다.</p>
                <p>주차장 이용신청은 PC버전을 통해서만 가능합니다.</p>
            </div>
        </sec:authorize>

        <hr>
        <div class="link_box">
            <ul>
                <li><a href="http://www.idongjak.or.kr/page/about/people" target="_blank">부서업무 / 직원안내</a></li>
                <li><a href="http://www.idongjak.or.kr/page/community/minwon" target="_blank">고객담당자안내</a></li>
                <li><a href="http://www.idongjak.or.kr/page/community/minwon" target="_blank">주요시설위치안내</a></li>
                <li><a href="http://www.idongjak.or.kr/popup/main/privacy.php" target="_blank">개인정보보호방침</a></li>
                <li><a href="http://idongjak.or.kr/popup/main/e-mail.gif" target="_blank">이메일수집거부</a></li>
            </ul>
        </div>
    </div>
</div>

<!-- 호출되는 메뉴 화면 -->
<div id="menuContainer" class="menu">
    <div class="head">
        <a class="close_container" title="닫기"></a>
        <h1>전체메뉴</h1>
    </div>
    <div class="body">
        <div class="menu_box">
            <ul class="nav">
                <li class="res">
                    <a><i class="axi axi-home"></i>거주자우선주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/res/parkingIntro.m');">주차장소개</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/enforcementBasis.m');">시행근거</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/regulateBasis.m');">단속근거</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/parkingCondition.m');">주차장현황</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/moduparkingIntro.m');">모두의주차장소개</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/defaultChargeInfo.m');">미납요금안내</a></li>
                    </ul>
                </li>
                <li class="vst">
                    <a><i class="axi axi-accessibility"></i>방문주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/vst/visitParking.m');">방문주차소개</a></li>
                    </ul>
                </li>
                <li class="pub">
                    <a><i class="axi axi-local-parking"></i>공영주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/pub/parkingIntro.m');">주차장소개</a></li>
<!--                         <li><a href="javascript:fn_MovePage('/m/pub/parkingCondition.m');">주차장현황</a></li> -->
                        <li><a href="javascript:fn_MovePage('/m/pub/defaultChargeInfo.m');">미납요금안내</a></li>
                    </ul>
                </li>
                <li class="tow">
                    <a><i class="axi axi-warning"></i>견인보관소</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/tow/towStorageInfo.m');">견인보관소안내</a></li>
                    </ul>
                </li>
                <li class="mypage">
                    <a><i class="axi axi-person"></i>나의 주차정보</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/mypage/parkingContract.m');">주차장계약</a></li>
                        <li><a href="javascript:fn_MovePage('/m/mypage/standbyStatus.m');">대기현황조회</a></li>
                    </ul>
                </li>
                <li class="sup active">
                    <a><i class="axi axi-explore"></i>고객지원</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/sup/notice.m');">공지사항</a></li>
                        <li class="on"><a href="javascript:fn_MovePage('/m/sup/qna.m');">자주묻는질문</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/phoneInfo.m');">전화번호안내</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/visitMap.m');">찾아오시는길</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>