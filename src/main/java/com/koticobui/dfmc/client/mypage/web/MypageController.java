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
package com.koticobui.dfmc.client.mypage.web;

import java.util.ArrayList;
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

import com.koticobui.dfmc.client.mypage.model.DiscountItemVO;
import com.koticobui.dfmc.client.mypage.service.MypageService;
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;

/**
 * The type Mypage controller.
 */
@Controller
public class MypageController {

    private static final Logger logger = LogManager.getLogger();

    @Resource(name = "mypageService")
    private MypageService mypageService;
    
    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    
    /**
	 * Select contract list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mypage/selectContractList.json")
	@ResponseBody
	public Map<String, Object> selectContractList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = mypageService.selectContractList(requestMap);
		return list;
	}
    
	/**
	 * Select payment list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mypage/selectPaymentList.json")
	@ResponseBody
	public Map<String, Object> selectPaymentList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
				
		Map<String, Object> list = mypageService.selectPaymentList(requestMap);
		return list;
	}
    
	/**
	 * Select regulate payment list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mypage/selectRegulatePaymentList.json")
	@ResponseBody
	public Map<String, Object> selectRegulatePaymentList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		
		Map<String, Object> list = mypageService.selectRegulatePaymentList(requestMap);
		return list;
	}
	
	@RequestMapping(value = "/mypage/selectRequestRefund.json")
	@ResponseBody
	public Map<String, Object> selectRequestRefund(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("searchEsntlId", esntlId);
		
		Map<String, Object> list = mypageService.selectRequestRefund(requestMap);
		return list;
	}

	/**
     * Save member map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mypage/confirmPassword.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> confirmPassword(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
        int resultCnt = mypageService.confirmPassword(requestMap);
        
        if(resultCnt > 0){
        	result.put("result", "OK");
        }else{
        	result.put("result", "FAIL");
        }
        
        return result;
    }
    
    @RequestMapping(value = "/mypage/refundRequest.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> refundRequest(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        int resultCnt = mypageService.refundRequest(requestMap);
        
        if(resultCnt > 0){
        	result.put("result", "OK");
        }else{
        	result.put("result", "FAIL");
        }
        
        return result;
    }

    /**
     * 나의주차정보>주차장계약/결제>방문주차권 출력
     * @param requestMap
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/mypage/printVisitLabel.jiro")
    public String printVisitLabel(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
		String value = requestMap.get("printValue").toString();
		String[] temp = value.split("/");
		requestMap.put("purchaseKey", temp[0]);
		requestMap.put("esntlId", temp[1]);
		Map<String, Object> list = mypageService.selectContractList(requestMap);
    	model.addAttribute("list", list.get("list"));

    	return "mypage/printVisitLabel";
    }
    
    
    /**
	 * Search member info.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
    @RequestMapping(value = "/mypage/searchMemberInfo.json")
    @ResponseBody
    public Map<String, Object> searchMemberInfo(@RequestParam Map<String, Object> requestMap) {
        
    	Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
      	Map<String, Object> result = mypageService.searchMemberInfo(requestMap);
		
	 	return result;
    }
    
    /**
     * Update member map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mypage/updateMember.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> updateMember(@RequestParam Map<String, Object> requestMap, DiscountItemVO discountItemVO) {
        
        Map result = new HashMap();
        
        Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
        try {
        	mypageService.updateMember(requestMap, discountItemVO);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
	
    /**
     * Member out map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mypage/memberOut.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> memberOut(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
        try {
        	mypageService.memberOut(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
    
    /**
     * Member out map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mypage/memberStatus.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> memberStatus(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
        try {
        	Map status = mypageService.selectMemberStatus(requestMap);
        	Map list = (Map)status.get("list");
        	int count = 0;
        	
        	if (list != null) {
        		count = Integer.parseInt(list.get("assignedCount").toString());
        	}
        	
        	if (count > 0) {
        		result.put("result", "ASSIGNED");
        	} else {
        		result.put("result", "OK");
        	}
            
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }

    /**
	 * Select standby status list map.
	 *
	 * @param requestMap the request map
	 * @param request    the request
	 * @param model      the model
	 * @return the map
	 * @throws Exception the exception
	 */
	@RequestMapping(value = "/mypage/selectStandbyStatusList.json")
	@ResponseBody
	public Map<String, Object> selectStandbyStatusList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = mypageService.selectStandbyStatusList(requestMap);
		return list;
	}
	
	@RequestMapping(value = "/mypage/selectPPStandbyList.json")
	@ResponseBody
	public Map<String, Object> selectPPStandbyList(@RequestParam Map<String, Object> requestMap, HttpServletRequest request, ModelMap model) throws Exception {
	       
		Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();		
		requestMap.put("esntlId", esntlId);
		
		Map<String, Object> list = mypageService.selectStandbyStatusList(requestMap);
		return list;
	}

	/**
     * Cancel request map.
     *
     * @param requestMap the request map
     * @return the map
     */
    @RequestMapping(value = "/mypage/cancelRequest.json", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Objects> cancelRequest(@RequestParam Map<String, Object> requestMap) {
        
        Map result = new HashMap();
        
        Customer customer = authenticationService.getCustomer();
		String esntlId = customer.getEsntlId();
		
		requestMap.put("esntlId", esntlId);
        
        try {
        	mypageService.cancelRequest(requestMap);
            result.put("result", "OK");
        } catch (Exception e) {
            logger.error(e.getMessage());
            result.put("result", "FAIL");
        }
        
        return result;
    }
	
    
    
    
    
    
    
    
    
    
    
	/**
	 * savePay map.
	 *
	 * @param requestMap the request map
	 * @return the map
	 */
    /*
	@RequestMapping(value = "/mypage/savePay.json", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Objects> savePay(@RequestParam  Map requestMap) {
		Map result = new HashMap();
    	System.out.println("requestMap:{}" + requestMap.toString());
    	//LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	try {
    		System.out.println("map.size=" + requestMap.size());
    		MypageService mypageSvc = new MypageServiceImpl();
    		int resultCode = mypageSvc.savePay(requestMap);
    		System.out.println("resultCode:"+resultCode);
    		if(resultCode == 1) {
    			result.put("result", "OK");
    		} else {
    			result.put("result", "FAIL-Rtn0");
    		}
	    } catch (Exception e) {
	        logger.error(e.getMessage());
	        e.printStackTrace();
	        result.put("result", "FAIL");
	    }
	    return result;
    }
	*/
    
}
