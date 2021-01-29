<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">

</script>
</head>
<body>

	
            <div class="wrap relative">
                <div class="sub__header">
                    <h2>소통게시판</h2>
                    <p>
                        악의적인 비방, 비속어, 욕설 등 사이트 운영 목적에 부합하지 않는 글은 관리자에 의해 삭제 될 수 있습니다.
                    </p>
                </div>
                <div class="memorial__search-form mb-8">
                    <div class="select" style="margin:0;margin-right: 10px;">
                        <select name="" id="">
                            <option value="">전체분류</option>
                            <option value="">공지사항</option>
                            <option value="">채용</option>
                            <option value="">입찰</option>
                            <option value="">홍보</option>
                        </select>
                    </div>
                    <div class="select" style="margin:0;margin-right: 10px;">
                        <select name="" id="">
                            <option value="">전체</option>
                        </select>
                    </div>
                    <div class="input name mobile-mt-10">
                        <input type="text"placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();">
                    </div>
                	<div class="submit fobx2">
                    <button class="submit" >검색하기</button>
                    </div>
                </div>
                <div class="memorial__detail-content">
                    <div class="table promote__table effectNone write">
                        <table>
                            <colgroup>
                                <col class="col1">
                                <col width="">
                                <col class="col3">
                                <col class="col3">
                                <col class="col4">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>등록일</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="top">
                                    <td class="">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/survey.png" alt="" class="inline-block">
                                    </td>
                                    <td>
                                        <a href="javascript:fn_MoveUrl('5','6','1')" class="">자기의사결정 존중에 대해 어떻게 생각하시나요?</a>
                                    </td>
                                    <td>KODA</td>
                                    <td>2020-10-06</td>
                                    <td>24</td>
                                </tr>
                                <tr class="">
                                    <td class="">
                                        252
                                    </td>
                                    <td class="title">
                                        <a href="javascript:fn_MoveUrl('5','6','2')" class="secret">
                                            자기의사결정 존중에 대해 어떻게 생각하시나요?
                                        </a>
                                        <span>1</span>
                                    </td>
                                    <td>홍길동</td>
                                    <td>2020-10-06</td>
                                    <td>24</td>
                                </tr>
                                <tr class="">
                                    <td class="">
                                        252
                                    </td>
                                    <td class="title">
                                        <a href="" class="">
                                            자기의사결정 존중에 대해 어떻게 생각하시나요?
                                        </a>
                                        <span>1</span>
                                    </td>
                                    <td>홍길동</td>
                                    <td>2020-10-06</td>
                                    <td>24</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="pagination">
    <a href="" class="pagination__arrow prev-full"></a>
    <a href="" class="pagination__arrow prev"></a>
    <div class="pagination__number">
        <a href="" class="active">1</a>
        <a href="">2</a>
        <a href="">3</a>
        <a href="">4</a>
        <a href="">5</a>
    </div>
    <a href="" class="pagination__arrow next"></a>
    <a href="" class="pagination__arrow next-full"></a>
</div>

                <div class="action-button">
                    <a href="">글쓰기</a>
                </div>
            </div>

    <div class="popup-wrap">
        <div class="popup__bg"></div>
        <div class="popup">
            <div class="popup__tit">
                비밀번호 입력
            </div>
            <div class="popup__form">
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
