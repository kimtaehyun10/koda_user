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
package com.koticobui.dfmc.client.mem.web;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koticobui.dfmc.client.mem.model.DiscountItemVO;
import com.koticobui.dfmc.client.mem.service.MemberService;

/**
 * The type Member controller.
 */
@Controller
public class MemberController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "memberService")
    private MemberService memberService;

    //로그인
  	@RequestMapping(value = "/mem/memLogin.l")
      public String login(HttpServletRequest request, ModelMap model) throws Exception {
  		
  		return "let/mem/memLogin";
      }
  	
  	//회원가입 Step1
  	@RequestMapping(value = "/mem/memJoin1.l")
  	public String memJoin1(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin1";
  	}
  	
  	//회원가입 Step2
  	@RequestMapping(value = "/mem/memJoin2.l")
  	public String memJoin2(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin2";
  	}

  	//회원가입 Step3
  	@RequestMapping(value = "/mem/memJoin3.l")
  	public String memJoin3(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin3";
  	}
  	
  	//회원가입 Step4
  	@RequestMapping(value = "/mem/memJoin4.l")
  	public String memJoin4(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin4";
  	}
  	
  	//회원가입 Step5
  	@RequestMapping(value = "/mem/memJoin5.l")
  	public String memJoin5(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin5";
  	}
  	
  	//회원가입 Step6
  	@RequestMapping(value = "/mem/memJoin6.l")
  	public String memJoin6(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/memJoin6";
  	}  	

  	//아이디찾기
  	@RequestMapping(value = "/mem/findid.l")
  	public String findId(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/findid";
  	}
  	
  	//비밀번호 찾기
  	@RequestMapping(value = "/mem/findPw.l")
  	public String findPw(HttpServletRequest request, ModelMap model) throws Exception {
  			
  		return "let/mem/findPw";
  	}

    //koda사용
    //비밀번호 확인
    @RequestMapping(value = "/mem/chkPassword.json")
    @ResponseBody
    public int chkPassword(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.chkPassword(requestMap);
        return result;
    }
    

    /**
     * Save member map.
     *
     * @param requestMap the request map
     * @return the map
     */
    //koda사용
    @RequestMapping(value = "/mem/saveMember.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> saveMember(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        try {
        	memberService.saveMember(requestMap);
        	result.put("id",(String)requestMap.get("id"));
        	result.put("name",(String)requestMap.get("name"));
        	result.put("nick_name",(String)requestMap.get("nick_name"));
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    /**
	 * find member id.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
    @RequestMapping(value = "/mem/findMemberId.json")
    @ResponseBody
    public Map<String, Object> findMemberId(@RequestParam Map<String, Object> requestMap) {
        
    	Map<String, Object> result = memberService.findMemberId(requestMap);
		
	 	return result;
    }

    /**
	 * find password.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
    @RequestMapping(value = "/mem/updatePw.json")
    @ResponseBody
    public Map<String, Object> updatePw(@RequestParam Map<String, Object> requestMap) {
        
    	Map result = new HashMap();
        int updateresult = 0;
        try {
        	updateresult = memberService.updatePw(requestMap);
        	
        	if (updateresult == 1) {
                result.put("result", "OK");
        	}else {
                result.put("result", "FAIL");	
        	}
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
	 	return result;
    }
    
    //koda사용
    @RequestMapping(value = "/mem/mberIdDuplCheck.json", method = RequestMethod.POST)
    @ResponseBody
    public int mberIdDuplCheck(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.mberIdDuplCheck(requestMap);
        return result;
    }
    

    //koda사용
    @RequestMapping(value = "/mem/mberNickNameDuplCheck.json", method = RequestMethod.POST)
    @ResponseBody
    public int mberNickNameDuplCheck(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.mberNickNameDuplCheck(requestMap);
        return result;
    }
    
    ////////////////////////////////
    
    
    /**
     * Search use member int.
     *
     * @param requestMap the request map
     * @param request    the request
     * @param model      the model
     * @return the int
     * @throws Exception the exception
     */
    @RequestMapping(value = "/mem/searchUseMember.json")
    @ResponseBody
    public int searchUseMember(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.searchUseMember(requestMap);
        return result;
    }
    
     
    @RequestMapping(value = "/mem/carNumberDupCheck.json")
    @ResponseBody
    public int carNumberDupCheck(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.carNumberDupCheck(requestMap);
        return result;
    }
    
    
}
