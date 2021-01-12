<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
	<div class="wrap">
		<div class="section">
			<h2 class="section__title">
				한 눈에 보는 기증통계 <span>2020.10.12 00시 기준</span>
			</h2>

			<div class="searchYear">
				<div class="select">
					<select name="" id="">
						<option value="2020">2020년</option>
					</select>
				</div>
				<button>확인</button>
			</div>
			<div class="barChart">
				<canvas id="barChart" width="" height=""></canvas>
			</div>

			<div class="mapTotalInfo">
				<div class="col">
					<div class="korea">
						<img
							src="${pageContext.request.contextPath}/resource/assets/images/korea-map.png"
							alt="">
						<div class="area area1">
							<div>
								<span>중부권역</span> <strong>243</strong>
							</div>
						</div>
						<div class="area area2">
							<div>
								<span>충청·호남권역</span> <strong>41</strong>
							</div>
						</div>
						<div class="area area3">
							<div>
								<span>영남권역</span> <strong>23</strong>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="pieChart">
						<canvas id="pieChart" width="" height=""></canvas>
						<div class="pieInfo">
							<div class="row">
								<h3>
									<strong>2020년 전체 누적 기증자</strong>
								</h3>
								<div>
									<strong style="color: #e64c3c">440</strong>명
								</div>
							</div>
							<div class="row">
								<h3>누적 장기 기증자</h3>
								<div>450</div>
							</div>
							<div class="row">
								<h3>누적 조직 기증자</h3>
								<div>130</div>
							</div>
						</div>
					</div>
					<div class="table">
						<div class="table__tab">
							<button class="active">장기기증건 추이표</button>
							<button>조직기증건 추이표</button>
						</div>
						<table>
							<colgroup>
								<col width="90">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th></th>
									<th>1월</th>
									<th>2월</th>
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>중부권역</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

								</tr>
								<tr>
									<td>충청호남권역</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

								</tr>
								<tr>
									<td>영남권역</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

									<td>21</td>

								</tr>
								<tr>
									<th>월별누적</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

									<th>21</th>

								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="sub__fullbox">
		<div class="wrap">
			<img
				src="${pageContext.request.contextPath}/resource/assets/images/sub1-img.png"
				alt="" class="fullbox-img">
			<div class="item">
				<span><img
					src="${pageContext.request.contextPath}/resource/assets/images/sub1-i1.png"
					alt=""></span>
				<p>장기기증</p>
			</div>
			<div class="item">
				<span><img
					src="${pageContext.request.contextPath}/resource/assets/images/sub1-i2.png"
					alt=""></span>
				<p>조직기증</p>
			</div>
			<div class="item">
				<span><img
					src="${pageContext.request.contextPath}/resource/assets/images/sub1-i3.png"
					alt=""></span>
				<p>기증희망등록</p>
			</div>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>

    <script>

      var ctx = document.getElementById('barChart').getContext('2d');
      var barChartData = {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        datasets: [{
          label: '영남권역',
          backgroundColor: '#f1a24e',
          stack: 'bar',
          data: [
            1,2,3,4,5,6,7,1,2,3,1,2
          ],
          order: 1
        }, {
          label: '충청·호남권역',
          backgroundColor: '#2e81b1',
          stack: 'bar',
          data: [
            1,2,3,4,5,6,7,1,2,3,1,2
          ],
          order: 1
        }, {
          label: '중부권역',
          backgroundColor: '#4aa179',
          stack: 'bar',
          data: [
            1,2,3,4,5,6,7,1,2,3,1,2
          ],
          order: 1
        }, {
          label: '전체',
          type: 'line',
          stack: 'line',
          backgroundColor: 'rgba(0, 0, 0, 0.0)',
          borderColor: 'rgba(0, 0, 0, 1)',
          pointBackgroundColor: 'rgba(0, 0, 0, 0)',
          pointBorderColor: 'rgba(0, 0, 0, 1)',
          borderWidth: '1',
          lineTension: 0,
          order: 5,
          data: [
            3,6,9,12,15,18,21,3,6,9,3,6
          ],
        }]
      };
      var myChart = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: {
          showAllTooltips: true,
        }
      });

      var pieChart = document.getElementById('pieChart').getContext('2d');
      var barChartData = {
        labels: ['영남권역', '충청호남권역', '중부권역'],
        datasets: [{
          label: '영남권역',
          backgroundColor: [
            '#f1a24e',
            '#2e81b1',
            '#4aa179',
          ],
          stack: 'bar',
          data: [
            1,2,3
          ],
          order: 1
        }]
      };
      var myPieChart = new Chart(pieChart, {
        type: 'pie',
        data: barChartData,
        options: {
          showAllTooltips: true,
        }
      });
    </script>

</body>
</html>
