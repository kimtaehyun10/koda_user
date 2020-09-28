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
package com.koticobui.dfmc.client.pub.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.pub.mapper.PublicMapper;
import com.koticobui.dfmc.client.pub.service.PublicService;

/**
 * The type Public service.
 */
@Service("publicService")
public class PublicServiceImpl implements PublicService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PublicServiceImpl.class);

    @Resource(name = "publicMapper")
    private PublicMapper publicMapper;
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;
    
    
    @Override
	public Map<String, Object> selectParkingIntroList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    result.put("list", publicMapper.selectParkingIntroList(requestMap));
	    return result;
	}
    
    @Override
	public Map<String, Object> selectSectionList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    Integer listCount = publicMapper.selectSectionListTot(requestMap) ;
	    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
	    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
	 
	    requestMap.put("listCount", listCount ); 
	    requestMap.put("pageCount", pageCount ); 
	    requestMap.put("pageSize",  pageSize ); 
	    result.put("page", requestMap); 
	     
	    result.put("list", publicMapper.selectSectionList(requestMap));

	    return result;
	}
    
    @Override
    @Transactional
    public void saveRequest(Map requestMap) throws Exception {
    	
    	//고객정보 update
    	String mberFlag = requestMap.get("mberFlag").toString();
    	
    	if (mberFlag.equals("00")) {
    		requestMap.put("mberFlag", "04");
    	} else if (mberFlag.equals("01")) {
    		requestMap.put("mberFlag", "05");
    	} else if (mberFlag.equals("02")) {
    		requestMap.put("mberFlag", "06");
    	} else if (mberFlag.equals("03")) {
    		requestMap.put("mberFlag", "07");
    	}
    	publicMapper.updateMberFlag(requestMap);
    	

        // 고객키, 차량키 기본 계약정보 생성
        Map contractMap = new HashMap();
        requestMap.put("contractInfoKey", generationKey.genTableKey("TB_CONTRACT_INFO", "CONTRACT_INFO_KEY"));
        requestMap.put("parkingProduct", "03");
        requestMap.put("assignStatus", "02");
        publicMapper.insertContractInfo(requestMap);

        // 계약정보 이력 생성
        requestMap.put("contractHistoryKey", generationKey.genTableKey("TB_CONTRACT_HISTORY", "CONTRACT_HISTORY_KEY"));
        publicMapper.insertContractHistory(requestMap);

        // 고객이 가지고있는 할인내역의 계약키로 생성
        List<Map> dcList = publicMapper.selectDiscountDetailNullContractKeyList(requestMap);
        if (dcList.size() > 0) {
            for (Map dcMap : dcList) {
                dcMap.put("discountDetailKey", generationKey.genTableKey("TB_DISCOUNT_DETAIL", "DISCOUNT_DETAIL_KEY"));
                dcMap.put("contractInfoKey", requestMap.get("contractInfoKey"));
                publicMapper.insertDiscountDetail(dcMap);
            }
        }

        // 계약키 기준으로 희망구역 생성
        /*
        for (Map hopeMap : (List<Map>) requestMap.get("hopeZoneArray")) {
            //hopeMap.put("hopeRequestSectionKey", hopeRequestSectionKeyGnrService.getNextStringId());
            hopeMap.put("hopeRequestSectionKey", generationKey.genTableKey("TB_HOPE_REQUEST_SECTION", "HOPE_REQUEST_SECTION_KEY"));
            hopeMap.put("contractInfoKey", requestMap.get("contractInfoKey"));
            customerManageMapper.insertHopeRequestSection(hopeMap);
        }
        */
        requestMap.put("hopeRequestSectionKey", generationKey.genTableKey("TB_HOPE_REQUEST_SECTION", "HOPE_REQUEST_SECTION_KEY"));
        requestMap.put("contractInfoKey", requestMap.get("contractInfoKey"));
        publicMapper.insertHopeRequestSection(requestMap);

        // 수납정보 생성
        requestMap.put("purchaseKey", generationKey.genTableKey("TB_QUARTER_PAYMENT", "PURCHASE_KEY"));
        requestMap.put("statCd", "04"); //수납테이블에서 어느건에 대한 데이터인지 구분코드(01:거주자, 02:부정주차, 03:방문주차, 04:월정기, 05:시간주차)
        publicMapper.insertQuarterPayment(requestMap);
    }
    
    @Override
	public Map<String, Object> selectStandbyMe(Map requestMap) {
	     
	    Map list = new HashMap<String, Object>();
	    list.put("list", publicMapper.selectStandbyMe(requestMap));
	    return list;
	}

    @Override
	public Map<String, String> selectStandbyMax(Map requestMap) {
	     
	    Map result = new HashMap<String, String>();
	    result.put("mrnum", publicMapper.selectStandbyMax(requestMap));
	    return result;
	}
    
    @Override
    public Map<String, Object> selectStandbyMyList(Map requestMap) {
    	Map result = new HashMap<String, Object>();
    	result.put("count", publicMapper.selectStandbyMyList(requestMap));
    	
    	return result;
    }

	@Override
	public List<Map<String, Object>> selectAssignList(Map<String, Object> requestMap) {
			
		return publicMapper.selectAssignList(requestMap);
	}

}
