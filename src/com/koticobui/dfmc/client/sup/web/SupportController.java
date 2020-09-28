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
package com.koticobui.dfmc.client.sup.web;

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

import com.koticobui.dfmc.client.sup.service.SupportService;

/**
 * The type Support controller.
 */
@Controller
public class SupportController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "supportService")
    private SupportService supportService;
    
    
    /**
	 * Select notice list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/sup/selectNoticeList.json")
	@ResponseBody
	public Map<String, Object> selectNoticeList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		//LOGGER.debug(this.getClass().getName());
		//Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		Map<String, Object> list = supportService.selectNoticeList(requestMap);
		return list;
	}
	
	@RequestMapping(value = "/sup/selectRegulateService.json")
	@ResponseBody
	public Map<String, Object> selectRegulateService(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Map<String, Object> list = supportService.selectRegulatePaymentList(requestMap);
		return list;
	}
}
