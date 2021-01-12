<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">

</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>기증적합성평가</h2>
                </div>
                <div class="medical__content medical__conformance">
                    <div class="box box1 flex">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/conformance1.png" alt="">
                        </div>
                        <div class="txtBox">
                            <div class="tit">“장기 등 이식에 관한 법률” 이식 금기 사항</div>
                            <div class="txt">
                                <p class="flex items-start">
                                    <span>1.</span>이식하기에 적합하지 아니한 감염성 병원체에 감염된 장기 (활동성 결핵, HIV감염, 패혈증 등)
                                </p>
                                <p class="flex items-start">
                                    <span>2.</span>암세포가 침범된 장기
                                </p>
                                <p class="flex items-start">
                                    <span>3.</span>그 외 이식대기자의 생명 및 신체에 위해를 가할 우려가 있는 경우
                                </p>
                                <p class="red flex items-start">
                                    <span>※</span> 중추신경계 종양, 두개강 외 종양은 종양의 종류, 범위, 단계, 발병시점, 수혜자 전이 위험성에 따라 장기기증 적합성이 판단됩니다.
                                </p>
                            </div>
                            <a href="" class="flex items-center justify-center redBtn">
                                <i>
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/i-vertical-white.png" alt="">
                                </i>절대금기사항
                            </a>
                        </div>
                    </div>
                    <div class="box box2">
                        <div class="circle-tit">
                            <h3 class="">
                                <span></span>조직기증 금기
                            </h3>
                            <p>아래 사항에. 해당하는 경우 조직기증을 할 수 없습니다.</p>
                        </div>
                        <div class="list flex flex-wrap">
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-1.png" alt="">
                                </div>
                                <div class="txt">사망원인 및 사망시간 미상</div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-2.png" alt="">
                                </div>
                                <div class="txt">무연고자 및 해외 국적자</div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-3.png" alt="">
                                </div>
                                <div class="txt">
                                    악성 종양, 암세포의 전이
                                    우려 질환
                                </div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-4.png" alt="">
                                </div>
                                <div class="txt">패혈증</div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-5.png" alt="">
                                </div>
                                <div class="txt">감염성 질환(성병, 에이즈, B형/C형 간염 등)</div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-6.png" alt="">
                                </div>
                                <div class="txt">
                                유해성 물질 노출 및 중독
                                (약물,중금속,살충제,고엽제 등)
                                </div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-7.png" alt="">
                                </div>
                                <div class="txt">
                                    자가면역질환, 성장 호르몬 투여, 항암치료, 면역억제제 투여
                                </div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-8.png" alt="">
                                </div>
                                <div class="txt">
                                    활동성 박테리아, 결핵, 한센병, 말라리아 , 단순포진, 대상포진
                                </div>
                            </div>
                            <div class="item flex items-center">
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/conformance2-9.png" alt="">
                                </div>
                                <div class="txt">
                                    퇴행성 신경질환 (알츠하이머, 파킨슨,치매, 크로이펠츠야콥 등)
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="popup-wrap conformance-popup" style="display:none">
        <div class="popup__bg"></div>
        <div class="popup">
            <a href="#//" class="closeBtn" onclick="$('.conformance-popup').hide();">
                <img src="${pageContext.request.contextPath}/resource/assets/images/close-x-white.png" alt="">
            </a>
            <div class="popup-cont">
                <div class="row row1">
                    <h2>기증의 금기사항 (2013년 장기이식관리 업무안내)</h2>
                    <h3>흉곽장기</h3>
                    <ul class="list-num">
                        <li>
                            <span>1.</span>전신감염 및 호흡기 감염이 있는 경우
                        </li>
                        <li>
                            <span>2.</span>다른 장기의 비가역적으로(추가) 현저한 기능저하(간, 신장, 심한 당뇨, 악성종양, 심한 말초혈관 질환자 등) 가 있는 경우</li>
                        <li>
                            <span>3.</span>심한 흉곽 유착이 있는 경우
                        </li>
                        <li>
                            <span>4.</span>심한 폐기능 저하가 있는 경우
                        </li>
                        <li>
                            <span>5.</span>폐동맥 고혈압이 심한 경우
                        </li>
                    </ul>
                </div>

                <div class="row">
                    <h3>의학적인 판단사항</h3>
                    <p class="info flex items-center">
                        <i>
                            <img src="${pageContext.request.contextPath}/resource/assets/images/red-mark.png" alt="">
                        </i>
                        아래에 열거된 기증자의 장기별 특이질환에 대한 기증가능 여부는 의학적 판단 하에 결정한다.
                    </p>
                    <div class="scrollbox2">
                        <div class="table table-orange">
                            <table title="기증금기사항 중 의학적인 판단이 필요한 경우">
                                <colgroup>
                                    <col class="col-17">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th>신장</th>
                                        <td>
                                            <ul class="list-dash">
                                                <li>신사구체염 (Glomerulonephritis)</li>
                                                <li>당뇨 (Diabetus Mellitus)</li>
                                                <li>신염/신장병 (Nephritis / Nephropathy)</li>
                                                <li>신경화증 (Hypertensive Nephrosclerosis)</li>
                                                <li>다낭성 신장 (Polycystic Kidney)</li>
                                                <li>전신성 홍반성 낭창 (Systemic Lupus Erythematosus)</li>
                                                <li>기타</li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>췌장</th>
                                        <td>
                                            <ul class="list-dash">
                                                <li>당뇨 (Diabetus Mellitus)</li>
                                                <li>만성 췌장염</li>
                                                <li>기타</li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>간장</th>
                                        <td>
                                            <ul class="list-dash">
                                                <li>비 콜레스테롤 경화증 (Non-Cholestatic Cirrhisis)</li>
                                                <li>콜레스테롤 간병증/간경화 (Cholestatic Liver Disease / Cirrhosis)</li>
                                                <li>담즙 폐쇠 (Biliary Atresia)</li>
                                                <li>급성 간성 괴사 (Acute Hepatic Necrosis)</li>
                                                <li>신진대사 질환 (Metabolic Disease)</li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>심장</th>
                                        <td>
                                            <ul class="list-dash">
                                                <li>부정맥 (Significant Ventricular arrhythemia)</li>
                                                <li>비정상 심초음파 소견 (Echocardiographic abnormality)<ul class="list-bullet" style="padding:10px 0;">
                                                        <li>가) 운동기능 감소증 (Significant global hypokinesis)</li>
                                                        <li>나) 판막비정상 (Significant valvular abnormality)</li>
                                                    </ul>
                                                </li>
                                                <li>동맥경을 통한 관상동맥 질환 또는 심근경색의 과거력 (Significant Coronary disease by arteriography or documented previous myocardial infarct)</li>
                                                <li>심좌상 (Significant cardiac contusion)</li>
                                                <li>심초음파상 좌심실 비대 (Significant left ventricular hypertrophy by echo)</li>
                                                <li>기타</li>
                                            </ul>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>폐</th>
                                        <td>
                                            <ul class="list-dash">
                                                <li>폐기종 (Emphysema)</li>
                                                <li>낭성 섬유증 (Cystic Fibrosis)</li>
                                                <li>자연적으로 발생한 폐 섬유증 (Idiopathic Pulmonary Fibrosis)</li>
                                                <li>원발성 폐 고혈압 (Primary Pulmonary Hypertension)</li>
                                                <li>유육종 (Sarcoidosis)</li>
                                                <li>아이젠멩거 증후군 (Eisenmenger syndrome)</li>
                                                <li>석면침착증 (Asbestosis)</li>
                                                <li>기관지 확장증 (Bronchiectasis)</li>
                                                <li>기타</li>
                                            </ul>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="form-actions justify-center">
                    <a href="#//" class="btn" onclick="$('.popup-wrap').hide();">닫기</a>
                </div>
            </div>
        </div>
</body>
</html>
