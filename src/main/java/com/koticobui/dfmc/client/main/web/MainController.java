package com.koticobui.dfmc.client.main.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koticobui.dfmc.client.com.model.DateData;
import com.koticobui.dfmc.client.main.service.MainService;

@Controller
public class MainController {

	@Resource(name = "mainService")
	private MainService mainservice;		
	
	//메인 게시판
	@RequestMapping(value = "/main/mainBoardList.json")
	@ResponseBody
	public Map<String, Object> mainBoardList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//전체
		requestMap.put("limit", "1");
		List<Map<String, Object>> mainTotalList = mainservice.mainBoardList(requestMap);		
		//공지 채용 보도 홍보
		requestMap.put("limit", "5");
	    List<Map<String, Object>> mainBoardList = mainservice.mainBoardList(requestMap);   						
	    //설문
	    List<Map<String, Object>> mainSurveyList = mainservice.mainSurveyList(requestMap);
	    
	    resultMap.put("mainTotalList", mainTotalList);
	    resultMap.put("mainBoardList", mainBoardList);
	    resultMap.put("mainSurveyList", mainSurveyList);
	    
		return resultMap;
	}
	
	//이미지 view
 	@RequestMapping(value="/imageView.do")
    public void imageView(@RequestParam(value="imageName") String imageName, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        
 		Properties props = new Properties(); 
		InputStream fis = getClass().getClassLoader().getResourceAsStream("config/appConfig.properties");
		props.load(new java.io.BufferedInputStream(fis));
		String fileStorePath = props.getProperty("globals.fileStorePath");
		
 		
        //서버에 저장된 이미지 경로
 		//String path = request.getServletContext().getRealPath("/common/ckeditor/ckupload/");
 		String path = fileStorePath+"/";
 		
        String sDirPath = path+imageName;
    
        File imgFile = new File(sDirPath);
        
        //사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
        if(imgFile.isFile()){
            byte[] buf = new byte[1024];
            int readByte = 0;
            int length = 0;
            byte[] imgBuf = null;
            
            FileInputStream fileInputStream = null;
            ByteArrayOutputStream outputStream = null;
            ServletOutputStream out = null;
            
            try{
                fileInputStream = new FileInputStream(imgFile);
                outputStream = new ByteArrayOutputStream();
                out = response.getOutputStream();
                
                while((readByte = fileInputStream.read(buf)) != -1){
                    outputStream.write(buf, 0, readByte);
                }
                
                imgBuf = outputStream.toByteArray();
                length = imgBuf.length;
                out.write(imgBuf, 0, length);
                out.flush();
                
            }catch(IOException e){
                //logger.info(e);
            }finally {
            	outputStream.close();
                fileInputStream.close();
                out.close();
            }
        }
    } 	
 	//메인 기관일정 달력
	@RequestMapping(value = "/main/mainOrganDateList.json")
	@ResponseBody
	public Map<String, Object> mainOrganDateList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model, DateData dateData) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//달력
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		//검색 날짜 end

		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();
		
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new DateData(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(i==today_info.get("today")){
				//오늘날짜의 일정에서 기능이 추가되면 dao 수정하자 --- calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
				String StringDate = dateData.getYear()+"-"+(Integer.parseInt(dateData.getMonth())+1)+"-"+i;
		        Date fullDate = Date.valueOf(StringDate);
		        requestMap.put("fullDate", fullDate);
		        List<Map<String, Object>> scheduleList = mainservice.scheduleList(requestMap);
		        if(scheduleList.size() == 0){
		        	calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), null);
		        }else{
		        	calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), scheduleList);
		        }
			}else{				
				String StringDate = dateData.getYear()+"-"+(Integer.parseInt(dateData.getMonth())+1)+"-"+i;
		        Date fullDate = Date.valueOf(StringDate);
		        requestMap.put("fullDate", fullDate);
		        List<Map<String, Object>> scheduleList = mainservice.scheduleList(requestMap);
		        if(scheduleList.size() == 0){
		        	calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), null);
		        }else{
		        	calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), scheduleList);
		        }
				
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new DateData(null, null, null, null);
				dateList.add(calendarData);
			}
		}		
		
		//배열에 담음
		resultMap.put("dateList", dateList);		//날짜 데이터 배열
		resultMap.put("today_info", today_info);
		
		
		//data		
		//List<Map<String, Object>> mainTotalList = mainservice.mainBoardList(requestMap);				
	    
	    //resultMap.put("mainTotalList", mainTotalList);	    
	    
		return resultMap;
	}
}
