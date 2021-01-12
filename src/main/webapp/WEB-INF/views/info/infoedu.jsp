<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">
	function openPop(flg){
		var url = ""
		if (flg == "1"){
			url = "/resource/publicity/edu/01/01_01.htm";
		}else{
			url = "/resource/publicity/edu/02/02_01.htm";
		}
		
		window.open(url, '', 'width=1000, height=682, scrollbars=no, resizable=no');
		
	}
</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>교육자료</h2>
                </div>
                <div class="info__content educate-data flex">
                    <div class="item flex-1 mr-8 item1">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/educate-1.png" alt="">
                        </div>
                        <div class="txtBox text-center">
                            <div class="tit">의료진용 교육자료</div>
                            <div class="txt">
                                본 과정을 통해 장기기증의 필요성을 인식하고,<br/>
                                뇌사에 대해 정확하게 이해할 수 있으며,<br/>
                                뇌사 추정자 신고제와 Donation Improvement Program을<br/>
                                올바로 알 수 있게 될 것입니다.
                            </div>
                        </div>
                        <a href="javascript:openPop('1');" class="links flex">
                            <i></i>동영상보기
                        </a>
                    </div>
                    <div class="item flex-1 item2">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/educate-2.png" alt="">
                        </div>
                        <div class="txtBox text-center">
                            <div class="tit">일반인용 교육자료</div>
                            <div class="txt">
                                본 과정을 통해 장기기증을 올바로 알 수 있으며,<br/>
                                뇌사에 대한 정확한 정보와 장기기증 절차 및<br/>
                                기증자와 기증자 가족관리에 대해 알 수 있습니다.
                            </div>
                        </div>
                        <a href="javascript:openPop('2');" class="links flex">
                            <i></i>동영상보기
                        </a>
                    </div>
                </div>
                <p class="ie mt-8">※ 해당 동영상은 IE 8~10 브라우저에 최적화 되어있습니다.</p>
            </div>
</body>
</html>
