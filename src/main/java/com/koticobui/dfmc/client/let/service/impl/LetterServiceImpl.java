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
package com.koticobui.dfmc.client.let.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.com.util.Pagination;
import com.koticobui.dfmc.client.let.mapper.LetterMapper;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;
import com.google.gson.JsonObject;



/**
 * The type Letter service.
 */
@Service("letterService")
public class LetterServiceImpl implements LetterService {

    private static final Logger LOGGER = LoggerFactory.getLogger(LetterServiceImpl.class);

    @Resource(name = "letterMapper")
    private LetterMapper letterMapper;
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    @Resource(name = "multipartResolver")
    CommonsMultipartResolver multipartResolver;
    
    @Value("#{appConfig['file.upload.path']}")
    private String filepath;

    @Value("#{appConfig['file.denied.extension']}")
    private String fileextension;

    @Value("#{appConfig['file.denied.size']}")
    private String fileDeniedSize;
    
    //////////////////////////////////////
    
    @Override
	//편지함별 총계 조회
	public Map<String, Object> searchLetterListTot(Map requestMap) {
    	Map result = new HashMap<String,Object>();
    	int noReadTot = 0;
    	int letBoxTot = 0;
    	
    	Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());

    	if (((String)requestMap.get("gubn")).equals("S") || ((String)requestMap.get("gubn")).equals("T") ){
    		//보낸편지함, 임시보관함
    		letBoxTot = letterMapper.searchLetterSendListTot(requestMap);	
    	}else if (((String)requestMap.get("gubn")).equals("R") || ((String)requestMap.get("gubn")).equals("N") ){
    		//받은편지함, 안읽은편지함
    		letBoxTot = letterMapper.searchLetterReciListTot(requestMap);	
    	}
    	
    	//안읽은편지함 총 개수(항상 콜)
    	requestMap.put("gubn", "N");
    	noReadTot = letterMapper.searchLetterReciListTot(requestMap);
    	
    	result.put("letBoxTot", letBoxTot);
    	result.put("noReadTot", noReadTot);
    	
		return result;
	}

	@Override
	//편지함 리스트
	public Map<String, Object> searchLetterList(Map requestMap) {

    	int listCnt = 0;
    	int curPage = requestMap.get("curPage") == null ? 1 : Integer.parseInt((String)requestMap.get("curPage"));
	     
	    Map result = new HashMap<String, Object>();
    	
	    Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	//페이징 처리
    	if (((String)requestMap.get("gubn")).equals("S") || ((String)requestMap.get("gubn")).equals("T") ){
    		//보낸편지함, 임시보관함
    		listCnt = letterMapper.searchLetterSendListTot(requestMap);	
    	}else if (((String)requestMap.get("gubn")).equals("R") || ((String)requestMap.get("gubn")).equals("N") ){
    		//받은편지함, 안읽은편지함
    		listCnt = letterMapper.searchLetterReciListTot(requestMap);	
    	}
    	
    	LOGGER.debug("curPage : " + curPage);

        Pagination pagination = new Pagination(listCnt, curPage);
        
        result.put("page", pagination);
        
        //페이지 수 가저오기
        requestMap.put("pageSize", pagination.getPageSize());
    	
    	//편지함 조회
    	if (((String)requestMap.get("gubn")).equals("S") || ((String)requestMap.get("gubn")).equals("T") ){
    		//보낸편지함, 임시보관함
    		result.put("list", letterMapper.searchLetterSendList(requestMap));	
    	}else if (((String)requestMap.get("gubn")).equals("R") || ((String)requestMap.get("gubn")).equals("N") ){
    		//받은편지함, 안읽은편지함
    		result.put("list", letterMapper.searchLetterReciList(requestMap));
    	}

	    return result;
		
	}
	
	//매칭대상 조회
	@Override
	public Map<String, Object> searchReceiverByMath(Map requestMap) {
		Map result;
		
	    Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	if (((String)requestMap.get("returnflg")).equals("Y")) {
        	result = letterMapper.searchReturnReceiver(requestMap);
    	}else if (((String)requestMap.get("tempflg")).equals("Y")) {
        	result = letterMapper.searchTempReceiver(requestMap);
    	}else {
        	result = letterMapper.searchReceiverByMath(requestMap);
    	}

		return result;
	}

	//편지발송
	@Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public void sendLetter(Map requestMap, MultipartHttpServletRequest multiRequest) throws IllegalStateException, IOException {
	    Map result = new HashMap<String, Object>();
    	
	    Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
		
    	//메인편지저장
    	//답장인 경우 해당 편지의 수신자로
    	if (((String)requestMap.get("returnflg")).equals("Y")) {
    		letterMapper.insertLetterReturn(requestMap);
    	}else{
    		letterMapper.insertLetter(requestMap);    		
    	}
    	
    	//받는사람저장
    	//답장인 경우 해당 편지의 수신자로
    	if (((String)requestMap.get("returnflg")).equals("Y")) {
    		letterMapper.insertReceiverReturn(requestMap);    		
    	}else if (((String)requestMap.get("tempflg")).equals("Y")) {
    		letterMapper.insertTempReceiver(requestMap);
    	}else {
    		letterMapper.insertReceiver(requestMap);    		
    	}
    	
    	//첨부파일저장
    	//첨부파일 upload
    	final Map<String, MultipartFile> files = multiRequest.getFileMap();
    	
    	// 폴더 생성
		String uploadPath = filepath;

		File saveFolder = new File(uploadPath);

		LOGGER.debug("uploadPath: " + uploadPath);
		// 디렉토리 생성
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		List fileInfoList = new ArrayList();
		String filePath;

		int fileidx = 0; 
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			LOGGER.debug("[" + entry.getKey() + "]");

			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {

				//파일 안정성(확장자) 체크
				String filename = file.getOriginalFilename();
				String fileext = filename.substring(filename.lastIndexOf(".") + 1);
				fileext = fileext.toLowerCase();

				LOGGER.debug("fileext : [" + fileext + "]");
				LOGGER.debug("fileextension : [" + fileextension + "]");
				String[] fileextdenilist= fileextension.split(",");
				
				for (int i = 0 ; i < fileextdenilist.length; i++) {
					if (fileext.equals(fileextdenilist[i].trim())) {
						throw new IOException(fileext + "는 허용되지 않는 확장자 입니다.");
					}
				}
				
				//파일 용량 체크
				LOGGER.debug("getSize : [" + file.getSize() + "]");
				if (file.getSize() > Long.parseLong(fileDeniedSize)){
					throw new IOException("업로드 제한 용량을 초과하였습니다(50MB).");
				}
				
				fileidx = fileidx + 1;

				String letter_file_nm = ""+ requestMap.get("letter_id") + fileidx + new SimpleDateFormat("yyyyMMddHHmmss").format(System.currentTimeMillis());

				LOGGER.debug("letter_file_nm: " + letter_file_nm);

				filePath = uploadPath + letter_file_nm;
				LOGGER.debug("filePath: " + filePath);
				file.transferTo(new File(filePath));

				// 데이터베이스 파일 정보 저장
				Map<String, Object> filetMap = new HashMap<String, Object>();

				filetMap.put("letter_id", requestMap.get("letter_id"));
				filetMap.put("letter_file_nm", letter_file_nm);
				filetMap.put("letter_file_org_nm", file.getOriginalFilename());
				filetMap.put("id", customer.getUsername());

				letterMapper.insertLetterFile(filetMap);
			}
		}
    	
    	//임시저장 편지 전송 시 기존 내역 삭제
    	if (((String)requestMap.get("tempflg")).equals("Y")){
			letterMapper.deleteFileAll(requestMap);
			letterMapper.deleteLetterReceiver(requestMap);
			letterMapper.deleteLetter(requestMap);
    	}
	}
	
	
	//편지보기
	@Override
	public Map<String, Object> searchLetterView(Map requestMap) {
    	
    	Map result = new HashMap<String, Object>();
     	
 	    Customer customer = authenticationService.getCustomer();
     	
     	requestMap.put("id", customer.getUsername());
     	
     	String tempflg = ((String)requestMap.get("tempflg")) == null ? "" : (String)requestMap.get("tempflg");
     	String returnflg = ((String)requestMap.get("returnflg")) == null ? "" : (String)requestMap.get("returnflg");
     	
     	//편지내용
     	if (((String)requestMap.get("gubn")).equals("S") || ((String)requestMap.get("gubn")).equals("T") || tempflg.equals("Y") ){
     		//보낸편지, 임시보관편지
     		result.putAll(letterMapper.searchLetterSend(requestMap));
     	}else if (((String)requestMap.get("gubn")).equals("R") || ((String)requestMap.get("gubn")).equals("N") || returnflg.equals("Y")){
     		result.putAll(letterMapper.searchLetterReci(requestMap));
     	}
    	
    	//첨부파일 조회
		result.put("filelist", letterMapper.searchLetterFile(requestMap));	
		
		//이전,다음편지 조회
    	if (((String)requestMap.get("gubn")).equals("S") || ((String)requestMap.get("gubn")).equals("T")){
    		//보낸편지함, 임시보관함
    		result.put("palist", letterMapper.searchLetterSendList(requestMap));	
    	}else if (((String)requestMap.get("gubn")).equals("R") || ((String)requestMap.get("gubn")).equals("N") ){
    		//받은편지함, 안읽은편지함
    		result.put("palist", letterMapper.searchLetterReciList(requestMap));
    	}

		return result;
		
	}
	
	
	//받은 편지함 편지 읽기 처리
	@Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public void saveReadChk(Map requestMap) {

    	
	    Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	int chkflg = letterMapper.selectChkReceiver(requestMap);
    	
    	if (chkflg > 0 ) {
    		LOGGER.debug("update Receiver Time ");
    		letterMapper.updateReceiver(requestMap);
    	}
	}
	
	
	//첨부파일 다운로드 정보 조회
	@Override
	public Map<String, Object> searchLetterFile(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
	 	
	    Customer customer = authenticationService.getCustomer();
	 	
	 	requestMap.put("id", customer.getUsername());
	 	
		//첨부파일 조회
     	if (((String)requestMap.get("f_gubn")).equals("S") || ((String)requestMap.get("f_gubn")).equals("T") ){
     		//보낸편지, 임시보관편지
     		result.putAll(letterMapper.LetterDownFileST(requestMap));
     	}else if (((String)requestMap.get("f_gubn")).equals("R") || ((String)requestMap.get("f_gubn")).equals("N") ){
     		result.putAll(letterMapper.LetterDownFileRN(requestMap));
     	}
     	
		return result;
		
	}
	
}
