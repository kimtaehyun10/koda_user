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
package com.koticobui.dfmc.client.pub.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koticobui.dfmc.client.pub.service.PublicService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;

/**
 * The type Public controller.
 */
@Controller
public class PublicController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "publicService")
    private PublicService publicService;
    
    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    /**
	 * Select parking intro list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/pub/selectParkingIntroList.json")
	@ResponseBody
	public Map<String, Object> selectParkingIntroList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Map<String, Object> list = publicService.selectParkingIntroList(requestMap);
		return list;
	}
    
    /**
	 * Select section list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/pub/selectSectionList.json")
	@ResponseBody
	public Map<String, Object> selectSectionList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		//LOGGER.debug(this.getClass().getName());
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		Map<String, Object> list = publicService.selectSectionList(requestMap);
		return list;
	}
	
	/**
     * Save request map.
     *
     * @param requestMap the request map
     * @return the map
     */
	@RequestMapping(value = "/pub/saveRequest.json")
	@ResponseBody
    public Map saveRequest(@RequestParam Map<String, Object> requestMap) {
		
        Map result = new HashMap();
        try {
        	publicService.saveRequest(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        return result;
    }
	
	/**
	 * Select standby list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/pub/selectStandbyMe.json")
	@ResponseBody
	public Map<String, Object> selectStandbyMe(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = publicService.selectStandbyMe(requestMap);
		return list;
	}

	@RequestMapping(value = "/pub/selectStandbyMax.json")
	@ResponseBody
	public Map<String, String> selectStandbyMax(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Map<String, String> result = publicService.selectStandbyMax(requestMap);
		return result;
	}
	
	@RequestMapping(value = "/pub/selectStandbyMyList.json")
	@ResponseBody
	public Map<String, Object> selectStandbyMyList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);

		Map<String, Object> list = publicService.selectStandbyMyList(requestMap);
		return list;
	}
	
	@RequestMapping(value = "/pub/selectAssignList.xml")
	public String selectAssignList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		List<Map<String, Object>> list = publicService.selectAssignList(requestMap);
		System.out.println("list값은?!!!!!!"+list);
		model.addAttribute("list",list);
		
		return "xml/selectAssignList";
	}
	
	
    
	
}
