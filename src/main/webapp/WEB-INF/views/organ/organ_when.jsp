<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
    
</head>
<body>
            <div class="wrap">
                <div class="section">
                    <h2 class="section__title">
                        기증은 언제 이루어지나요?
                    </h2>
                    <p class="section__description">
                        <strong>“장기기증은 뇌의 모든 기능을 상실한 뇌사상태에서만 가능합니다”</strong><br/>
                        <br/>
                        뇌사는 몸은 아직 따뜻하지만 자발호흡이 불가능하고 어떤 치료에도
                        회복이 불가능하여 수 일 또는 수 주 이내 사망에 이르게 되는 상태입니다.<br/>
                        흔히 혼동하고 있는 식물인간의 경우에는 뇌사가 아님으로 기증이 불가능합니다.<br/>
                        <br/>
                        한국장기조직기증원은 뇌사장기기증 및 인체조직기증 업무를 담당하고 있으며,<br/>
                        <span class="text-red-500">생존 시 기증은 각 병원에서 국가의 승인을 받아 진행하고 있습니다.</span>
                    </p>
                </div>
            </div>

            <div class="sub__fullbox">
            <div class="wrap">
                <img src="${pageContext.request.contextPath}/resource/assets/images/sub1-img.png" alt="" class="fullbox-img">
                <div onclick="javascript:fn_MoveUrl('1','2','4')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i1.png" alt=""></span>
                    <p>장기기증</p>
                </div>
                <div onclick="javascript:fn_MoveUrl('1','2','5')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i2.png" alt=""></span>
                    <p>조직기증</p>
                </div>
                <div onclick="javascript:fn_MoveUrl('4','1','0')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i3.png" alt=""></span>
                    <p>기증희망등록</p>
                </div>
            </div>
        </div>

            <div class="wrap">
                <div class="section">
                    <p class="section__description text-center">
                        <strong>“뇌사와 식물인간은 엄연히 다릅니다.”</strong><br/>
                        <br/>
                        뇌사는 사고 또는 질환으로 <span class="text-red-500">뇌기능이 손상된 상태로 자발적 호흡이 불가능하며,</span><br/>
                        <span class="text-red-500">인공호흡기에 의존하여 맥박, 혈압, 호흡 등을 일시적으로 유지할 수 있으나,<br/>
                        어떤 치료 노력에도 2주</span> 이내 사망에 이르는 상태를 말합니다.<br/>
                        ※ 식물인간은 자발호흡이 가능하고 <span class="text-red-500">수개월~수년 이내 회복 가능성이 있는 상태로 장기기증의 대상이 될 수 없습니다.</span>
                    </p>
                </div>

                <div class="flex sub4-imgbox">
                    <div class="flex-1">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/sub4-img1.png" alt="" class="mx-auto">
                    </div>
                    <div class="flex-1">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/sub4-img2.png" alt="" class="mx-auto">
                    </div>
                </div>

                <div class="info-section">
                    <h3 class="info-section__title">뇌사와 식물인간의 차이</h3>
                    <div class="info-section__table">
                        <table>
                            <colgroup>
                                <col width="120">
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                            <tr>
                                <th>구분</th>
                                <th>식물인간 상태</th>
                                <th>뇌사 상태</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th>손상부위</th>
                                <td>대뇌의 일부</td>
                                <td>뇌간을 포함한 뇌 전체</td>
                            </tr>
                            <tr>
                                <th>기능장애</th>
                                <td>기억, 사고 등 대뇌장애</td>
                                <td>심박동 외 모든 기능 정지</td>
                            </tr>
                            <tr>
                                <th>운동능력</th>
                                <td>목적없는 약간의 움직임 가능</td>
                                <td>움직임 전혀 없음</td>
                            </tr>
                            <tr>
                                <th>호흡</th>
                                <td>자발적 호흡 가능</td>
                                <td>자발적 호흡 불가능</td>
                            </tr>
                            <tr>
                                <th>경과내용</th>
                                <td>수개월, 수년까지도 생존가능하고, 회복도 가능</td>
                                <td>어떤 적극적 치료에도 사망</td>
                            </tr>
                            <tr>
                                <th>기증여부</th>
                                <td>장기기증 불가능</td>
                                <td>장기기증 가능</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="info-section mt-20">
                    <h3 class="info-section__title">장기기증과 조직기증의 차이</h3>
                    <p class="info-section__description">
                        <strong>장기기증</strong>은 심장, 신장, 간, 폐 등 장기의 손상이나 정지된 기능을 회복하기 위하여 이식이 필요한 환자에게 기증하는 것이며<br/>
                        <strong>인체조직</strong>은 각막, 뼈, 피부, 인대, 혈관 등 기능적 장애가 있는 환자의 재건과 기능회복을 위해 기증됩니다. 기증된 조직은 임플란트, 연골 이식 등
                        생활 곳곳에서 쓰여집니다.
                    </p>
                    <div class="flex mt-6">
                        <div class="flex-1 mr-8">
                            <div class="info-section__table">
                                <header class="red">뇌사 시 장기기증</header>
                                <table>
                                    <colgroup>
                                        <col width="120">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th>종류</th>
                                        <td>
                                            신장, 간장, 췌장, 심장, 폐, 안구, 췌도, 소장, 대장, 위장,
                                            십이지장, 비장, 손·팔, 발·다리
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>기증시기</th>
                                        <td>뇌사 시</td>
                                    </tr>
                                    <tr>
                                        <th>이식시기</th>
                                        <td>즉각적으로 이식</td>
                                    </tr>
                                    <tr>
                                        <th>특징</th>
                                        <td>한 사람의 기증으로 최대 8명이 수혜 가능</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="flex-1">
                            <div class="info-section__table">
                                <header class="">인체조직기증</header>
                                <table>
                                    <colgroup>
                                        <col width="120">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th>종류</th>
                                        <td>
                                            피부, 뼈, 인대 및 건, 혈관, 연골, 심장판막, 근막, 신경,
                                            심낭, 양막(생존 시)
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>기증시기</th>
                                        <td>사망 후 24시간 이내</td>
                                    </tr>
                                    <tr>
                                        <th>이식시기</th>
                                        <td>가공, 처리 및 보관 거쳐 이식(최장 5년 보관)</td>
                                    </tr>
                                    <tr>
                                        <th>특징</th>
                                        <td>한 사람의 기증으로 다수의 환자들에게 기증 가능</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="sub__video mt-20">
                    <iframe src="https://www.youtube.com/embed/QYbsGilKpGQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                </div>
            </div>
</body>
</html>
