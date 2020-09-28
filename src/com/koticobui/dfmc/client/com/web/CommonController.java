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
package com.koticobui.dfmc.client.com.web;

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

import com.koticobui.dfmc.client.com.service.CommonService;
import com.koticobui.dfmc.client.com.util.SessionService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;

/**
 * The type Common controller.
 */
@Controller
public class CommonController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "commonService")
    private CommonService commonService;

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    @Resource(name = "sessionService")
    private SessionService service;
    
    /**
	 * Code master map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mis/tax/codeMaster.json")
	@ResponseBody
	public Map<String, Object> codeMaster(@RequestParam Map<String, Object> requestMap) throws Exception {
		Map<String, Object> list = commonService.selectCodeMaster(requestMap);
		return list;
	}
	
    /**
	 * Search discount item list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchDiscountItemList.json")
	@ResponseBody
	public Map<String, Object> searchDiscountItemList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
	 	Map<String, Object> list = commonService.searchDiscountItemList(requestMap);
	 	return list;
	}
	
	/**
	 * Search use discount item list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchUseDiscountItemList.json")
	@ResponseBody
	public Map<String, Object> searchUseDiscountItemList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		requestMap.put("esntlId", esntlId);
				
	 	Map<String, Object> list = commonService.searchUseDiscountItemList(requestMap);
	 	return list;
	}
    
	/**
	 * Search res section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchResSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResSectionCombo(requestMap);
		
		return list;
	}
	
	/**
	 * Search res block combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResBlockCombo.json")
	@ResponseBody
	public Map<String, Object> searchResBlockCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResBlockCombo(requestMap);
		return list;
	}
	
	/**
	 * Search res division combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchResDivisionCombo.json")
	@ResponseBody
	public Map<String, Object> searchResDivisionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchResDivisionCombo(requestMap);
		return list;
	}
	
	/**
	 * Select car list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/selectCarList.json")
	@ResponseBody
	public Map<String, Object> selectCarList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = commonService.selectCarList(requestMap);
		
		
		return list;
	}
	
	/**
	 * Search vst manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstManageZoneCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstManageZoneCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstManageZoneCombo(requestMap);
		return list;
	}
	
	/**
	 * 환불 사유
	 * @param requestMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/searchRefundCodeCombo.json")
	@ResponseBody
	public Map<String, Object> searchRefundCodeCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchRefundCodeCombo(requestMap);
		return list;
	}

	/**
	 * 은행 목록
	 * @param requestMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/com/searchBankCodeCombo.json")
	@ResponseBody
	public Map<String, Object> searchBankCodeCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchBankCodeCombo(requestMap);
		return list;
	}

	/**
	 * Search vst section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstSectionCombo(requestMap);
		return list;
	}
	
	/**
	 * Search vst block combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstBlockCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstBlockCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstBlockCombo(requestMap);
		return list;
	}
	
	/**
	 * Search vst division combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchVstDivisionCombo.json")
	@ResponseBody
	public Map<String, Object> searchVstDivisionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchVstDivisionCombo(requestMap);
		return list;
	}
	
	/**
	 * Search pub manage zone combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchPubManageZoneCombo.json")
	@ResponseBody
	public Map<String, Object> searchPubManageZoneCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchPubManageZoneCombo(requestMap);
		return list;
	}
	
	/**
	 * Search pub section combo map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchPubSectionCombo.json")
	@ResponseBody
	public Map<String, Object> searchPubSectionCombo(@RequestParam Map<String, Object> requestMap, HttpServletRequest request) throws Exception {
		
		Map<String, Object> list = commonService.searchPubSectionCombo(requestMap);
		return list;
	}
    
	/**
	 * Select park map list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/com/searchParkMap.json")
	@ResponseBody
	public Map<String, Object> searchParkMap(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Map<String, Object> list = commonService.searchParkMap(requestMap);
		return list;
	}
	
	@RequestMapping(value = "/com/selectSession.json")
	@ResponseBody
	public Map<String, Object> selectSession(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {

//		SessionService service = new SessionService();
		@SuppressWarnings("unchecked")
		Map<String, Object> result = service.selectSession(requestMap.get("session").toString());
		
		return result;
	}
}
