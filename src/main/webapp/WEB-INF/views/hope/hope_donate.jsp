<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">

</script>
</head>
<body>

	<div class="sub__header">
                <h2>기증희망등록이란?</h2>
            </div>
            <div class="register__content">

                <div class="wrap">
                    <div class="sub__tabs">
                        <a href="javascript:fn_MoveUrl('4','1','0')" class="active">기증희망등록이란?</a>
                        <a href="javascript:fn_MoveUrl('4','1','1')">기증희망등록 신청하기</a>


                        <div class="select">
                            <button>기증희망등록이란?</button>
                            <div class="dropdown">
                                <a href="javascript:fn_MoveUrl('4','1','0')" class="">기증희망등록이란?</a>
                                <a href="javascript:fn_MoveUrl('4','1','1')">기증희망등록 신청하기</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="view-cont view1">
                    <div class="box">
                        <div class="row titbox">
                            <div class="wrap">
                                <h3 class="text-center">기증희망등록 방법</h3>
                                <p class="text-center">
                                    기증희망등록은 온라인, 우편, 팩스로도 가능합니다.<br/>
                                    방문 상담을 원하시면 1544-0606으로 문의 바랍니다.
                                </p>
                            </div>
                        </div>
                        <div class="row quick-links">
                            <div class="wrap flex justify-center">
                                <div class="item item1">
                                    <a href="#quickMove" class="">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/laptop.png" alt="" class="img">
                                        <p>온라인</p>
                                    </a>
                                </div>
                                <div class="item item2">
                                    <a href="#quickMove" class="">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/mail.png" alt="" class="img">
                                        <p>우편</p>
                                    </a>
                                </div>
                                <div class="item item3">
                                    <a href="#quickMove" class="">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/fax.png" alt="" class="img">
                                        <p>팩스</p>
                                    </a>
                                </div>
                                <div class="item item4">
                                    <a href="#quickMove" class="">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/phone2.png" alt="" class="img">
                                        <p>방문상담</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="row notify">
                            <div class="wrap text-center">
                                <h3>나의 기증희망등록 사실을 가족과 친구들에게 알려주세요!</h3>
                                <img src="${pageContext.request.contextPath}/resource/assets/images/register1-2.png" alt="" class="img inline-block">
                                <p>
                                    기증희망등록은 본인이 뇌사 또는 사망에 이르렀을 때,<br/>
                                    장기와 조직을 대가없이 기증하겠다는 의사를 표현하는 것입니다.<br/>
                                    <span>법적 효력은 없으며 실제 기증 상황이 오면, 선 순위 보호자 1인의 동의를 반드시 받도록 되어 있습니다. </span><br/>
                                    만약 기증희망등록을 했다면 가족에게 희망등록 사실을 알려주세요.<br/>
                                    생전, 당사자가 기증 의사를 가지고 있다면 남겨진 가족들이 기증을 결정하는데 큰 도움이 됩니다.
                                </p>
                            </div>
                        </div>
                        <div class="row banner-link">
                            <div class="wrap">
                                <div class="txtBox">
                                    <h3>
                                        나의 기증희망등록이<br/>
                                        잘 되어있나요?
                                    </h3>
                                    <a href="" class="inline-block">확인하기</a>
                                </div>
                            </div>
                        </div>
                        <div class="row details">
                            <div class="wrap">
                                <div class="tit">
                                    <p><img src="${pageContext.request.contextPath}/resource/assets/images/register-calligraphy.png" alt="" class=""></>
                                    <p class="mt-4">1인 1개 <strong>기증희망등록카드 갖기</strong> 운동!</p>
                                </div>
                                <div class="img text-center" id="quickMove">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/register1-4.png" alt="" class="inline-block">
                                </div>
                                <div class="linksBox">
                                    <div class="row">
                                        <div class="txtBox flex items-center">
                                            <div class="tit">
                                                <p>기증희망등록 방법 1</p>
                                                <h3>온라인 등록</h3>
                                            </div>
                                            <div class="txt">
                                                <p>한국장기조직기증원 홈페이지(www.koda1458.kr) 접속 후 공인인증서, 아이핀 본인인증 후 등록합니다.</>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="txtBox flex items-center">
                                            <div class="tit">
                                                <p>기증희망등록 방법 2</p>
                                                <h3>방문등록</h3>
                                            </div>
                                            <div class="txt">
                                                <p>가까운 등록기관 방문 후 신청서를 작성합니다. (방문상담 : 1544-0606)</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row big">
                                        <div class="txtBox flex items-center">
                                            <div class="tit">
                                                <p>기증희망등록 방법 3</p>
                                                <h3>우편 또는 팩스</h3>
                                            </div>
                                            <div class="txt">
                                                <p class="mb-4">기증희망등록 신청서를 요청하여 작성 후 우편 또는 팩스(02-3447-5631)로 접수합니다.</p>
                                                <a href="" class="redBtn inline-block text-center">신청서 우편으로 받기</a>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text">
                                        등록 완료 후 ‘기증희망 등록완료’ 문자와 함께 기증희망등록증과 스티커를 집으로 보내드립니다.<br/>
                                        <strong>기증희망등록 상담 : 1544-0606</stron> (운영시간: 오전 9시 ~ 오후 6시)
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</body>
</html>
