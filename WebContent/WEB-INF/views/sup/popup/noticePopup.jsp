<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script id="jscode">
    
        //부모창에서 선택한 공지사항 Object
        var parentObject = parent.selectNoticeObj;
        
        $(document.body).ready(function(){
            
            $('#title').text(parentObject.title);
            $('#creationDate').text(parentObject.creationDateDecodeStr);
            var contents = parentObject.contents;
            contents = contents.replace(/\n/g, '<br/><br/>');
            $('#contents').html(contents);
            
        });

    </script>
    
    <title>공지사항</title>
</head>

<body id="popUp">
<div class="pop_up"><!-- 팝업용 전체 컨테이너 클래스 -->

    <div class="table_box">
        <table class="table non_head">
            <caption>공지사항 상세내용 페이지입니다.</caption>
            <thead>
                <tr>
                    <th width="10%"></th>
                    <th width="50%"></th>
                    <th width="10%"></th>
                    <th width="20%"></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>제목</th>
                    <td id="title"></td>
                    <th>작성일자</th>
                    <td id="creationDate"></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td class="text_view left" colspan="3" id="contents"></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pop_foot">
        <a class="btn" onclick="closePopup();">닫기</a>
    </div>
</div>
</body>
</html>