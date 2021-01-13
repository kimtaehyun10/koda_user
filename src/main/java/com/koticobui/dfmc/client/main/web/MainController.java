package com.koticobui.dfmc.client.main.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
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
}
