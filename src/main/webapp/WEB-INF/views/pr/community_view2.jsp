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
                    <h2>소통게시판</h2>
                </div>
                <div class="memorial__detail-content">
                    <header>
                        <h3 class="title">
                            자기의사결정 존중에 대해 어떻게 생각하시나요?
                        </h3>
                        <div class="info">
                            <div class="col">
                                등록일 <strong>2020-10-19</strong>
                            </div>
                            <div class="col">
                                응답기간 <strong>2020.01.09 - 2020.01.09</strong>
                            </div>
                            <div class="col">
                                조회 <strong>104</strong>
                            </div>
                        </div>
                    </header>

                    <div class="memorial__detail-body border-type">

                        <!-- content 입력 -->
                        <div class="content surveyBox" style="">
                            <div class="title">
                                <p class="flex items-baseline">
                                    <span>3명</span>응답
                                </p>
                                <p>자기의사결정 존중에 대해 어떻게 생각하시나요?</p>
                            </div>
                            <div class="surveyResult">
                                <div class="graph" style="max-width: 500px;">
                                    <canvas id="pieChart" width="400" height=""></canvas>
                                </div>
                                <div class="table">
                                    <table>
                                        <colgroup>
                                            <col>
                                            <col width="100px">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th class="i">응답</th>
                                            <th class="">응답수</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td class="i">존중한다</td>
                                            <td>1</td>
                                        </tr>
                                        <tr>
                                            <td class="i">모르겠다</td>
                                            <td>1</td>
                                        </tr>
                                        <tr>
                                            <td class="i">존중하지 않는다.</td>
                                            <td>1</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-actions justify-center">
                    <a href="" class="submit btn">목록보기</a>
                </div>
            </div>
            
            <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
    <script>
      var pieChart = document.getElementById('pieChart').getContext('2d');
      var barChartData = {
        labels: ['존중한다.', '모르겠다.', '존중하지 않는다.'],
        datasets: [{
          backgroundColor: [
            '#F55C81',
            '#38A4E4',
            '#FAC823',
          ],
          data: [
            1,1,1
          ],
        }]
      };
      var myPieChart = new Chart(pieChart, {
        type: 'pie',
        data: barChartData,
        options: {
          showAllTooltips: true,
          responsive: true,
          legend: {
            position: 'right'
          }
        }
      });
    </script>
	
</body>
</html>
