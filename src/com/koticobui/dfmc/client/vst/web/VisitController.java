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
package com.koticobui.dfmc.client.vst.web;

import java.util.HashMap;
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

import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;
import com.koticobui.dfmc.client.vst.service.VisitService;

/**
 * The type Visit controller.
 */
@Controller
public class VisitController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "visitService")
    private VisitService visitService;
    
    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    
    /**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/vst/selectCarList.json")
	@ResponseBody
	public Map<String, Object> selectCarList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = visitService.selectCarList(requestMap);
		return list;
	}
    
    /**
	 * Select division list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/vst/selectDivisionList.json")
	@ResponseBody
	public Map<String, Object> selectDivisionList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Map<String, Object> list = visitService.selectBlockList(requestMap);
		return list;
	}
    
    /**
     * Save request map.
     *
     * @param requestMap the request map
     * @return the map
     */
	@RequestMapping(value = "/vst/saveRequest.json")
	@ResponseBody
    public Map saveRequest(@RequestParam Map<String, Object> requestMap) {
		
        Map result = new HashMap();
        try {
        	visitService.saveRequest(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        return result;
    }
    
}
