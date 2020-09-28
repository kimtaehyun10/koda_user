<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>
    
    <script id="jscode">
        
        //부모창에서 선택한 구간정보 Object
        var parentObject = parent.selectSectionObj;
        
        var parkSectionKey = parentObject.parkSectionKey;
        
        //대기자 그리드
        /*var fnObj = {
            pageStart: function(){
                fnObj.grid.bind();
            },  
            grid: { 
                target : new AXGrid() ,
                bind: function(){
                    window.myGrid = fnObj.grid.target;
                    myGrid.setConfig({
                        targetID: "grid1",
                        sort        : true, //정렬을 원하지 않을 경우 (tip
                        colHeadTool : false, // column tool use
                        fitToWidth  : true, // 너비에 자동 맞춤  
                        colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
                        colGroup: [
                            {key:"carNumber", label:"차량번호", width:100, align:"center", formatter:function(){
                            	
                            	if(this.item.carNumberLength > 4){
                            		var star = '';
                            		var carNumber = '';
                          			for(var i=0; i<this.item.carNumberLength-4; i++) {
                          				star = star+'*';
                          			}
                          			
                          			carNumber = this.item.carNumberFirst + star + this.item.carNumberLast;
                            	}else{
                            		carNumber = this.item.carNumberFirst + this.item.carNumberLast;
                            	}
                                return carNumber;
                            }},
                            {key:"mberNm", label:"신청자명", width:100, align:"center", formatter:function(){
                                
                                if(this.item.mberNmLength > 2){
                                    var star = '';
                                    var mberNm = '';
                                    for(var j=0; j<this.item.mberNmLength-2; j++) {
                                        star = star+'*';
                                    }
                                    
                                    mberNm = this.item.mberNmFirst + star + this.item.mberNmLast;
                                }else{
                                	mberNm = this.item.mberNmFirst + this.item.mberNmLast;
                                }
                                return mberNm;
                            }},
                            {key:"requestDateStr", label:"신청일", width:100, align:"center"}
                        ]
                        ,
                        colHead    : {
                            onclick: function() { 
                                myGrid.click(0); 
                            }
                        }, 
                        body : {
                            onclick: function(){
                                //if( this.c != 2 && this.c != 4){ 
                                //    selectRow(this.item);
                                //}
                            } 
                        },
                        page:{
                            paging:true,
                            //pageSize:10
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/pub/selectStandbyList.json",
                        ajaxPars: {parkSectionKey : parkSectionKey},
                        onLoad:function(){
                            //fnObj.clickRow(0);
                        }  
                    });
                }  
            },
            clickRow : function(seq){
                myGrid.click(seq);
            },
            reloadList: function(){
                myGrid.reloadList();
            }
        }
        
        $(document.body).ready(function(){
            
        	fnObj.pageStart(); 
            
        });
        */
      
        
        $(document.body).ready(
        		//대기자 총 수 조회
                function searchStandByMax(){ 
                
                    $.ajax({
                        url : getContextPath() + "/selectStandbyMax.json", 
                        type: "POST", 
                        data: {parkSectionKey : parkSectionKey},
                        dataType:"json", 
                        success : function(data, textStatus, jqXHR) {
        						var mrnum = "";
        						var rnum = "";
        						var htmltxt1 = "";
        						var htmltxt2 = "";
        						var htmltot = "";
        						
        						mrnum =  data.mrnum.mrnum;
        						htmltxt2 = "총대기자수";
                            	
        						$.ajax({
        			                url : getContextPath() + "/selectStandbyMe.json", 
        			                type: "POST", 
        			                data: {parkSectionKey : parkSectionKey},
        			                dataType:"json", 
        			                success : function(data, textStatus, jqXHR) {     
        								
        								if (data.list.length > 0){
        									var rnum = data.list[0].rnum;
        									var htmltxt1 = "내대기순위";
        									
        									htmltot = htmltot + "<h2><span style='color:blue;'>" + htmltxt1 + "</span> / " + htmltxt2 + "<h2>";
        									htmltot = htmltot + "<br>";
        									htmltot = htmltot + "<h2><span style='color:blue;'>" + rnum + "</span> / " + mrnum + "<h2>";
        								}else{
        									htmltot = htmltot + "<h1 style='line-height:70px;'>" + htmltxt2 + " : " + mrnum + " <h1>";
        								}        								
        								
                                        $("#targetArea").html(htmltot);
        								
        			                },
        			                error : function(jqXHR, textStatus, errorThrown){
        			                    //Error시, 처리
        			                }
        						});

                        }, 
                        error : function(jqXHR, textStatus, errorThrown){
                            //Error시, 처리
                        }
                    });
                }	
        );
        		
        
    </script>
    
    <title>주차장 대기정보</title>
</head>

<body id="popUp">
<div class="pop_up">
    <div class="table_box">
        <span style="text-align:center" id=targetArea></span>
    </div>
    <div class="pop_foot">
        <a class="btn" onclick="closePopup();">닫기</a>
    </div>
</div>
</body>
</html>