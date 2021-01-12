<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<script type="text/javascript">		
		function goDown(f,d){
			location.href = "/include/fix_file_download.jsp?file="+encodeURI(encodeURIComponent(f))+"&path="+d;
		}
	</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>사업실명제</h2>
                    <div class="top-txtBox flex items-center type2 border-orange pt-4">
                        <div class="img" style="margin-right: 0;">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/info-top-img3.png" alt="" style="margin: 0 auto;">
                        </div>
                        <div class="txt">
                            <h3 class="flex items-center">
                                <span>투명한 기관 운영 정보를 공유합니다.</span>
                            </h3>
                            <p>
                                사업실명제란 사업의 지속성 및 책임성을 확보하기 위하여 대상사업 선정기준에 따라 국민에게 사업을 공개하는 제도입니다.
                            </p>
                            <p class="red">※ 사업에 대한 자세한 사항은 담당부서로 문의하시기 바랍니다.</p>
                        </div>
                    </div>
                </div>
                <div class="info__content">
                    <div class="box mb-8">
                        <div class="subTit">
                            <h3 class="mb-4">대상사업 선정기준</h3>
                        </div>
                        <div class="boxflex flex">
                            <div class="col flex-1 mr-4">
                                <h4 class="mb-2 color-orange">01</h4>
                                <p class="font-medium">
                                    주요 국정 현안에 관한 사항
                                </p>
                            </div>
                            <div class="col flex-1  mr-4">
                                <h4 class="mb-2 color-orange">02</h4>
                                <p class="font-medium">
                                    소요예산 2억원 이상의 사업
                                </p>
                            </div>
                            <div class="col flex-1  mr-4">
                                <h4 class="mb-2 color-orange">03</h4>
                                <p class="font-medium">
                                    국민생활에 미치는 영향이 큰 주요 서비스 제공 사업
                                </p>
                            </div>
                            <div class="col flex-1 ">
                                <h4 class="mb-2 color-orange">04</h4>
                                <p class="font-medium">
                                    그 밖에 중점관리가 필요한 기관의 핵심사업으로 필요하다고 인정하는 사업
                                </p>
                            </div>
                        </div>

                    </div>
                    <div class="scrollbox2">
                        <div class="table type-gray infoTable borderNone">
                            <table>
                                <colgroup>
                                    <col width="200px">
                                    <col>
                                    <col width="250px">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>사업실명제 등록번호</th>
                                        <th>사업명</th>
                                        <th>다운로드</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
				                    	<td>-</td>
				                        <td class="text-left">사업실명제 대상사업 선정현황</td>
				                        <td><a href="/include/fix_file_download.jsp?file=2019_list.hwp&path=/upFile/business/2019_list.hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-01</td>
				                        <td class="text-left">뇌사장기 및 조직 기증 활성화 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-01).hwp&path=/upFile/business/(2018-01).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-02</td>
				                        <td class="text-left">뇌사관리 업무협약병원 확충사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-02).hwp&path=/upFile/business/(2018-02).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-03</td>
				                        <td class="text-left">뇌사추정자 및 조직기증자 발굴을 위한 병원홍보사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-03).hwp&path=/upFile/business/(2018-03).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-04</td>
				                        <td class="text-left">의료진 대상 전문교육사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-04).hwp&path=/upFile/business/(2018-04).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-05</td>
				                        <td class="text-left">기증과정 중 가족지원 서비스 제공 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-05).hwp&path=/upFile/business/(2018-05).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-06</td>
				                        <td class="text-left">기증자 예우 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-06).hwp&path=/upFile/business/(2018-06).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-07</td>
				                        <td class="text-left">장기·조직기증 활성화 프로그램</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-07).hwp&path=/upFile/business/(2018-07).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-08</td>
				                        <td class="text-left">검사실 운영 - 뇌사자 이식검사</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-08).hwp&path=/upFile/business/(2018-08).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-09</td>
				                        <td class="text-left">정기간행물 발간사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-09).hwp&path=/upFile/business/(2018-09).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-10</td>
				                        <td class="text-left">기증활성화를 위한 전문가 집단 학술 지원 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-10).hwp&path=/upFile/business/(2018-10).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-11</td>
				                        <td class="text-left">장기조직통보센터 운영</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-11).hwp&path=/upFile/business/(2018-11).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-12</td>
				                        <td class="text-left">잠재기증자 정보 등록 및 관리사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-12).hwp&path=/upFile/business/(2018-12).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-13</td>
				                        <td class="text-left">검사실 운영 - 기타 이식검사</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-13).hwp&path=/upFile/business/(2018-13).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-14</td>
				                        <td class="text-left">대국민 기증활성화 홍보 및 교육사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-14).hwp&path=/upFile/business/(2018-14).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2018-15</td>
				                        <td class="text-left">기증종사자 정신건강관리 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2018-15).hwp&path=/upFile/business/(2018-15).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2019-01</td>
				                        <td class="text-left">기증 후 가족지원 서비스 제공 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2019-01).hwp&path=/upFile/business/(2019-01).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2019-02</td>
				                        <td class="text-left">기증자 이송 지원 사업</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2019-02).hwp&path=/upFile/business/(2019-02).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>2019-03</td>
				                        <td class="text-left">개인정보보호 솔루션 도입</td>
				                        <td><a href="/include/fix_file_download.jsp?file=(2019-03).hwp&path=/upFile/business/(2019-03).hwp" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>구.2016-13</td>
				                        <td class="text-left gray">[사업완료] 생명나눔 교육</td>
				                        <td><a onClick="goDown('(구.2016-13).hwp','/upFile/business/(%EA%B5%AC.2016-13).hwp');" href="javascript:void(0)" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>구.2016-14</td>
				                        <td class="text-left gray">[사업완료] 생명의 소리 합창단 운영</td>
				                        <td><a onClick="goDown('(구.2016-14).hwp','/upFile/business/(%EA%B5%AC.2016-14).hwp');" href="javascript:void(0)" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
				                    <tr>
				                    	<td>구.2016-15</td>
				                        <td class="text-left gray">[사업완료] 생존시 기증 분야 연구 용역</td>
				                        <td><a onClick="goDown('(구.2016-15).hwp','/upFile/business/(%EA%B5%AC.2016-15).hwp');" href="javascript:void(0)" class="download flex flex-1 justify-center items-center"><i></i>한글파일 다운로드</a></td>
				                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
</body>
</html>
