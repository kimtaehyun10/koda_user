<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>전화번호안내 - 주차장소개</title>

    <script>
        //예약문구관리 팝업
        function openLoginPopup() {
            var url = "/mem/popup/loginPopup.p";
            openPopLayer( url, "param=1", "", 400, 400 ,null ,null );
        }
    </script>
</head>
<body>
<div id="Page" class="page sup">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>공영주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>전화번호안내</h2>
            </div>
            <div class="log in">
                <!-- 로그인 이전 -->
                <sec:authorize access="isAnonymous()">
                    <div class="in">
                        <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
                    </div>
                </sec:authorize>
                <!-- 로그인 이후 -->
                <sec:authorize access="isAuthenticated()">
                    <div class="out">
                        <sec:authentication var="user" property="principal"/>
                        <p><span>${user.mberNm}</span>님 환영합니다!</p>
                        <a class="btn red" href="<c:url value='/logout'/>">로그아웃</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
    </div>
    <div class="ct_body">
        <div class="sub_nav">
            <ul>
                <li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
                <li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
                <li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="pub_default">
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>주차사업팀 (Tel. 02-832-2445)</p>
                    <div class="big_box">
                        <table>
                            <caption></caption>
                            <thead>
                            <tr>
                                <th>성명</th>
                                <th>담당업무</th>
                                <th>전화번호</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>팀장 김영호</td>
                                <td>주차사업팀 업무 총괄</td>
                                <td>070-7204-5020</td>
                            </tr>
                            <tr>
                                <td>김선구</td>
                                <td>서무(예산, 회계) 업무, 주차사업팀 총괄 업무</td>
                                <td>070-7204-5021</td>
                            </tr>
                            <tr>
                                <td>이규환</td>
                                <td>거주자우선주차장 총괄 업무, 거주자우선주차장 배정·관리(사당동)</td>
                                <td>070-7204-5022</td>
                            </tr>
                            <tr>
                                <td>윤정숙</td>
                                <td>부정주차 및 거주자우선주차장 배정·관리(대방동 외)</td>
                                <td>070-7204-5023</td>
                            </tr>
                            <tr>
                                <td>전승재</td>
                                <td>거주자우선주차장 배정·관리(상도동)</td>
                                <td>070-7204-5024</td>
                            </tr>
                            <tr>
                                <td>백춘기</td>
                                <td>공영주차장 총괄 업무</td>
                                <td>070-7204-5026</td>
                            </tr>
                            <tr>
                                <td>김일두</td>
                                <td>공영주차장 관리</td>
                                <td>070-7204-5025</td>
                            </tr>
                            <tr>
                                <td>최성인</td>
                                <td>공영주차장 관리</td>
                                <td>070-7204-5027</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>견인차량보관소 (Tel. 02-855-8611~2)</p>
                    <div class="big_box">
                        <table>
                            <caption></caption>
                            <thead>
                            <tr>
                                <th>성명</th>
                                <th>담당업무</th>
                                <th>전화번호</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>소장 장성철</td>
                                <td>견인차량보관소 운영 총괄</td>
                                <td>070-7204-5095</td>
                            </tr>
                            <tr>
                                <td>김정명</td>
                                <td>서무(수입/지출 관리)업무, 미반환차량 공매 업무</td>
                                <td>070-7204-5098</td>
                            </tr>
                            <tr>
                                <td><a class="table_name">송수일<br>박상원<br>김대선<br>최치선<br>김원준<br>윤길선<br>이은배<br>최성인</a></td>
                                <td>고객관리<br>(피견인차량 입·출고 관리, 민원상담)</td>
                                <td><a class="table_name">070-7204-5096<br>070-7204-5099</a></td>
                            </tr>
                            <tr>
                                <td>단속반</td>
                                <td>부정주차 단속</td>
                                <td>820-9209</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>