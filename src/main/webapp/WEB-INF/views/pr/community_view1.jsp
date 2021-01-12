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
                                <p>자기의사결정 존중에 대해 어떻게 생각하시나요?</p>
                            </div>
                            <div class="radioBox">
                                <div class="item">
                                    <label for="area1" class="radio my-2 mr-6">
                                        <input type="radio" name="area" id="area1" hidden="">
                                        <span></span>
                                        <p>존중한다.</p>
                                    </label>
                                </div>
                                <div class="item">
                                    <label for="area2" class="radio my-2 mr-6">
                                        <input type="radio" name="area" id="area2" hidden="">
                                        <span></span>
                                        <p>모르겠다.</p>
                                    </label>
                                </div>
                                <div class="item">
                                    <label for="area3" class="radio my-2 mr-6">
                                        <input type="radio" name="area" id="area3" hidden="">
                                        <span></span>
                                        <p>존중하지 않는다.</p>
                                    </label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button class="btn submit">제출하기</button>
                                <a href="#//" class="btn">결과보기</a>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="form-actions justify-center">
                    <a href="" class="submit btn">목록보기</a>
                </div>
            </div>

    <div class="popup-wrap">
        <div class="popup__bg"></div>
        <div class="popup">
            <div class="popup__tit">
                이메일/비밀번호 입력
            </div>
            <div class="popup__form">
                <div class="row flex">
                    <div class="tit">이메일</div>
                    <div class="input">
                        <input type="text">
                    </div>
                </div>
                <div class="row flex">
                    <div class="tit">비밀번호</div>
                    <div class="input">
                        <input type="text">
                    </div>
                </div>
            </div>
            <div class="form-actions justify-center">
                <button class="btn submit">확인</button>
                <a href="#//" class="btn" onclick="$('.popup-wrap').hide();">닫기</a>
            </div>
        </div>
    </div>
	
</body>
</html>
