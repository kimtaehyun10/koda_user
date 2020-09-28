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
package com.koticobui.dfmc.client.sup.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.koticobui.dfmc.client.sup.mapper.SupportMapper;
import com.koticobui.dfmc.client.sup.service.SupportService;

/**
 * The type Visit service.
 */
@Service("supportService")
public class SupportServiceImpl implements SupportService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SupportServiceImpl.class);

    @Resource(name = "supportMapper")
    private SupportMapper supportMapper;
    
    
    @Override
	public Map<String, Object> selectNoticeList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    
		    Integer listCount = supportMapper.selectNoticeListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap);
	    }
	     
	    result.put("list", supportMapper.selectNoticeList(requestMap));

	    return result;
	}
    
	@Override
	public Map<String, Object> selectRegulatePaymentList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    Integer listCount = supportMapper.selectRegulatePaymentListTot(requestMap) ;
	    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
	    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
	 
	    requestMap.put("listCount", listCount ); 
	    requestMap.put("pageCount", pageCount ); 
	    requestMap.put("pageSize",  pageSize ); 
	    result.put("page", requestMap); 
	     
	    result.put("list", supportMapper.selectRegulatePaymentList(requestMap));

	    return result;
	}
	
}
