/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.let.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



/**
 * The interface letterService service.
 */
public interface LetterService {
	

	//편지함별 총계 조회
	Map<String,Object> searchLetterListTot(Map requestMap);

	//편지함 리스트
	Map<String, Object> searchLetterList(Map requestMap);

	//매칭대상 검색
	Map<String, Object> searchReceiverByMath(Map requestMap);
	
	//편지발송
	@Transactional
	void sendLetter(Map requestMap, MultipartHttpServletRequest request)  throws IllegalStateException, IOException;
	
	//편지보기
	Map<String, Object> searchLetterView(Map requestMap);
	
	////받은 편지함 편지 읽기 처리
	void saveReadChk(Map requestMap);
	
	//첩무파일 다운로드 정보 조회
	Map<String, Object> searchLetterFile(Map requestMap);
}
