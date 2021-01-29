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
package com.koticobui.dfmc.client.donate.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Map.Entry;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.com.util.Pagination;
import com.koticobui.dfmc.client.donate.mapper.DonateMapper;
import com.koticobui.dfmc.client.donate.model.DonateSearchVO;
import com.koticobui.dfmc.client.donate.model.DonateVO;
import com.koticobui.dfmc.client.donate.model.StoryVO;
import com.koticobui.dfmc.client.donate.service.DonateService;
import com.koticobui.dfmc.client.let.mapper.LetterMapper;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;
import com.mysql.cj.Session;
import com.google.gson.JsonObject;



/**
 * The type Letter service.
 */
@Service("donateService")
public class DonateServiceImpl implements DonateService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DonateServiceImpl.class);

    @Resource(name = "donateMapper")
    private DonateMapper donateMapper;    
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
	@Override
	public HttpServletRequest member(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
	    String name = request.getParameter("name");
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	    String searchYear = request.getParameter("searchYear");
	    
	    DonateSearchVO donateSearch = new DonateSearchVO();
	    
	    if ((currentPage != null) && (!"".equals(currentPage))) {
	      donateSearch.setCurrentPage(Integer.parseInt(currentPage));
	    }else {
	      donateSearch.setCurrentPage(1);
	    }
	    donateSearch.setDonateName(name);
	    donateSearch.setStartDate(startDate);
	    donateSearch.setEndDate(endDate);
	    donateSearch.setSearchYear(searchYear);	    
	    int totalCnt = donateMapper.getDonateCount(donateSearch);
	    donateSearch.setTotalCount(totalCnt);
	    
	    List<Map<String, Object>> list = donateMapper.getDonateList(donateSearch);
	    List<Map<String, Object>> yearList = donateMapper.getDonateYearList();
	    request.setAttribute("yearList", yearList);
	    request.setAttribute("donateList", list);
	    request.setAttribute("donateSearch", donateSearch);
	    request.setAttribute("totalCount", Integer.valueOf(totalCnt));

		return request;
	}
	
	@Override
	public HttpServletRequest member_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
		String comCurrentPage = request.getParameter("comCurrentPage");
		String letterCurrentPage = request.getParameter("letterCurrentPage");
		String idx = request.getParameter("idx");
		String name = request.getParameter("name");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String searchYear = request.getParameter("searchYear");
		
		//donateSearch
		DonateSearchVO donateSearch = new DonateSearchVO();		
	    if ((currentPage != null) && (!"".equals(currentPage))) {
		  donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
		  donateSearch.setCurrentPage(1);
		}	    
		donateSearch.setDonateName(name);
		donateSearch.setStartDate(startDate);
		donateSearch.setEndDate(endDate);
		donateSearch.setSearchYear(searchYear);		
		if ((idx != null) && (!"".equals(idx))){
		  donateSearch.setIdx(Integer.parseInt(idx));
		}

		request.setAttribute("donateSearch", donateSearch);
		Map<String, Object> donateBean = donateMapper.getDonate(donateSearch);		
		request.setAttribute("donate", donateBean);
		
		//comDonateSearch
		DonateSearchVO comDonateSearch = new DonateSearchVO();
		comDonateSearch.setIdx(donateSearch.getIdx());
		comDonateSearch.setArticleCount(10);
		if ((comCurrentPage != null) && (!"".equals(comCurrentPage))){
			comDonateSearch.setCurrentPage(Integer.parseInt(comCurrentPage));
		}else {
			comDonateSearch.setCurrentPage(1);
		}
		int comCount = donateMapper.getDonateComCount(comDonateSearch);
		comDonateSearch.setTotalCount(comCount);
		List<Map<String,Object>> comList = donateMapper.getDonateComList(comDonateSearch);
		
		request.setAttribute("comList", comList);
		request.setAttribute("comDonateSearch", comDonateSearch);
		
		//letterDonateSearch
		DonateSearchVO letterDonateSearch = new DonateSearchVO();
		String gubun = "";
		letterDonateSearch.setArticleCount(10);
		if ((letterCurrentPage != null) && (!"".equals(letterCurrentPage))){
			letterDonateSearch.setCurrentPage(Integer.parseInt(letterCurrentPage));
		}else {
			letterDonateSearch.setCurrentPage(1);
		}
		if ((gubun == null) || ("".equals(gubun))){
		  gubun = "letter";
		}
		letterDonateSearch.setGubun(gubun);
		letterDonateSearch.setDonateIdx(Integer.parseInt(idx));
		int totalCnt = donateMapper.getStoryCount(letterDonateSearch);
		letterDonateSearch.setTotalCount(totalCnt);
		List<Map<String,Object>> list = donateMapper.getStoryList(letterDonateSearch);
		
		request.setAttribute("letterList", list);
		request.setAttribute("letterDonateSearch", letterDonateSearch);

		return request;
	}
	
	@Override
	@Transactional
	public Map<String, Object> member_like_update(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		String field = request.getParameter("field");
		
		String donatePine = request.getParameter("donatePine");
		String donateProud = request.getParameter("donateProud");
		String donateHard = request.getParameter("donateHard");
		String donateSad = request.getParameter("donateSad");
	
		DonateVO donateBean = new DonateVO();
		donateBean.setDonatePine(Integer.parseInt(donatePine));
		donateBean.setDonateProud(Integer.parseInt(donateProud));
		donateBean.setDonateHard(Integer.parseInt(donateHard));
		donateBean.setDonateSad(Integer.parseInt(donateSad));
		if ((idx != null) && (!"".equals(idx))) {
			donateBean.setDonateIdx(Integer.parseInt(idx));
		}
		donateBean.setField(field);
		donateMapper.updateLike(donateBean);

		DonateSearchVO donateSearch = new DonateSearchVO();
		if ((idx != null) && (!"".equals(idx))){
		  donateSearch.setIdx(Integer.parseInt(idx));
		}
		
		Map<String, Object> donateBeans = donateMapper.getDonate(donateSearch);
		return donateBeans;
	}
	
	@Override
	@Transactional
	public void member_com_insert(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		String replyContents = request.getParameter("replyContents");
		
		DonateVO donate = new DonateVO();
		if ((idx != null) && (!"".equals(idx))) {
		  donate.setDonateIdx(Integer.parseInt(idx));
		  donate.setReplyContents(replyContents);
		}
		
		donateMapper.donateReplyInsert(donate);

	}
//	
//	@Override
//	@Transactional
//	public void choice_insert(HttpServletRequest request) {
//	
//		
//		String donatePine = request.getParameter("donatePine");
//		String donateProud = request.getParameter("donateProud");
//		String donateHard = request.getParameter("donateHard");
//		String donateSad = request.getParameter("donateSad");
//		
//		DonateVO donate = new DonateVO();
//		donate.setDonatePine(Integer.parseInt(donatePine));
//		donate.setDonateProud(Integer.parseInt(donateProud));
//		donate.setDonateHard(Integer.parseInt(donateHard));
//		donate.setDonateSad(Integer.parseInt(donateSad));
//		
//		donateMapper.insertChoice(donate);
//
//	}

	@Override
	public HttpServletRequest letter(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		DonateSearchVO donateSearch = new DonateSearchVO();
		String gubun = request.getParameter("gubun");
		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		
		if ((gubun == null) || ("".equals(gubun))) {
		  gubun = "letter";
		}
		
		donateSearch.setGubun(gubun);
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		int totalCnt = donateMapper.getStoryCount(donateSearch);
		donateSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = donateMapper.getStoryList(donateSearch);
		
		request.setAttribute("letterList", list);
		request.setAttribute("donateSearch", donateSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		
		return request;
	}
	
	@Override
	@Transactional
	public HttpServletRequest letter_view(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String comCurrentPage = request.getParameter("comCurrentPage");
		String reloadYn = request.getParameter("reloadYn");
		
		//donateSearch
		DonateSearchVO donateSearch = new DonateSearchVO();		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}		
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearch.setIdx(Integer.parseInt(idx));
		}		
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		request.setAttribute("donateSearch", donateSearch);
		
		if ((reloadYn == null) || !reloadYn.equals("Y")) {
			donateMapper.updateStoryHits(donateSearch);			
		}
		
		Map<String,Object> storyBean = donateMapper.getStory(donateSearch);
		request.setAttribute("letter", storyBean);
		
		//comDonateSearch
		DonateSearchVO comDonateSearch = new DonateSearchVO();
		comDonateSearch.setIdx(donateSearch.getIdx());
		comDonateSearch.setGubun(donateSearch.getGubun());
		comDonateSearch.setArticleCount(10);
		
		if ((comCurrentPage != null) && (!"".equals(comCurrentPage))) {
			comDonateSearch.setCurrentPage(Integer.parseInt(comCurrentPage));
		}else {
			comDonateSearch.setCurrentPage(1);
		}
		
		int cnt = donateMapper.getStoryComCount(comDonateSearch);
		comDonateSearch.setTotalCount(cnt);
		
		List<Map<String, Object>> comList = donateMapper.getStoryComList(comDonateSearch);
		request.setAttribute("comList", comList);
		request.setAttribute("comDonateSearch", comDonateSearch);
		
		return request;
	}
	
	@Override
	@Transactional
	public void letter_com_insert(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		StoryVO storyBean = new StoryVO();
		
		storyBean.setComDiv(request.getParameter("gubun"));
		storyBean.setcomRegName(request.getParameter("uname"));
		storyBean.setcomPwd(request.getParameter("upw"));
		storyBean.setcomContent(request.getParameter("comContent"));
		storyBean.setBod_idx(Integer.parseInt(idx));
		
		donateMapper.storyComInsert(storyBean);
	}

	@Override
	@Transactional
	public Map<String, Objects> pwd_action(HttpServletRequest request) {
        Map result = new HashMap();
        
		String idx = request.getParameter("idx");
		String comIdx = request.getParameter("comIdx");
		String gubun = request.getParameter("gubun");
		String ppw = request.getParameter("ppw");
		String optionStr = request.getParameter("optionStr");
		
		DonateSearchVO donateSearch = new DonateSearchVO();
		
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearch.setIdx(Integer.parseInt(idx));
		}
		if ((comIdx != null) && (!"".equals(comIdx))) {
		  donateSearch.setComIdx(Integer.parseInt(comIdx));
		}
		donateSearch.setGubun(gubun);
		donateSearch.setPwd(ppw);
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		request.setAttribute("donateSearch", donateSearch);
		
		int cnt = donateMapper.checkPwd(donateSearch);
		
		if (cnt > 0) {
		  if ((Integer.parseInt(comIdx) > 0) && ("del".equals(optionStr))) {
		    donateMapper.storyComDelete(donateSearch);
		    result.put("result", "comDelSuccess");
		  } else if ("del".equals(optionStr)) {
			  donateMapper.storyDelete(donateSearch);
			  result.put("result", "delSuccess");
		  } else if ("update".equals(optionStr)) {
			  result.put("result", "goUpdate");
		  }
		}
		else
		{
		  result.put("result", "pwdFail");
		}
		
		return result;
		
	}

	@Override
	public HttpServletRequest letter_form(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String pwdYn = request.getParameter("pwdYn");
		String donateIdx = request.getParameter("donateIdx");
		String donateName = request.getParameter("donateName");
		
		DonateSearchVO donateSearch = new DonateSearchVO();
		Map<String,Object> storyBean = new HashMap<String,Object>();
		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		
		if ((idx != null) && (!"".equals(idx)))
		  donateSearch.setIdx(Integer.parseInt(idx));
		else {
		  idx = "0";
		}
		
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		request.setAttribute("donateSearch", donateSearch);
		
		if ((!"Y".equals(pwdYn)) && (Integer.parseInt(idx) > 0)) {
		  request.setAttribute("m_result", "fail");
		}
		
		if (Integer.parseInt(idx) > 0) {
		  storyBean = donateMapper.getStory(donateSearch);
		  
		}
		
		//수정인 경우, PW가 일치한 경우 세션 생성
		//if (("Y".equals(pwdYn)) && (Integer.parseInt(idx) > 0)) {
		//  HttpSession session = request.getSession();
		// session.setAttribute("cidx", idx);
		//}
	
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.put("donateIdx",Integer.parseInt(donateIdx));
		  storyBean.put("donateName",donateName);
		}
		
		request.setAttribute("letter", storyBean);
		return request;
	}

	@Override
	public Map<String, Objects> letter_insert(HttpServletRequest request) {
        Map result = new HashMap();
        
		StoryVO storyBean = new StoryVO();
		String donateIdx = request.getParameter("donateIdx");
		String anonymity = request.getParameter("anonymity");
		String area = request.getParameter("area");
		
		storyBean.setStoryWriter(request.getParameter("writer"));
		storyBean.setStoryPassword(request.getParameter("pwd"));
		if ((area != null) && (!"".equals(area))) {
			storyBean.setStoryArea(area);
		}else {
			storyBean.setStoryArea("0");
		}
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));
		storyBean.setStoryGubun(request.getParameter("gubun"));
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.setDonateIdx(Integer.parseInt(donateIdx));
		}

		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		donateMapper.addStory(storyBean);
		
		result.put("result", "insertSuccess");
		return result;
	}
	
	@Override
	public Map<String, Objects> letter_update(HttpServletRequest request) {
        Map result = new HashMap();
        
		StoryVO storyBean = new StoryVO();
		
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		String donateIdx = request.getParameter("donateIdx");
		String anonymity = request.getParameter("anonymity");
		String area = request.getParameter("area");
		
		storyBean.setStoryIdx(Integer.parseInt(idx));
		storyBean.setStoryWriter(request.getParameter("writer"));
		if ((area != null) && (!"".equals(area))) {
			storyBean.setStoryArea(area);
		}else {
			storyBean.setStoryArea("0");
		}
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));

		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		
		storyBean.setStoryGubun(gubun);
		
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.setDonateIdx(Integer.parseInt(donateIdx));
		}
		
		donateMapper.updateStory(storyBean);
		
		//HttpSession session = request.getSession();
		//session.invalidate();
		
		result.put("result", "updateSuccess");
		
		return result;
	}
	

	@Override
	public Map<String, Objects> letter_delete(HttpServletRequest request) {
        Map result = new HashMap();

        DonateSearchVO donateSearchBean = new DonateSearchVO();
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearchBean.setIdx(Integer.parseInt(idx));
		}else{
		  idx = "0";
		}
		donateSearchBean.setGubun(gubun);
		
		donateMapper.storyDelete(donateSearchBean);

		//HttpSession session = request.getSession();
		//session.invalidate();
		
		result.put("result", "deleteSuccess");
		
		return result;

	}
	
	//////////////////////////////////////////////////////
	@Override
	public HttpServletRequest receipt(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		DonateSearchVO donateSearch = new DonateSearchVO();
		String gubun = request.getParameter("gubun");
		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		
		if ((gubun == null) || ("".equals(gubun))) {
		  gubun = "recipient";
		}
		
		donateSearch.setGubun(gubun);
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		int totalCnt = donateMapper.getStoryCount(donateSearch);
		donateSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = donateMapper.getStoryList(donateSearch);
		
		request.setAttribute("recipientList", list);
		request.setAttribute("donateSearch", donateSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		
		return request;
	}
	
	@Override
	@Transactional
	public HttpServletRequest receipt_view(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String comCurrentPage = request.getParameter("comCurrentPage");
		String reloadYn = request.getParameter("reloadYn");
		
		//donateSearch
		DonateSearchVO donateSearch = new DonateSearchVO();		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}		
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearch.setIdx(Integer.parseInt(idx));
		}		
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		request.setAttribute("donateSearch", donateSearch);
		
		if ((reloadYn == null) || !reloadYn.equals("Y")) {
			donateMapper.updateStoryHits(donateSearch);			
		}
		
		Map<String,Object> storyBean = donateMapper.getStory(donateSearch);
		request.setAttribute("recipient", storyBean);
		
		//comDonateSearch
		DonateSearchVO comDonateSearch = new DonateSearchVO();
		comDonateSearch.setIdx(donateSearch.getIdx());
		comDonateSearch.setGubun(donateSearch.getGubun());
		comDonateSearch.setArticleCount(10);
		
		if ((comCurrentPage != null) && (!"".equals(comCurrentPage))) {
			comDonateSearch.setCurrentPage(Integer.parseInt(comCurrentPage));
		}else {
			comDonateSearch.setCurrentPage(1);
		}
		
		int cnt = donateMapper.getStoryComCount(comDonateSearch);
		comDonateSearch.setTotalCount(cnt);
		
		List<Map<String, Object>> comList = donateMapper.getStoryComList(comDonateSearch);
		request.setAttribute("comList", comList);
		request.setAttribute("comDonateSearch", comDonateSearch);
		
		return request;
	}
	
	@Override
	@Transactional
	public void receipt_com_insert(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		StoryVO storyBean = new StoryVO();
		
		storyBean.setComDiv(request.getParameter("gubun"));
		storyBean.setcomRegName(request.getParameter("uname"));
		storyBean.setcomPwd(request.getParameter("upw"));
		storyBean.setcomContent(request.getParameter("comContent"));
		storyBean.setBod_idx(Integer.parseInt(idx));
		
		donateMapper.storyComInsert(storyBean);
	}

	@Override
	public HttpServletRequest receipt_form(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String pwdYn = request.getParameter("pwdYn");
		String donateIdx = request.getParameter("donateIdx");
		String donateName = request.getParameter("donateName");
		
		DonateSearchVO donateSearch = new DonateSearchVO();
		Map<String,Object> storyBean = new HashMap<String,Object>();
		
		if ((currentPage != null) && (!"".equals(currentPage))) {
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		
		if ((idx != null) && (!"".equals(idx)))
		  donateSearch.setIdx(Integer.parseInt(idx));
		else {
		  idx = "0";
		}
		
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		request.setAttribute("donateSearch", donateSearch);
		
		if ((!"Y".equals(pwdYn)) && (Integer.parseInt(idx) > 0)) {
		  request.setAttribute("m_result", "fail");
		}
		
		if (Integer.parseInt(idx) > 0) {
		  storyBean = donateMapper.getStory(donateSearch);
		  
		}
		
		//수정인 경우, PW가 일치한 경우 세션 생성
		//if (("Y".equals(pwdYn)) && (Integer.parseInt(idx) > 0)) {
		//  HttpSession session = request.getSession();
		// session.setAttribute("cidx", idx);
		//}
	
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.put("donateIdx",Integer.parseInt(donateIdx));
		  storyBean.put("donateName",donateName);
		}
		
		request.setAttribute("recipient", storyBean);
		return request;
	}

	@Override
	public Map<String, Objects> receipt_insert(HttpServletRequest request) {
        Map result = new HashMap();
        
		StoryVO storyBean = new StoryVO();
		String donateIdx = request.getParameter("donateIdx");
		String anonymity = request.getParameter("anonymity");
		String area = request.getParameter("area");
		
		storyBean.setStoryWriter(request.getParameter("writer"));
		storyBean.setStoryPassword(request.getParameter("pwd"));
		if ((area != null) && (!"".equals(area))) {
			storyBean.setStoryArea(area);
		}else {
			storyBean.setStoryArea("0");
		}
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));
		storyBean.setStoryGubun(request.getParameter("gubun"));
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.setDonateIdx(Integer.parseInt(donateIdx));
		}

		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		donateMapper.addStory(storyBean);
		
		result.put("result", "insertSuccess");
		return result;
	}
	
	@Override
	public Map<String, Objects> receipt_update(HttpServletRequest request) {
        Map result = new HashMap();
        
		StoryVO storyBean = new StoryVO();
		
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		String donateIdx = request.getParameter("donateIdx");
		String anonymity = request.getParameter("anonymity");
		String area = request.getParameter("area");
		
		storyBean.setStoryIdx(Integer.parseInt(idx));
		storyBean.setStoryWriter(request.getParameter("writer"));
		if ((area != null) && (!"".equals(area))) {
			storyBean.setStoryArea(area);
		}else {
			storyBean.setStoryArea("0");
		}
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));

		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		
		storyBean.setStoryGubun(gubun);
		
		if ((donateIdx != null) && (!"".equals(donateIdx))) {
		  storyBean.setDonateIdx(Integer.parseInt(donateIdx));
		}
		
		donateMapper.updateStory(storyBean);
		
		//HttpSession session = request.getSession();
		//session.invalidate();
		
		result.put("result", "updateSuccess");
		
		return result;
	}
	

	@Override
	public Map<String, Objects> receipt_delete(HttpServletRequest request) {
        Map result = new HashMap();

        DonateSearchVO donateSearchBean = new DonateSearchVO();
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearchBean.setIdx(Integer.parseInt(idx));
		}else{
		  idx = "0";
		}
		donateSearchBean.setGubun(gubun);
		
		donateMapper.storyDelete(donateSearchBean);

		//HttpSession session = request.getSession();
		//session.invalidate();
		
		result.put("result", "deleteSuccess");
		
		return result;

	}
	
	////////////////////////////////////////////////////

	
	@Override
	public HttpServletRequest story(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		DonateSearchVO donateSearch = new DonateSearchVO();
		String gubun = request.getParameter("gubun");
		if ((currentPage != null) && (!"".equals(currentPage))){
			donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		if ((gubun == null) || ("".equals(gubun))){
		  gubun = "story";
		}
		
		donateSearch.setGubun(gubun);
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		
		int totalCnt = donateMapper.getStoryCount(donateSearch);
		donateSearch.setTotalCount(totalCnt);
		List<Map<String,Object>> list = donateMapper.getStoryList(donateSearch);
		request.setAttribute("storyList", list);
		request.setAttribute("donateSearch", donateSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		
		return request;
	}

	@Override
	@Transactional
	public HttpServletRequest story_view(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String comCurrentPage = request.getParameter("comCurrentPage");
		String reloadYn = request.getParameter("reloadYn");
		
		DonateSearchVO donateSearch = new DonateSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))) {
		  donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearch.setIdx(Integer.parseInt(idx));
		}
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		request.setAttribute("donateSearch", donateSearch);

		if ((reloadYn == null) || !reloadYn.equals("Y")) {
			donateMapper.updateStoryHits(donateSearch);	
		}
		
		Map<String,Object> storyBean = donateMapper.getStory(donateSearch);
		request.setAttribute("story", storyBean);
		
		DonateSearchVO comDonateSearch = new DonateSearchVO();
		comDonateSearch.setIdx(donateSearch.getIdx());
		comDonateSearch.setGubun(donateSearch.getGubun());
		comDonateSearch.setArticleCount(10);
		if ((comCurrentPage != null) && (!"".equals(comCurrentPage))) {
		  comDonateSearch.setCurrentPage(Integer.parseInt(comCurrentPage));
		}else {
			comDonateSearch.setCurrentPage(1);
		}
		int cnt = donateMapper.getStoryComCount(comDonateSearch);
		comDonateSearch.setTotalCount(cnt);
		List<Map<String,Object>> comList = donateMapper.getStoryComList(comDonateSearch);
		request.setAttribute("comList", comList);
		request.setAttribute("comDonateSearch", comDonateSearch);
		
		return request;
	}

	@Override
	public void story_com_insert(HttpServletRequest request) {
		String idx = request.getParameter("idx");
		
		StoryVO storyBean = new StoryVO();
		storyBean.setComDiv(request.getParameter("gubun"));
		storyBean.setcomRegName(request.getParameter("uname"));
		storyBean.setcomPwd(request.getParameter("upw"));
		storyBean.setcomContent(request.getParameter("comContent"));
		storyBean.setBod_idx(Integer.parseInt(idx));
		
		donateMapper.storyComInsert(storyBean);
	}

	@Override
	public HttpServletRequest story_form(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		String pwdYn = request.getParameter("pwdYn");
		DonateSearchVO donateSearch = new DonateSearchVO();
		Map<String,Object> storyBean =  new HashMap<String,Object>();
		if ((currentPage != null) && (!"".equals(currentPage))){
		  donateSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			donateSearch.setCurrentPage(1);
		}
		
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearch.setIdx(Integer.parseInt(idx));
		}else {
		  idx = "0";
		}
		donateSearch.setGubun(request.getParameter("gubun"));
		donateSearch.setSearchKey(request.getParameter("searchKey"));
		donateSearch.setSearchValue(request.getParameter("searchValue"));
		request.setAttribute("donateSearch", donateSearch);
		if ((!"Y".equals(pwdYn)) && (Integer.parseInt(idx) > 0))
		{
		  request.setAttribute("m_result", "fail");
		}
		if (Integer.parseInt(idx) > 0)
		{
		  storyBean = donateMapper.getStory(donateSearch);
		  request.setAttribute("story", storyBean);
		}
		
		return request;
	}


	@Override
	public Map<String, Objects> story_insert(HttpServletRequest request) {

        Map result = new HashMap();
		String anonymity = request.getParameter("anonymity");
        
		StoryVO storyBean = new StoryVO();
		storyBean.setStoryWriter(request.getParameter("writer"));
		storyBean.setStoryPassword(request.getParameter("pwd"));
		storyBean.setStoryArea(request.getParameter("area"));
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));
		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		storyBean.setStoryGubun(request.getParameter("gubun"));
		donateMapper.addStory(storyBean);
		
		result.put("result", "insertSuccess");
		return result;
	}
	

	@Override
	public Map<String, Objects> story_update(HttpServletRequest request) {
        Map result = new HashMap();
        
		StoryVO storyBean = new StoryVO();
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		String anonymity = request.getParameter("anonymity");
		
		storyBean.setStoryIdx(Integer.parseInt(idx));
		storyBean.setStoryWriter(request.getParameter("writer"));
		storyBean.setStoryArea(request.getParameter("area"));
		storyBean.setStoryTitle(request.getParameter("title"));
		storyBean.setStoryContents(request.getParameter("contents"));
		if ((anonymity != null) && (!"".equals(anonymity))) {
			storyBean.setStoryAnonymity(anonymity);
		}else {
			storyBean.setStoryAnonymity("N");
		}
		storyBean.setStoryGubun(gubun);
		
		donateMapper.updateStory(storyBean);
		
		result.put("result", "updateSuccess");
		
		return result;
	}
	
	@Override
	public Map<String, Objects> story_delete(HttpServletRequest request) {
        Map result = new HashMap();

        DonateSearchVO donateSearchBean = new DonateSearchVO();
        
		String idx = request.getParameter("idx");
		String gubun = request.getParameter("gubun");
		
		if ((idx != null) && (!"".equals(idx))) {
		  donateSearchBean.setIdx(Integer.parseInt(idx));
		}else{
		  idx = "0";
		}
		donateSearchBean.setGubun(gubun);
		
		donateMapper.storyDelete(donateSearchBean);

		result.put("result", "deleteSuccess");
		
		return result;
	}
	
    
}
