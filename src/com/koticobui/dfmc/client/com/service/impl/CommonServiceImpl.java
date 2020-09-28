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
package com.koticobui.dfmc.client.com.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.koticobui.dfmc.client.com.mapper.CommonMapper;
import com.koticobui.dfmc.client.com.service.CommonService;


/**
 * The type Common service.
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommonServiceImpl.class);

    @Resource(name = "commonMapper")
    private CommonMapper commonMapper;
    
    
    @Override
	public String genTableKey(Map requestMap) {
		String nextKeyNumber = commonMapper.genTableKey(requestMap);
		return nextKeyNumber;
	}
    
    @Override
	public Map<String, Object> selectCodeMaster(Map requestMap) {
		Map result = new HashMap<String, Object>();
		result.put("options", commonMapper.selectCodeMaster(requestMap));
		result.put("result", "ok");
		return result;
	}
    
    @Override
	public Map<String, Object> searchDiscountItemList(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("list", commonMapper.searchDiscountItemList(requestMap));
		return result;
	}
    
    @Override
	public Map<String, Object> searchUseDiscountItemList(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("list", commonMapper.searchUseDiscountItemList(requestMap));
		return result;
	}
    
    @Override
	public Map<String, Object> searchResSectionCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchResSectionCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchResBlockCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchResBlockCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchResDivisionCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchResDivisionCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> selectCarList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    result.put("list", commonMapper.selectCarList(requestMap));
	    return result;
	}
    
    @Override
	public Map<String, Object> searchVstManageZoneCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchVstManageZoneCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchRefundCodeCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchRefundCodeCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}

    @Override
	public Map<String, Object> searchBankCodeCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchBankCodeCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}

    @Override
	public Map<String, Object> searchVstSectionCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchVstSectionCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchVstBlockCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchVstBlockCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchVstDivisionCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchVstDivisionCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchPubManageZoneCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchPubManageZoneCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchPubSectionCombo(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
    	result.put("options", commonMapper.searchPubSectionCombo(requestMap));
    	result.put("result", "ok");
    	
		return result;
	}
    
    @Override
	public Map<String, Object> searchParkMap(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    result.put("list", commonMapper.searchParkMap(requestMap));
	    return result;
	}
}
