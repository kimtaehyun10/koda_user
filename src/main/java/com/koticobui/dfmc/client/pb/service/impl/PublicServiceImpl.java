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
package com.koticobui.dfmc.client.pb.service.impl;

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
import java.util.Set;
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

import com.koticobui.dfmc.client.board.model.BoardContVO;
import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.com.util.Pagination;
import com.koticobui.dfmc.client.donate.model.DonateSearchVO;
import com.koticobui.dfmc.client.donate.model.DonateVO;
import com.koticobui.dfmc.client.donate.model.StoryVO;
import com.koticobui.dfmc.client.donate.service.DonateService;
import com.koticobui.dfmc.client.let.mapper.LetterMapper;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.pb.mapper.PublicMapper;
import com.koticobui.dfmc.client.pb.model.BrainSearchVO;
import com.koticobui.dfmc.client.pb.model.PublicSearchVO;
import com.koticobui.dfmc.client.pb.service.PublicService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;
import com.mysql.cj.Session;
import com.google.gson.JsonObject;

/**
 * The type Letter service.
 */
@Service("publicService")
public class PublicServiceImpl implements PublicService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PublicServiceImpl.class);

    @Resource(name = "publicMapper")
    private PublicMapper publicMapper;    
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    private String menuCd;
    private int newsNum;
    private int movieNum;
    private int reportNum;
    private int forumNum;
    private int publicationNum;
    private int newsLetterNum;
    private int annualNum;
    private int casebookNum;
    private int storyNum;
    private int lawNum;
    private int academicNum;
    private int pressReleaseNum;
    private int makePublicNum;
    private int openDataNum;
    private int notifyNum;
    private int comparisonNum;
    private int webContetsNum;
    private int noticeNum;
    private int humanboardNum;
    private int faqNum;
    private int hireNum;
    
    public PublicServiceImpl()
    {
      this.menuCd = "";
      this.newsNum = 6;
      this.movieNum = 9;
      this.reportNum = 16;
      this.forumNum = 20;
      this.publicationNum = 22;
      this.newsLetterNum = 23;
      this.annualNum = 24;
      this.casebookNum = 22;
      this.storyNum = 30;
    
      this.academicNum = 13;
      this.lawNum = 21;
      this.pressReleaseNum = 31;
    
      this.makePublicNum = 32;
      this.openDataNum = 33;
      this.notifyNum = 34;
      this.comparisonNum = 35;
      this.webContetsNum = 36;
      
      this.noticeNum = 7;
      this.humanboardNum = 27;
      this.faqNum = 29;
      this.hireNum = 43;
    }
    
	@Override
	public HttpServletRequest annual(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
		String seqCd2 =  request.getParameter("seqCd2");
		int seqCd2Int = Integer.parseInt(seqCd2);
		if(seqCd2Int == 0) {
			prSearch.setArticleCount(3);
		}else {
			prSearch.setArticleCount(9);
		}
		
	
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(this.annualNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
		int totalCnt = publicMapper.getBoardCount(prSearch);
		prSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
		
		request.setAttribute("annualNum", Integer.valueOf(this.annualNum));
		request.setAttribute("annualList", list);
		request.setAttribute("prSearch", prSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		return request;

	}
	
	@Override
	public HttpServletRequest eBook(HttpServletRequest request) {
		

		PublicSearchVO prSearch = new PublicSearchVO();
		String num = request.getParameter("num");
		String idx = request.getParameter("idx");
		
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(Integer.parseInt(num));
		prSearch.setBrdContNo(Integer.parseInt(idx));
		
		Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
		request.setAttribute("bean", boardContBean);
		request.setAttribute("num", num);
		request.setAttribute("prSearch", prSearch);

		return request;

	}

	@Override
	public HttpServletRequest news_Letter(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
		
		String seqCd2 =  request.getParameter("seqCd2");
		int seqCd2Int = Integer.parseInt(seqCd2);
		if(seqCd2Int == 0) {
			prSearch.setArticleCount(3);
		}else {
			prSearch.setArticleCount(9);
		}
		
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(this.newsLetterNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
		int totalCnt = publicMapper.getBoardCount(prSearch);
		prSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);

		request.setAttribute("newsLetterNum", Integer.valueOf(this.newsLetterNum));
		request.setAttribute("newsLetterList", list);
		request.setAttribute("prSearch", prSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		return request;

	}
	
	@Override
	public HttpServletRequest casebook(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
		
		String seqCd2 =  request.getParameter("seqCd2");
		int seqCd2Int = Integer.parseInt(seqCd2);
		if(seqCd2Int == 0) {
			prSearch.setArticleCount(3);
		}else {
			prSearch.setArticleCount(9);
		}
		
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(this.casebookNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
		int totalCnt = publicMapper.getBoardCount(prSearch);
		prSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
		
		request.setAttribute("casebookNum", Integer.valueOf(this.annualNum));
		request.setAttribute("casebookList", list);
		request.setAttribute("prSearch", prSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		return request;

	}
	

	@Override
	public HttpServletRequest movie(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
		prSearch.setArticleCount(9);
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(this.movieNum); 
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
		int totalCnt = publicMapper.getBoardCount(prSearch);
		prSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
		
		request.setAttribute("movieList", list);
		request.setAttribute("prSearch", prSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		return request;

	}
	

	@Override
	public HttpServletRequest movie_view(HttpServletRequest request) {

		String currentPage = request.getParameter("currentPage");
		String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		prSearch.setArticleCount(9);
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
		prSearch.setBrdFileSeq(1);
		prSearch.setBrdNo(this.movieNum); 
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
		int totalCnt = publicMapper.getBoardCount(prSearch);
		prSearch.setTotalCount(totalCnt);
		
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);

		if ((idx != null) && (!"".equals(idx))) {
		  prSearch.setBrdContNo(Integer.parseInt(idx));
		}else {
		  prSearch.setOptionStr("first");
		}
		Map<String,Object> firstBoard = publicMapper.getBoard(prSearch);

		request.setAttribute("movie", firstBoard);
		request.setAttribute("movieList", list);
		request.setAttribute("prSearch", prSearch);
		request.setAttribute("totalCount", Integer.valueOf(totalCnt));
		return request;

	}
	

	@Override
	public HttpServletRequest web_contents(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.webContetsNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);

		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
		
        request.setAttribute("webContentsList", list);
        request.setAttribute("prSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}
	

	@Override
	public HttpServletRequest web_contents_view(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(2);
        prSearch.setBrdNo(this.webContetsNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("prSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
		Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("webContents", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("webContentsNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("webContentsPrev", boardContBeanPrev);
        
		return request;

	}

	@Override
	public HttpServletRequest lifeSharing(HttpServletRequest request) {

        String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.storyNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
		List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("storyList", list);
        request.setAttribute("prSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}

	@Override
	public HttpServletRequest lifeSharing_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(2);
        prSearch.setBrdNo(this.storyNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("prSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("story", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("storyNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("storyPrev", boardContBeanPrev);
        
		return request;

	}
	

	@Override
	public HttpServletRequest pressRelease(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.pressReleaseNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
		List<Map<String,Object>> pressRelease = publicMapper.getBoardList(prSearch);
        request.setAttribute("pressReleaseList", pressRelease);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}

	@Override
	public HttpServletRequest pressRelease_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.pressReleaseNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("pressRelease", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("pressReleaseNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("pressReleasePrev", boardContBeanPrev);
        
		return request;

	}
	

	@Override
	public HttpServletRequest notice(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.noticeNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("noticeList", list);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest notice_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.noticeNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("notice", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("noticeNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("noticePrev", boardContBeanPrev);
        
		return request;

	}
	
	@Override
	public HttpServletRequest comnews(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
		prSearch.setArticleCount(10);
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.forumNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("forumList", list);
        request.setAttribute("prSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest comnews_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(2);
        prSearch.setBrdNo(this.forumNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("prSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("forum", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("forumNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("forumPrev", boardContBeanPrev);
        
		return request;

	}	
	

	@Override
	public HttpServletRequest infobefore(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.makePublicNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("makePublicList", list);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest infobefore_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.makePublicNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("makePublic", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("makePublicNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("makePublicPrev", boardContBeanPrev);
        
		return request;

	}	
	

	@Override
	public HttpServletRequest infodata(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.openDataNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("openDataList", list);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest infodata_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.openDataNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("openData", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("openDataNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("openDataPrev", boardContBeanPrev);
        
		return request;

	}	
	
	@Override
	public HttpServletRequest infolaw(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		String brdNo= request.getParameter("brdNo");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        if(brdNo != null && !"".equals(brdNo)){
            prSearch.setBrdNo(Integer.parseInt(brdNo));
        }else {
        	prSearch.setBrdNo(-1);
        }
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("libList", list);
        request.setAttribute("libSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest infolaw_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
		String brdNo= request.getParameter("brdNo");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(brdNo != null && !"".equals(brdNo)){
            prSearch.setBrdNo(Integer.parseInt(brdNo));
        }else {
        	prSearch.setBrdNo(-1);
        }
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        if(prSearch.getBrdNo() == 13) {
        	prSearch.setBrdFileSeq(1);
        }else {
        	prSearch.setBrdFileSeq(1);
        }
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("libSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("lib", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("libNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("libPrev", boardContBeanPrev);
        
		return request;

	}
	
	@Override
	public HttpServletRequest comrecruit(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.noticeNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("noticeList", list);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest comrecruit_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.noticeNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("notice", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("noticeNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("noticePrev", boardContBeanPrev);
        
		return request;

	}
	

	@Override
	public HttpServletRequest comhuman(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.humanboardNum);
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("humanList", list);
        request.setAttribute("prSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}


	@Override
	public HttpServletRequest comhuman_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(2);
        prSearch.setBrdNo(this.humanboardNum);
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("prSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("human", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("humanNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("humanPrev", boardContBeanPrev);
        
		return request;

	}

	@Override
	public HttpServletRequest organ_agree1(HttpServletRequest request) {

		BrainSearchVO brainSearch = new BrainSearchVO();
		brainSearch.setHospitalType("H");
		brainSearch.setHospitalArea("0");
		List<Map<String,Object>> hospitalList1 = publicMapper.getHospitalList(brainSearch);
		brainSearch.setHospitalArea("1");
		List<Map<String,Object>> hospitalList2 = publicMapper.getHospitalList(brainSearch);
		brainSearch.setHospitalArea("2");
		List<Map<String,Object>> hospitalList3 = publicMapper.getHospitalList(brainSearch);
		request.setAttribute("hospitalList1", hospitalList1);
		request.setAttribute("hospitalList2", hospitalList2);
		request.setAttribute("hospitalList3", hospitalList3);
        
		return request;
	}
	
	@Override
	public HttpServletRequest organ_agree2(HttpServletRequest request) {

		BrainSearchVO brainSearch = new BrainSearchVO();
		brainSearch.setHospitalType("D");
		brainSearch.setHospitalArea("0");
		List<Map<String,Object>> hospitalList1 = publicMapper.getHospitalList(brainSearch);
		brainSearch.setHospitalArea("1");
		List<Map<String,Object>> hospitalList2 = publicMapper.getHospitalList(brainSearch);
		brainSearch.setHospitalArea("2");
		List<Map<String,Object>> hospitalList3 = publicMapper.getHospitalList(brainSearch);
		request.setAttribute("hospitalList1", hospitalList1);
		request.setAttribute("hospitalList2", hospitalList2);
		request.setAttribute("hospitalList3", hospitalList3);
        
		return request;
	}
	

	@Override
	public HttpServletRequest organ_fact(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO brainSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            brainSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			brainSearch.setCurrentPage(1);
        }
        brainSearch.setBrdFileSeq(1);
        brainSearch.setBrdNo(this.faqNum);
        brainSearch.setSearchKey(request.getParameter("searchKey"));
        brainSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(brainSearch);
        brainSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(brainSearch);
        request.setAttribute("faqList", list);
        request.setAttribute("brainSearch", brainSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}



	@Override
	public HttpServletRequest infodonate(HttpServletRequest request) {
		PublicSearchVO prSearch = new PublicSearchVO();

        String year = request.getParameter("yearNow");
        String month = request.getParameter("monthNow");
        
        List<Map<String,Object>> yearList = publicMapper.getBrainDonateStatsYearList();
        request.setAttribute("yearList", yearList);
        if((year == null || "".equals(year)) && yearList != null && yearList.size() > 0) {
            year = (String)yearList.get(0).get("year");
        }
        List<Map<String,Object>> monthList = publicMapper.getBrainDonateStatsMonthList(year);
        request.setAttribute("monthList", monthList);        
        if((month == null || "".equals(month)) && monthList != null && monthList.size() > 0){
            month = (String)monthList.get(monthList.size() - 1).get("month");
        }
        
        prSearch.setYear(year);

        List<Map<String,Object>> brainMonthSumList = publicMapper.getBrainDonateStatsMonthSum(prSearch);       
        request.setAttribute("brainMonthSumList", brainMonthSumList);
        prSearch.setMonth(month);
        List<Map<String,Object>> brainList = publicMapper.getBrainDonateStats(prSearch);
        request.setAttribute("brainList", brainList);
        request.setAttribute("monthNow", month);
        request.setAttribute("yearNow", year);
        
		return request;
	}
	


	@Override
	public HttpServletRequest infotrans(HttpServletRequest request) {
		PublicSearchVO prSearch = new PublicSearchVO();

        List<Map<String,Object>> organList = publicMapper.getOrganDonateStats();        
        request.setAttribute("organList", organList);
        
        prSearch.setBrdNo(8);
        prSearch.setBrdContNo(2);
        prSearch.setBrdContRe(0);
        prSearch.setBrdFileSeq(1);
        
        List<Map<String,Object>> file = publicMapper.getFile(prSearch);
        request.setAttribute("file", file);
        
		return request;
	}

	@Override
	public HttpServletRequest infohope(HttpServletRequest request) {
		PublicSearchVO prSearch = new PublicSearchVO();

        List<Map<String,Object>> hopeList = publicMapper.getHopeDonateStats();   
        request.setAttribute("hopeList", hopeList);
        
		return request;
	}
	
	@Override
	public HttpServletRequest hire(HttpServletRequest request) {
		String currentPage = request.getParameter("currentPage");
		PublicSearchVO prSearch = new PublicSearchVO();
        if(currentPage != null && !"".equals(currentPage)){
            prSearch.setCurrentPage(Integer.parseInt(currentPage));
        }else{
			prSearch.setCurrentPage(1);
        }
        prSearch.setBrdNo(this.hireNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
        prSearch.setSearchKey(request.getParameter("searchKey"));
        prSearch.setSearchValue(request.getParameter("searchValue"));
        int totalCnt = publicMapper.getBoardCount(prSearch);
        prSearch.setTotalCount(totalCnt);
        List<Map<String,Object>> list = publicMapper.getBoardList(prSearch);
        request.setAttribute("noticeList", list);
        request.setAttribute("kodaSearch", prSearch);
        request.setAttribute("totalCount", Integer.valueOf(totalCnt));
        
		return request;
	}
	
	@Override
	public HttpServletRequest hire_view(HttpServletRequest request) {
		
		String currentPage = request.getParameter("currentPage");
        String idx = request.getParameter("idx");
		PublicSearchVO prSearch = new PublicSearchVO();
		if ((currentPage != null) && (!"".equals(currentPage))){
			prSearch.setCurrentPage(Integer.parseInt(currentPage));
		}else {
			prSearch.setCurrentPage(1);
		}
        if(idx != null && !"".equals(idx)){
            prSearch.setBrdContNo(Integer.parseInt(idx));
        }
        prSearch.setBrdFileSeq(1);
        prSearch.setBrdNo(this.hireNum);
        prSearch.setOptionStr(request.getParameter("optionStr"));
		prSearch.setSearchKey(request.getParameter("searchKey"));
		prSearch.setSearchValue(request.getParameter("searchValue"));
        request.setAttribute("kodaSearch", prSearch);
        publicMapper.updateReadNum(prSearch);
        Map<String,Object> boardContBean = publicMapper.getBoard(prSearch);
        request.setAttribute("notice", boardContBean);
        prSearch.setOptionStr("next");
        Map<String,Object> boardContBeanNext = publicMapper.getBoard(prSearch);
        request.setAttribute("noticeNext", boardContBeanNext);
        prSearch.setOptionStr("prev");
        Map<String,Object> boardContBeanPrev = publicMapper.getBoard(prSearch);
        request.setAttribute("noticePrev", boardContBeanPrev);
        
		return request;

	}

}
