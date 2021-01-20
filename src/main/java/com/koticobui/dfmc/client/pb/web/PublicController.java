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
package com.koticobui.dfmc.client.pb.web;

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

import com.koticobui.dfmc.client.com.service.CommonService;
import com.koticobui.dfmc.client.let.model.LetterVO;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.mem.service.MemberService;
import com.koticobui.dfmc.client.pb.service.PublicService;

/**
 * The type Letter controller.
 */
@Controller
public class PublicController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "publicService")
    private PublicService publicService;
    
    @Resource(name = "commonService")
    private CommonService commonService;

    //연보
	@RequestMapping(value = "/pr/annual.c", method = RequestMethod.POST)
    public String annual( 
			  @RequestParam("menuCd") String menuCd
			, @RequestParam("seqCd1") String seqCd1
			, @RequestParam("seqCd2") String seqCd2
			, HttpServletRequest request)
    	    throws Exception
    	  {
			Map requestMap = new HashMap<String, Object>();
			requestMap.put("menuCd", menuCd);
			requestMap.put("seqCd1", seqCd1);
			requestMap.put("seqCd2", seqCd2);
			
    	    publicService.annual(request);

    		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
    			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

    		    request.setAttribute("mlist", mlist);
    		}

    	    request.setAttribute("menuCd", menuCd);
    	    request.setAttribute("seqCd1", seqCd1);
    	    request.setAttribute("seqCd2", seqCd2);

    	    return "pr/annualbook";
    	  }
	

    //ebook 호출
	@RequestMapping(value = "/pr/eBook.pop")
    public String eBook( 
			  @RequestParam("num") String num
			, @RequestParam("idx") String idx
			, HttpServletRequest request)
    	    throws Exception
    	  {
			
    	    publicService.eBook(request);

    	    return "pr/eBook_pop";
    	  }
	
	//뉴스레터
	@RequestMapping(value = "/pr/news_letter.c", method = RequestMethod.POST)
	public String news_Letter( 
			  @RequestParam("menuCd") String menuCd
			, @RequestParam("seqCd1") String seqCd1
			, @RequestParam("seqCd2") String seqCd2
			, HttpServletRequest request)
		    throws Exception
		  {
			Map requestMap = new HashMap<String, Object>();
			requestMap.put("menuCd", menuCd);
			requestMap.put("seqCd1", seqCd1);
			requestMap.put("seqCd2", seqCd2);
			
		    publicService.news_Letter(request);

			if (menuCd != null || seqCd1 != null || seqCd2 != null) {
				List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

			    request.setAttribute("mlist", mlist);
			}

		    request.setAttribute("menuCd", menuCd);
		    request.setAttribute("seqCd1", seqCd1);
		    request.setAttribute("seqCd2", seqCd2);

		    return "pr/newsletter";
		  }
	
	//사례집
	@RequestMapping(value = "/pr/casebook.c", method = RequestMethod.POST)
	public String casebook(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.casebook(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/casebook";
	}
	
	//동영상 게시판
	@RequestMapping(value = "/pr/movie.c", method = RequestMethod.POST)
	public String movie(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.movie(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/video";
	}

	//동영상 게시판_뷰
	@RequestMapping(value = "/pr/movie_view.c", method = RequestMethod.POST)
	public String movie_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.movie_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/video_view";
	}
	
	//웹컨텐츠 게시판
	@RequestMapping(value = "/pr/webcontents.c", method = RequestMethod.POST)
	public String web_contents(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.web_contents(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/webcontents";
	}

	//웹컨텐츠 게시판_뷰
	@RequestMapping(value = "/pr/webcontents_view.c", method = RequestMethod.POST)
	public String webcontents_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.web_contents_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/webcontents_view";
	}

	//생명나눔 스토리 게시판
	@RequestMapping(value = "/pr/lifeSharing.c", method = RequestMethod.POST)
	public String lifeSharing(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.lifeSharing(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/lifestory";
	}
	
	//생명나눔 스토리 게시판_뷰
	@RequestMapping(value = "/pr/lifeSharing_view.c", method = RequestMethod.POST)
	public String lifeSharing_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.lifeSharing_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/lifestory_view";
	}
	

	//보도자료 게시판
	@RequestMapping(value = "/pr/pressRelease.c", method = RequestMethod.POST)
	public String pressRelease(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.pressRelease(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/pressRelease";
	}
	
	//보도자료 게시판_뷰
	@RequestMapping(value = "/pr/pressRelease_view.c", method = RequestMethod.POST)
	public String pressRelease_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.pressRelease_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/pressRelease_view";
	}
	
	//공지사항 게시판
	@RequestMapping(value = "/pr/notice.c", method = RequestMethod.POST)
	public String notice(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.notice(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/notice";
	}

	//공지사항 게시판_뷰
	@RequestMapping(value = "/pr/notice_view.c", method = RequestMethod.POST)
	public String notice_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.notice_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/notice_view";
	}
	

	//기관소식 게시판
	@RequestMapping(value = "/pr/comnews.c", method = RequestMethod.POST)
	public String organEvent(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comnews(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/comnews";
	}

	//기관소식 게시판 뷰
	@RequestMapping(value = "/pr/comnews_view.c", method = RequestMethod.POST)
	public String organEvent_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comnews_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/comnews_view";
	}
	

	//사전공표 게시판
	@RequestMapping(value = "/info/infobefore.c", method = RequestMethod.POST)
	public String infobefore(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infobefore(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infobefore";
	}

	//사전공표 게시판 뷰
	@RequestMapping(value = "/info/infobefore_view.c", method = RequestMethod.POST)
	public String infobefore_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infobefore_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infobefore_view";
	}

	//공공데이터 게시판
	@RequestMapping(value = "/info/infodata.c", method = RequestMethod.POST)
	public String infodata(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infodata(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infodata";
	}

	//공공데이터 게시판 뷰
	@RequestMapping(value = "/info/infodata_view.c", method = RequestMethod.POST)
	public String infodata_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infodata_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infodata_view";
	}

	//법률, 학술 게시판
	@RequestMapping(value = "/info/infolaw.c", method = RequestMethod.POST)
	public String infolaw(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infolaw(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infolaw";
	}

	//법률, 학술 게시판 뷰
	@RequestMapping(value = "/info/infolaw_view.c", method = RequestMethod.POST)
	public String infolaw_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infolaw_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "info/infolaw_view";
	}
	
	//공지사항 게시판
	@RequestMapping(value = "/com/comrecruit.c", method = RequestMethod.POST)
	public String comrecruit(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comrecruit(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "com/comrecruit";
	}

	//공지사항 게시판_뷰
	@RequestMapping(value = "/com/comrecruit_view.c", method = RequestMethod.POST)
	public String comrecruit_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comrecruit_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "com/comrecruit_view";
	}
	
	//인권경영 게시판
	@RequestMapping(value = "/com/comhuman.c", method = RequestMethod.POST)
	public String comhuman(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comhuman(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "com/comhuman3";
	}

	//인권경영 게시판_뷰
	@RequestMapping(value = "/com/comhuman_view.c", method = RequestMethod.POST)
	public String comhuman_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.comhuman_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "com/comhuman3_view";
	}
	
	//뇌사판정 의료 기관 현황
	@RequestMapping(value = "/organ/organ_agree1.c", method = RequestMethod.POST)
	public String organ_agree1(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.organ_agree1(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/organ/organ_agree1";
	}

	//DIP 협약 기관 현황
	@RequestMapping(value = "/organ/organ_agree2.c", method = RequestMethod.POST)
	public String organ_agree2(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.organ_agree2(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/organ/organ_agree2";
	}
	
	//인권경영 게시판
	@RequestMapping(value = "/organ/organ_fact.c", method = RequestMethod.POST)
	public String organ_fact(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.organ_fact(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/organ/organ_fact";
	}
	
	//기증현황
	@RequestMapping(value = "/info/infodonate.c", method = RequestMethod.POST)
	public String infodonate(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infodonate(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/info/infodonate";
	}
	

	//이식현황
	@RequestMapping(value = "/info/infotrans.c", method = RequestMethod.POST)
	public String infotrans(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infotrans(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/info/infotrans";
	}


	//기증희망현황
	@RequestMapping(value = "/info/infohope.c", method = RequestMethod.POST)
	public String infohope(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.infohope(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "/info/infohope";
	}
	
	//채용 게시판
	@RequestMapping(value = "/pr/hire.c", method = RequestMethod.POST)
	public String hire(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.hire(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/hire";
	}
	
	//채용 게시판_뷰
	@RequestMapping(value = "/pr/hire_view.c", method = RequestMethod.POST)
	public String hire_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		publicService.hire_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "pr/hire_view";
	}
}

