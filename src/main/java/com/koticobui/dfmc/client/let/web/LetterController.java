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
package com.koticobui.dfmc.client.let.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koticobui.dfmc.client.let.model.LetterVO;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.mem.service.MemberService;

/**
 * The type Letter controller.
 */
@Controller
public class LetterController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "letterService")
    private LetterService letterService;

    @Resource(name = "memberService")
    private MemberService memberService;

    @Value("#{appConfig['file.upload.path']}")
    private String filepath;
    
  	//회원탈퇴
  	@RequestMapping(value = "/let/extMyInfo.l")
  	public String extMyInfo(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/extMyInfo";
  	}

  	//내정보수정_화면
  	@RequestMapping(value = "/let/memModify.l")
  	public String memModify(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memModify";
  	}
  	
  	
    //메일 메인화면
	@RequestMapping(value = "/let/letterMain.l")
	public String letterMain(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		return "let/letterMain";
	}

    //편지쓰기
	@RequestMapping(value = "/let/letterWrite.l")
	public String letterWrite(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		return "let/letterWrite";
	}
	
	//내정보조회_비밀번호입력 화면
	@RequestMapping(value = "/let/secMyInfo.l")
	public String secMyInfo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		       
		return "let/mem/secMyInfo";
	}
	
	//내정보조회
	@RequestMapping(value = "/let/searchMember.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchMember( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {

		Map<String, Object> result = memberService.searchMember(requestMap);
		
	    return result;
	}
	
	//koda사용
    @RequestMapping(value = "/let/extMember.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> extMember(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        try {
        	memberService.extMember(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    //koda사용
    @RequestMapping(value = "/let/updateMember.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> updateMember(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        try {
        	memberService.updateMember(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
    
    //편지보기
	@RequestMapping(value = "/let/letterView.l")
	public String letterView(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		return "let/letterView";
	}
	
	
	//편지함별 총계 조회
	@RequestMapping(value = "/let/searchLetterListTot.json", method = RequestMethod.POST)
    @ResponseBody
	public Map<String, Object> searchLetterListTot( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {

    	Map<String, Object> result = letterService.searchLetterListTot(requestMap);
    	
        return result;
	}
	
	//편지함 리스트
	@RequestMapping(value = "/let/searchLetterList.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchLetterList( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {

		Map<String, Object> result = letterService.searchLetterList(requestMap);
		
	    return result;
	}

	
	//매칭대상 검색
	@RequestMapping(value = "/let/searchReceiverByMath.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchReceiverByMath( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {

		Map<String, Object> result = letterService.searchReceiverByMath(requestMap);
		
	    return result;
	}

	//편지발송
	@RequestMapping(value = "/let/sendLetter.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendLetter( @RequestParam Map<String, Object> requestMap, MultipartHttpServletRequest request) throws Exception {
        Map result = new HashMap();
        
		try {
			letterService.sendLetter(requestMap, request);
            result.put("result", "OK");
		}catch (Exception e){
            logger.error(e.getMessage());
            result.put("result", "FAIL");
            result.put("Message", e.getMessage());
		}
		
	    return result;
	}
	
	
	//편지보기
	@RequestMapping(value = "/let/searchLetterView.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchLetterView( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {

		Map<String, Object> result = letterService.searchLetterView(requestMap);
		
	    return result;
	}
	
	//편지 파일 다운로드
	@RequestMapping(value = "/let/downFile.l")
	@ResponseBody
	public void downFile( @RequestParam Map<String, Object> requestMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
			String letterFileNm = "";
			String letterFileOrgNm = "";
			
			Map<String, Object> fileInfo = letterService.searchLetterFile(requestMap);

			if (fileInfo == null) {
				throw new Exception("파일이 존재하지 않습니다.");
			}
			
			letterFileNm = (String)fileInfo.get("letterFileNm");
			letterFileOrgNm = (String)fileInfo.get("letterFileOrgNm");
            
			File uFile = new File(filepath, letterFileNm);
			int fSize = (int) uFile.length();
	 
			
			if (request.getHeader("User-Agent").indexOf("MSIE") > -1 || request.getHeader("User-Agent").indexOf("Trident") > -1) {
				letterFileOrgNm = URLEncoder.encode(letterFileOrgNm, "utf-8").replaceAll("\\+", "%20");
			} else {
				letterFileOrgNm = new String(letterFileOrgNm.getBytes("utf-8"), "ISO-8859-1");
			}
			
			
			if (fSize > 0) {
	 
				BufferedInputStream in = new BufferedInputStream(
						new FileInputStream(uFile));
				//String mimetype = "text/html";
				String mimetype = "application/octet-stream";
				
				response.setBufferSize(fSize);
				response.setContentType(mimetype);
				response.setHeader("Content-Disposition", "attachment; filename=\""
						+ letterFileOrgNm + "\"");       
				response.setHeader("Content-Transfer-Encoding", "binary");
				response.setContentLength(fSize);
	 
				FileCopyUtils.copy(in, response.getOutputStream());
				in.close();
				response.getOutputStream().flush();
				response.getOutputStream().close();
			} else {
				
				throw new Exception("파일이 존재하지 않습니다.");
				//setContentType을 프로젝트 환경에 맞추어 변경
				//response.setContentType("application/x-msdownload");
				//PrintWriter printwriter = response.getWriter();
				//printwriter.println("<html>");
				//printwriter.println("<br><br><br><h2>Could not get file name:<br>"
				//		+ (String)requestMap.get("letterFileOrgNm") + "</h2>");
				//printwriter
				//		.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				//printwriter.println("<br><br><br>&copy; webAccess");
				//printwriter.println("</html>");
				//printwriter.flush();
				//printwriter.close();
			}
		}catch (Exception e) {
	        logger.error(e.getMessage());
		}
	}
	
	//받은 편지함 편지 읽기 처리
	@RequestMapping(value = "/let/saveReadChk.json", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveReadChk( @RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		 Map result = new HashMap();
	        
		try {
			   letterService.saveReadChk(requestMap);
	           result.put("result", "OK");
		}catch (Exception e){
	           logger.error(e.getMessage());
	           result.put("result", "FAIL");
	           result.put("Message", e.getMessage());
		}
		
	    return result;
	}
    
}

