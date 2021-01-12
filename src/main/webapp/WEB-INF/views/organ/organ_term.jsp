<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">
$(document.body).ready(function(){

    
    $(document).on('click', '.sub__tabs a', function () {
        $('.sub__tabs a').removeClass("active");
        $("a[href='"+ $(this).attr("href") +"']").addClass("active");
        
        $(".content").hide();

        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();

  	  	$('.sub__tabs .select button').html($(this).html());
  	  	
        return false;
    })	

    
    $(document).on('click', '.sub__tabs .select .dropdown a' , function () {
  	  	$('.sub__tabs .select button').siblings('.dropdown').stop().slideToggle();
  	  	
        return false;
    })	
   
});

</script>
</head>
<body>
	<div class="wrap">
		<div class="sub__header">
			<h2>기증용어설명</h2>
			<p>기증 관련 용어를 정리해 놓은 곳입니다.</p>
		</div>

		<div class="sub__tabs">
			<a href="#tab1" class="active">권역 구분</a>
			<a href="#tab2">병원 구분</a>
			<a href="#tab3">기증자 구분</a> <a href="#tab4"
				style="width: 35%; flex: none;"> 장기·조직기증 활성화프로그램<br />
			</a> <a href="#tab5">기타</a>

			<div class="select">
				<button>권역 구분</button>
				<div class="dropdown">
					<a href="#tab1">권역 구분</a>
					<a href="#tab2">병원 구분</a>
					<a href="#tab3">기증자구분</a>
					<a href="#tab4">장기·조직기증 활성화프로그램</a>
					<a href="#tab5">기타</a>
				</div>
			</div>
		</div>

		<div class="content" id="tab1">
			<div class="mapcol">
				<div class="col">
					<img
						src="${pageContext.request.contextPath}/resource/assets/images/mapcol-map.png"
						alt="">
				</div>
				<div class="col">
					<ul>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/mapcol-col1.png"
							alt=""> 중부관리지부 (Central Region)</li>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/mapcol-col2.png"
							alt=""> 충정·호남관리지부 (South West Region)</li>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/mapcol-col3.png"
							alt=""> 영남관리지부 (South East Region)</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="content" id="tab2" style="display: none;">
			<!--  <div class="memorial__search-form mb-8">
                        <div class="select" style="margin:0;margin-right: 10px;">
                            <select name="" id="">
                                <option value="">전체</option>
                            </select>
                        </div>
                        <div class="input name mobile-mt-10">
                            <input type="text" placeholder="">
                        </div>
                        <button class="submit">검색하기</button>
                    </div>-->

			<div class="hptable-info">
				<table>
					<tbody>
						<tr>
							<th>뇌사판정대상자관리전문기관<br /> Hospital-based Organ Procurement
								Organization, HOPO
							</th>
							<td>뇌사판정대상자에 대하여 장기 등의 기증을 위해 뇌사판정, 적출, 이식에 관한 일련의 업무를 통합적으로
								수행하는 기관을 말함. 보건복지부령으로 정하는 시설, 장비 및 인력 등의 조건을모두 갖춘의료기관으로 우리나라에는
								36개 병원이 있다.</td>
						</tr>
						<tr>
							<th>뇌사판정의료기관</th>
							<td>장기 등 적출 및 이식을 위한 뇌사판정업무를 할 수 있도록 보건복지부로부터 위탁받은 의료기관</td>
						</tr>
						<tr>
							<th>뇌사관리업무 협약병원<br /> KODA 협약병원
							</th>
							<td>장기기증 활성화를 위해 뇌사추정자 발굴과 관리, 구득 등의 절차를 원만히 진행하기 위해
								한국장기조직기증원과 협약을 맺은 병원</td>
						</tr>
						<tr>
							<th>독립장기조직구득기관<br /> lndependent Organ Procurement
								Organization, I0PO
							</th>
							<td>뇌사추정자 파악과 관리, 뇌사판정 및 장기적출 절차의 진행 지원, 기증정보 전달 및 설득, 기증자에
								대한 지원 등의 업무를 수행하는 기관으로 국내에서는 한국장기조직기증원이 이에 해당됨.</td>
						</tr>
						<tr>
							<th>발생병원</th>
							<td>뇌사추정자가 발생한 병원</td>
						</tr>
						<tr>
							<th>신규발생병원</th>
							<td>기증자가 금년에 처음으로 발생한 병원</td>
						</tr>
						<tr>
							<th>KODA LAB</th>
							<td>한국장기조직기증원이 개설하여 운영하는 뇌사자 장기기증 및 이식을 위한수탁검사를 전문적으로 시행하는
								진단 검사의학 검사실</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="content" id="tab3" style="display: none;">

			<div class="hptable-info">
				<table>
					<tbody>
						<tr>
							<th>뇌사 <br />Brain death
								</div>
							</th>
							<td>뇌사판정 기준 및 절차에 따라 뇌 전체의 기능이 되살아 날 수 없는 상태로 정지되었다고 판정됨.</td>
						</tr>
						<tr>
							<th>뇌사추정자 <br />Potential brain death
								</div>
							</th>
							<td>아직 뇌사판정이 나지는 않았으나 뇌사로 추정되는자</td>
						</tr>
						<tr>
							<th>뇌사기증자 <br />Deceased donor
			</div>
			</th>
			<td>보호자가 기증에 동의하고 장기 등 이식에 관한 법률에 의거 뇌사판정 기준 및 절차에 따라 뇌사판정이 완료되어
				장기를 기증한자.</td>
			</tr>
			<tr>
				<th>생존 기증자 <br />Living donor
		</div>
		</th>
		<td>살아있는 동안 타인에게 이식해 줄 장기를 기증하는 사람으로 신장 편 측,간,폐,췌장의 일부가 가능하다.</td>
		</tr>
		<tr>
			<th>잠재적 조직기증자 <br />Potential tissue donor
	</div>
	</th>
	<td>사망이 임박하여 뼈, 인대, 건 등의 조직을 기증하기에 적합한 것으로 판단되고, 가족이 조직기증에 대한 정보제공
		및 상담을 요청하여 기증 가능성이 있는 자.</td>
	</tr>
	<tr>
		<th>조직기증자 <br />Tissue donor
			</div>
		</th>
		<td>다른 사람의 인제조직 기능회복을 위하여 대가없이 특정한 조직을 기증한자.</td>
	</tr>
	<tr>
		<th>Eligible donor</th>
		<td>의학적으로 기증에 적합한 뇌사주청자로 한국장기조직기증원에서는 가족 동의를 얻어 1차 뇌사조사를 마친 기증자로
			정의한다.</td>
	</tr>
	<tr>
		<th>pmp <br />per million population
			</div>
		</th>
		<td>뇌사장기기증자 수를 나타내는 단위로 인구 백만명당 뇌사장기기증자수를 말한다.</td>
	</tr>
	<tr>
		<th>Transplanted donor</th>
		<td>구득된 장기로 한 사람 이상에게 이식을 시행한 뇌사 장기기증자.</td>
	</tr>
	</tbody>
	</table>
	</div>
	</div>

	<div class="content" id="tab4" style="display: none;">

		<div class="hptable-info">
			<table>
				<tbody>
					<tr>
						<th>DIP</th>
						<td>뇌사추정자 발생병원과의 업무협약을통해 기증활성화를 위한 위원회 구성과 원내 프로토콜 정립, 의무기록
							분석을 통한 기증과정 분석(MRR), 의료진 인지 태도 조사(HAS) 등을 활용하여 분석하는 기증활성화 프로그램.</td>
					</tr>
					<tr>
						<th>DIP 협약</th>
						<td>기증활성화를 위해 병원과 한국장기조직기증원 간에 맺는 협약.</td>
					</tr>
					<tr>
						<th>DIP 위원회 <br />Donation Improvement Program Committee
							</div>
						</th>
						<td>기증활성화를 위한 프로토콜 수립과 원내 정잭을 결정하는 병원 내 위원회.</td>
					</tr>
					<tr>
						<th>사망자 의무기록 조사 <br />Medical Record Review, MRR
							</div>
						</th>
						<td>협약병원 내의 사업 대상 중환자실 사망자의 의무기록을 분석하여 해당병원의 뇌사추정자 발생정도, 의료진
							인지여부, 기증과정 중 중단 시점 및 이유 등을 분석하여 최적의 전략을 도출해내는 것.</td>
					</tr>
					<tr>
						<th>의료진 인지태도 조사 <br />Hospital Attitude Survey, HAS
							</div>
						</th>
						<td>DIP 협약병원 의료진의 기증에 관한 인지, 태도, 지식수준 등을 점검하는 기초조사.</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="content" id="tab5" style="display: none;">

		<div class="hptable-info">
			<table>
				<tbody>
					<tr>
						<th>기증자 가족관리 <br />Family support program
							</div>
						</th>
						<td>전문 사회복지사가 기증자 가족에게 기증 후 장례절차와 사후 행정 처리를 안내하고, 정서적 지지 등을
							통해 유가족의 회복을 돕는 서비스.</td>
					</tr>
					<tr>
						<th>기증자 이송</th>
						<td>발생병원에서 기증자 관리가 불가능할 경우 이를 적절히 수행할 수 있는 의료기관으로 이송, 기증이
							가능하도록 돕는 절차.</td>
					</tr>
					<tr>
						<th>뇌사추정자 신고제</th>
						<td>장기 등 이식에 관한 법률 제 17조에 의거, 뇌사추정자를 진료한 의료기관의 장이 장기구득기관에 이를
							통보하도록 하는 제도.</td>
					</tr>
					<tr>
						<th>뇌사판정위원회</th>
						<td>뇌사판정의료기관에서 뇌사여부를 판정하기 위해 전문의 2명 이상과 비의료인 1인 이상의 위원으로 구성된
							병원 내 위원회.</td>
					</tr>
					<tr>
						<th>장기·조직 코디네이터 <br />Organ &amp; Tissue Procurement
							Coordinator, OPC
							</div>
						</th>
						<td>장기 및 조직 구득과 관련하여 법정교육과 현장실습을 완료한 후, 현장에서 보호자 동의 및 일련의
							기증과정을 진행하는 의사 및 간호사.</td>
					</tr>
					<tr>
						<th>장기·조직 통합콜센터</th>
						<td>뇌사추정자 및 잠재적 조직기증자의 통보를 받기 위해 한국장기조직기증원에서
							운영하는콜센터(T.1577-1458).</td>
					</tr>
					<tr>
						<th>장기이식대기자</th>
						<td>다른 사람의 장기를 이식받기 위하여 장기이식등록기관에 등록된 자.</td>
					</tr>
					<tr>
						<th>조직기증 연계</th>
						<td>기증에 적합한 범주에 있고 가족의 동의가 된 뇌사추정자 또는 사망자를 의료관리자의 승인을 받아
							인채조직을 채취하는 조직은행으로 연계하는 것.</td>
					</tr>
					<tr>
						<th>장기조직 기증희망등록</th>
						<td>뇌사상태 또는 사망 이후에 장기 및 인체조직을 기증하겠다고 본인의 의사를 밝히는 행위. 실제 기증
							시에는 반드시 법적 보호자의 동의를 득해야하며, 이 때 기증희망등록 여부는 남겨진 가족이 기증을 결정할 때 중요한
							참고가 된다.</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
