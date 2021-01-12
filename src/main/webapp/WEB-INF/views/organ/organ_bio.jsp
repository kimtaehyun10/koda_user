<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
	<div class="wrap">
		<div class="section">
			<h2 class="section__title">조직기증</h2>
			<div class="section__list">
				<h3 style="color: #e64c3c;">인체조직기증은 죽어서도 생명을 선물할 수 있는 나눔의
					실천입니다.</h3>
				<p class="notdot">
					뇌사 또는 사망 후 피부, 뼈, 인대, 혈관 등의 인체조직을 기증하여 조직손상으로 기능적 장애가 있는 환자의 재건과
					치료에 쓰입니다. (만 14세~80세까지 기증 가능)<br /> <br /> 10대에서 많이 발생하는 골육종,
					심한화상으로 미소를 잃은 어린 아이들은 누군가에게 기증 받은 뼈와 피부로 건강한 삶을 살 수 있습니다.<br /> 운동을
					하다 십자인대를 다치거나 연골, 임플란트 수술 등 생활 곳곳에서 치료와 재건을위해 인체조직이 쓰여집니다.<br /> <br />
					일상 속 선물 같은 조직기증,<br /> 내가 그 수혜자가 될 수 있습니다.<br /> 기증은 먼 곳에 있지 않습니다.
				</p>
			</div>
		</div>

		<div class="info-section sec5-mt">
			<h3 class="info-section__title">
				뇌사 또는 사망 시<span style="font-weight: 400;">(사망 후 24시간 이내)</span> 기증
				가능한 조직
			</h3>
			<p class="info-section__description">조직기증은 기증적합성 판정을 위한 추가적인 혈액검사
				및 신체 사정 확인 후, 기증 여부가 결정됩니다.</p>


			<div class="kidneytable">

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-13.png"
							alt="">
					</div>
					<div class="info">
						<h3>뼈와 연골</h3>
						<p>(골육종 등 뼈 손상시)</p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-14.png"
							alt="">
					</div>
					<div class="info">
						<h3>심장판막·심낭</h3>
						<p>(심장판막 질환 판막이식 수술시)</p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-15.png"
							alt="">
					</div>
					<div class="info">
						<h3>인대 및 건</h3>
						<p>(파열 인대 복원, 퇴행성 질환, 재해·사고·감염 등 인대 및 건 결손시)</p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-16.png"
							alt="">
					</div>
					<div class="info">
						<h3>피부</h3>
						<p>(화상 등 피부 결손시)</p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-17.png"
							alt="">
					</div>
					<div class="info">
						<h3>혈관</h3>
						<p>(혈관막힘, 관상동맥 우회술, 간·신장이식 등 수술시)</p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-18.png"
							alt="">
					</div>
					<div class="info">
						<h3>신경</h3>
						<p></p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-19.png"
							alt="">
					</div>
					<div class="info">
						<h3>근막</h3>
						<p></p>
					</div>
				</div>

				<div class="item">
					<div class="img">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/kidney-120.png"
							alt="">
					</div>
					<div class="info">
						<h3>양막</h3>
						<p>(생존시)</p>
					</div>
				</div>

			</div>
		</div>
	</div>

	<div class="sub__fullbox">
		<div class="sub__fullbox-tit">
			<h2>
				장기기증, <strong>한 사람의 삶이 다른 사람의 생명으로 이어지는 <span>희망</span></strong>입니다.
			</h2>
		</div>
		<div class="wrap">

			<img
				src="${pageContext.request.contextPath}/resource/assets/images/sub1-img.png"
				alt="" class="fullbox-img">
			<div class="item" onclick="javascript:fn_MoveUrl('1','2','4')" style="cursor:pointer">
				<span><img
					src="${pageContext.request.contextPath}/resource/assets/images/sub1-i2.png"
					alt=""></span>
				<p>조직기증</p>
			</div>
			<div class="item" onclick="javascript:fn_MoveUrl('4','1','0')" style="cursor:pointer">
				<span><img
					src="${pageContext.request.contextPath}/resource/assets/images/sub1-i3.png"
					alt=""></span>
				<p>기증희망등록</p>
			</div>
		</div>
	</div>

</body>
</html>
