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
    
    /**
     * Mber id dupl check int.
     *
     * @param requestMap the request map
     * @param request    the request
     * @param model      the model
     * @return the int
     * @throws Exception the exception
     */
    @RequestMapping(value = "/mem/mberIdDuplCheck.json")
    @ResponseBody
    public int mberIdDuplCheck(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.mberIdDuplCheck(requestMap);
        return result;
    }
    
    @RequestMapping(value = "/mem/carNumberDupCheck.json")
    @ResponseBody
    public int carNumberDupCheck(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

        int result = memberService.carNumberDupCheck(requestMap);
        return result;
    }

    /**
     * Save member map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mem/saveMember.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> saveMember(@RequestParam Map<String, Object> requestMap, DiscountItemVO discountItemVO) {
        
        Map result = new HashMap();
        
        try {
        	memberService.saveMember(requestMap, discountItemVO);
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
    @RequestMapping(value = "/mem/findPassword.json")
    @ResponseBody
    public Map<String, Object> findPassword(@RequestParam Map<String, Object> requestMap) {
        
    	Map<String, Object> result = memberService.findPassword(requestMap);
		
	 	return result;
    }
    
}
