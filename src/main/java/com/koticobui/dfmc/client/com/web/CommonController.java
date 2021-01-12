/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.koticobui.dfmc.client.com.web;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koticobui.dfmc.client.com.service.CommonService;
import com.koticobui.dfmc.client.com.util.SessionService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;

/**
 * The type Common controller.
 */
@Controller
public class CommonController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "commonService")
    private CommonService commonService;

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    @Resource(name = "sessionService")
    private SessionService service;
    
    @Value("#{appConfig['edit.file.upload.path']}")
    private String editfilepath;

	@RequestMapping(value = "/com/selectSession.json")
	@ResponseBody
	public Map<String, Object> selectSession(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

//		SessionService service = new SessionService();
		@SuppressWarnings("unchecked")
		Map<String, Object> result = service.selectSession(requestMap.get("session").toString());
		
		return result;
	}
	
	
	@RequestMapping(value = "/com/searchHospitalCombo.json")
	@ResponseBody
	//koda사용
	public Map<String, Object> searchHospitalCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> result = commonService.searchHospitalCombo();
		
		return result;
	}
	
	@RequestMapping(value = "/com/searchCommonCode.json")
	@ResponseBody
	//koda사용
	public Map<String, Object> searchCommonCode(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

		Map<String, Object> result = commonService.searchCommonCode(requestMap);
		
		return result;
	}
	
	// ckeditor 파일업로드	
	@RequestMapping(value="/com/ckeditorUpload.do", method = RequestMethod.POST)
	 public void imageUpload(HttpServletRequest request,
	         HttpServletResponse response, MultipartHttpServletRequest multiFile
	         , @RequestParam MultipartFile upload) throws Exception{
	     // 랜덤 문자 생성
	     UUID uid = UUID.randomUUID();
	     
	     OutputStream out = null;
	     PrintWriter printWriter = null;
	     
	     //인코딩
	     response.setCharacterEncoding("utf-8");
	     response.setContentType("text/html;charset=utf-8");
	     
	     try{
	         
	         //파일 이름 가져오기
	         String fileName = upload.getOriginalFilename();
	         byte[] bytes = upload.getBytes();	         	         	         
	         
	         //이미지 경로 생성
	         //String path = request.getServletContext().getRealPath("/common/ckeditor/ckupload/"); // fileDir는 전역 변수라 그냥 이미지 경로 설정해주면 된다.
	         String path = editfilepath;
	         
	         String ckUploadPath = path + uid + "_" + fileName;
	         File folder = new File(path);
	         
	         //해당 디렉토리 확인
	         if(!folder.exists()){
	             try{
	                 folder.mkdirs(); // 폴더 생성
	             }catch(Exception e){
	                 e.getStackTrace();
	             }
	         }
	         
	         out = new FileOutputStream(new File(ckUploadPath));
	         out.write(bytes);
	         out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
	         
	         String callback = request.getParameter("CKEditorFuncNum");
	         printWriter = response.getWriter();
	         String fileUrl = "/com/ckImgSubmit.do?uid=" + uid + "&fileName=" + fileName;  // 작성화면
	         
	     // 업로드시 메시지 출력
	       printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
	       printWriter.flush();
	         
	     }catch(IOException e){
	         e.printStackTrace();
	     } finally {
	       try {
	        if(out != null) { out.close(); }
	        if(printWriter != null) { printWriter.close(); }
	       } catch(IOException e) { e.printStackTrace(); }
	      }
	     
	     return;
	 } 
	
     // ckeditor 파일 본문 적용
     @RequestMapping(value="/com/ckImgSubmit.do")
	 public void ckSubmit(@RequestParam(value="uid") String uid
	                         , @RequestParam(value="fileName") String fileName
	                         , HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
	     
	     //서버에 저장된 이미지 경로
		//String path = request.getServletContext().getRealPath("/common/ckeditor/ckupload/");
		String path = editfilepath;
	
	     String sDirPath = path + uid + "_" + fileName;
	 
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
	
	////////////////////////////////////////////////////////////
    /**
	 * Code master map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mis/tax/codeMaster.json")
	@ResponseBody
	public Map<String, Object> codeMaster(@RequestParam Map<String, Object> requestMap) throws Exception {
		Map<String, Object> list = commonService.selectCodeMaster(requestMap);
		return list;
	}
	
    /**
	 * Search discount item list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchDiscountItemList.json")
	@ResponseBody
	public Map<String, Object> searchDiscountItemList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
	 	Map<String, Object> list = commonService.searchDiscountItemList(requestMap);
	 	return list;
	}
	
	/**
	 * Search use discount item list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchUseDiscountItemList.json")
	@ResponseBody
	public Map<String, Object> searchUseDiscountItemList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		requestMap.put("esntlId", esntlId);
				
	 	Map<String, Object> list = commonService.searchUseDiscountItemList(requestMap);
	 	return list;
	}
    
	/**
	 * Search res section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchResSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResSectionCombo(requestMap);
		
		return list;
	}
	
	/**
	 * Search res block combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResBlockCombo.json")
	@ResponseBody
	public Map<String, Object> searchResBlockCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResBlockCombo(requestMap);
		return list;
	}
	
	/**
	 * Search res division combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResDivisionCombo.json")
	@ResponseBody
	public Map<String, Object> searchResDivisionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResDivisionCombo(requestMap);
		return list;
	}
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/selectCarList.json")
	@ResponseBody
	public Map<String, Object> selectCarList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = commonService.selectCarList(requestMap);
		
		
		return list;
	}
	
	/**
	 * Search vst manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstManageZoneCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstManageZoneCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstManageZoneCombo(requestMap);
		return list;
	}
	
	/**
	 * 환불 사유
	 * @param requestMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/searchRefundCodeCombo.json")
	@ResponseBody
	public Map<String, Object> searchRefundCodeCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchRefundCodeCombo(requestMap);
		return list;
	}

	/**
	 * 은행 목록
	 * @param requestMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/searchBankCodeCombo.json")
	@ResponseBody
	public Map<String, Object> searchBankCodeCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchBankCodeCombo(requestMap);
		return list;
	}

	/**
	 * Search vst section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstSectionCombo(requestMap);
		return list;
	}
	
	/**
	 * Search vst block combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstBlockCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstBlockCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstBlockCombo(requestMap);
		return list;
	}
	
	/**
	 * Search vst division combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstDivisionCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstDivisionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstDivisionCombo(requestMap);
		return list;
	}
	
	/**
	 * Search pub manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchPubManageZoneCombo.json")
	@ResponseBody
	public Map<String, Object> searchPubManageZoneCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchPubManageZoneCombo(requestMap);
		return list;
	}
	
	/**
	 * Search pub section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchPubSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchPubSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchPubSectionCombo(requestMap);
		return list;
	}
    
	/**
	 * Select park map list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchParkMap.json")
	@ResponseBody
	public Map<String, Object> searchParkMap(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Map<String, Object> list = commonService.searchParkMap(requestMap);
		return list;
	}
	
}
