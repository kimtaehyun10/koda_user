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
package com.koticobui.dfmc.client.donate.web;

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
import com.koticobui.dfmc.client.donate.service.DonateService;
import com.koticobui.dfmc.client.let.model.LetterVO;
import com.koticobui.dfmc.client.let.service.LetterService;
import com.koticobui.dfmc.client.mem.service.MemberService;

/**
 * The type Letter controller.
 */
@Controller
public class DonateController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "donateService")
    private DonateService donateService;
    
    @Resource(name = "commonService")
    private CommonService commonService;

    //기증자 추모관 리스트
	@RequestMapping(value = "/donate/member.c", method = RequestMethod.POST)
    public String member( 
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
			
    	    donateService.member(request);

    		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
    			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

    		    request.setAttribute("mlist", mlist);
    		}

    	    request.setAttribute("menuCd", menuCd);
    	    request.setAttribute("seqCd1", seqCd1);
    	    request.setAttribute("seqCd2", seqCd2);

    	    return "donate/donate_member";
    	  }
	
	
	//기증자 추모관 뷰
	@RequestMapping(value = "/donate/member_view.c", method = RequestMethod.POST)
	public String member_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		donateService.member_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "donate/donate_mem_view";
	}
	
	//이모티콘 클릭
    @RequestMapping(value = "/donate/member_like_update.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> member_like_update(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.member_like_update(request);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }    
    
    //댓글 등록
    @RequestMapping(value = "/donate/member_com_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> member_com_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	donateService.member_com_insert(request);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }    
    
    //하늘나라 편지함
  	@RequestMapping(value = "/donate/letter.c", method = RequestMethod.POST)
      public String letter( 
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
  			
      	    donateService.letter(request);

      		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
      			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

      		    request.setAttribute("mlist", mlist);
      		}

      	    request.setAttribute("menuCd", menuCd);
      	    request.setAttribute("seqCd1", seqCd1);
      	    request.setAttribute("seqCd2", seqCd2);

      	    return "donate/donate_letter";
      	  }
  	
  	//하늘나라 편지 뷰
  	@RequestMapping(value = "/donate/letter_view.c", method = RequestMethod.POST)
  	public String letter_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
  			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
  		Map requestMap = new HashMap<String, Object>();
  		requestMap.put("menuCd", menuCd);
  		requestMap.put("seqCd1", seqCd1);
  		requestMap.put("seqCd2", seqCd2);

  		donateService.letter_view(request);

  		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
  			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

  			request.setAttribute("mlist", mlist);
  		}

  		request.setAttribute("menuCd", menuCd);
  		request.setAttribute("seqCd1", seqCd1);
  		request.setAttribute("seqCd2", seqCd2);

  		return "donate/donate_letter_view";
  	}
  	
  	//하늘나라 편지 댓글 등록
    @RequestMapping(value = "/donate/letter_com_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> letter_com_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	donateService.letter_com_insert(request);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  
    
    //하늘나라 편지, 수혜자편지, 기증 후 스토리 패스워드 확인 수정,삭제,댓글삭제
    @RequestMapping(value = "/donate/pwd_action.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> pwd_action(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.pwd_action(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  
    
    //하늘나라 편지 작성/수정 화면
  	@RequestMapping(value = "/donate/letter_form.c", method = RequestMethod.POST)
  	public String letter_form(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
  			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
  		Map requestMap = new HashMap<String, Object>();
  		requestMap.put("menuCd", menuCd);
  		requestMap.put("seqCd1", seqCd1);
  		requestMap.put("seqCd2", seqCd2);

  		donateService.letter_form(request);

  		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
  			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

  			request.setAttribute("mlist", mlist);
  		}

  		request.setAttribute("menuCd", menuCd);
  		request.setAttribute("seqCd1", seqCd1);
  		request.setAttribute("seqCd2", seqCd2);

  		return "donate/donate_letter_write";
  	}
  	
  	//하늘나라 편지 저장
    @RequestMapping(value = "/donate/letter_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> letter_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.letter_insert(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  
    
    //하늘나라 편지 수정
    @RequestMapping(value = "/donate/letter_update.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> letter_update(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.letter_update(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    //하늘나라 편지 삭제
    @RequestMapping(value = "/donate/letter_delete.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> letter_delete(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.letter_delete(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
    
    //////////////////////
    
   //수혜자 편지함
  	@RequestMapping(value = "/donate/receipt.c", method = RequestMethod.POST)
      public String receipt( 
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
  			
      	    donateService.receipt(request);

      		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
      			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

      		    request.setAttribute("mlist", mlist);
      		}

      	    request.setAttribute("menuCd", menuCd);
      	    request.setAttribute("seqCd1", seqCd1);
      	    request.setAttribute("seqCd2", seqCd2);

      	    return "donate/donate_receipt";
      	  }
  	
  	//수혜자 편지 뷰
  	@RequestMapping(value = "/donate/receipt_view.c", method = RequestMethod.POST)
  	public String receipt_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
  			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
  		Map requestMap = new HashMap<String, Object>();
  		requestMap.put("menuCd", menuCd);
  		requestMap.put("seqCd1", seqCd1);
  		requestMap.put("seqCd2", seqCd2);

  		donateService.receipt_view(request);

  		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
  			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

  			request.setAttribute("mlist", mlist);
  		}

  		request.setAttribute("menuCd", menuCd);
  		request.setAttribute("seqCd1", seqCd1);
  		request.setAttribute("seqCd2", seqCd2);

  		return "donate/donate_receipt_view";
  	}
  	
  	//수혜자편지 댓글 등록
    @RequestMapping(value = "/donate/receipt_com_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> receipt_com_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	donateService.receipt_com_insert(request);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  
    
    //수혜자 편지 작성/수정 화면
  	@RequestMapping(value = "/donate/receipt_form.c", method = RequestMethod.POST)
  	public String receipt_form(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
  			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
  		Map requestMap = new HashMap<String, Object>();
  		requestMap.put("menuCd", menuCd);
  		requestMap.put("seqCd1", seqCd1);
  		requestMap.put("seqCd2", seqCd2);

  		donateService.receipt_form(request);

  		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
  			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

  			request.setAttribute("mlist", mlist);
  		}

  		request.setAttribute("menuCd", menuCd);
  		request.setAttribute("seqCd1", seqCd1);
  		request.setAttribute("seqCd2", seqCd2);

  		return "donate/donate_receipt_write";
  	}
  	
  	//수혜자 편지 저장
    @RequestMapping(value = "/donate/receipt_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> receipt_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.receipt_insert(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  
    
    //수혜자 편지 수정
    @RequestMapping(value = "/donate/receipt_update.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> receipt_update(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.receipt_update(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    //수혜자 편지 삭제
    @RequestMapping(value = "/donate/receipt_delete.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> receipt_delete(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.receipt_delete(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
    
    ///////////////////////////

    //기증후스토리
  	@RequestMapping(value = "/donate/story.c", method = RequestMethod.POST)
      public String story( 
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
  			
      	    donateService.story(request);

      		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
      			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

      		    request.setAttribute("mlist", mlist);
      		}

      	    request.setAttribute("menuCd", menuCd);
      	    request.setAttribute("seqCd1", seqCd1);
      	    request.setAttribute("seqCd2", seqCd2);

      	    return "donate/donate_story";
      	  }
  	

	//기증자 스토리 뷰
	@RequestMapping(value = "/donate/story_view.c", method = RequestMethod.POST)
	public String story_view(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);

		donateService.story_view(request);

		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

			request.setAttribute("mlist", mlist);
		}

		request.setAttribute("menuCd", menuCd);
		request.setAttribute("seqCd1", seqCd1);
		request.setAttribute("seqCd2", seqCd2);

		return "donate/donate_story_view";
	}
	
	//기증자 스토리 댓글 등록
    @RequestMapping(value = "/donate/story_com_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> story_com_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	donateService.story_com_insert(request);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    //기증자 스토리 작성/수정 화면
  	@RequestMapping(value = "/donate/story_form.c", method = RequestMethod.POST)
  	public String story_form(@RequestParam("menuCd") String menuCd, @RequestParam("seqCd1") String seqCd1,
  			@RequestParam("seqCd2") String seqCd2, HttpServletRequest request) throws Exception {
  		Map requestMap = new HashMap<String, Object>();
  		requestMap.put("menuCd", menuCd);
  		requestMap.put("seqCd1", seqCd1);
  		requestMap.put("seqCd2", seqCd2);

  		donateService.story_form(request);

  		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
  			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);

  			request.setAttribute("mlist", mlist);
  		}

  		request.setAttribute("menuCd", menuCd);
  		request.setAttribute("seqCd1", seqCd1);
  		request.setAttribute("seqCd2", seqCd2);

  		return "donate/donate_story_write";
  	}
  	
  	//기증후 스토리 입력
    @RequestMapping(value = "/donate/story_insert.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> story_insert(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.story_insert(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }  

    //기증 후 스토리 수정
    @RequestMapping(value = "/donate/story_update.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> story_update(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.story_update(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
    

    //기증 후 스토리 삭제
    @RequestMapping(value = "/donate/story_delete.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> story_delete(HttpServletRequest request) {
        
        Map result = new HashMap();
        
        try {
        	result = donateService.story_delete(request);
            //result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

}

