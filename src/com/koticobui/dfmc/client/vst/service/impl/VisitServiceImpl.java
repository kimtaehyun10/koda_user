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
package com.koticobui.dfmc.client.vst.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.vst.mapper.VisitMapper;
import com.koticobui.dfmc.client.vst.service.VisitService;

/**
 * The type Visit service.
 */
@Service("visitService")
public class VisitServiceImpl implements VisitService {

    private static final Logger LOGGER = LoggerFactory.getLogger(VisitServiceImpl.class);

    @Resource(name = "visitMapper")
    private VisitMapper visitMapper;
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;
    
    
    @Override
	public Map<String, Object> selectCarList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    result.put("list", visitMapper.selectCarList(requestMap));
	    return result;
	}
    
    @Override
	public Map<String, Object> selectDivisionList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    	Integer listCount = visitMapper.selectDivisionListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap); 
	    }
	     
	    result.put("list", visitMapper.selectDivisionList(requestMap));

	    return result;
	}
    
    @Override
	public Map<String, Object> selectBlockList(Map requestMap) {
	     
	    Map result = new HashMap<String, Object>();
	    
	    String mobileYn = (String) requestMap.get("mobileYn");
	    
	    if(!"Y".equals(mobileYn)){
	    	Integer listCount = visitMapper.selectBlockListTot(requestMap) ;
		    int pageSize = requestMap.get("pageSize") == null ? 10 : requestMap.get("pageSize").equals("") ? 10 : Integer.parseInt((String)requestMap.get("pageSize"));
		    int pageCount = listCount % pageSize > 0 ? listCount/pageSize+1:listCount/pageSize;
		 
		    requestMap.put("listCount", listCount ); 
		    requestMap.put("pageCount", pageCount ); 
		    requestMap.put("pageSize",  pageSize ); 
		    result.put("page", requestMap); 
	    }
	     
	    result.put("list", visitMapper.selectBlockList(requestMap));

	    return result;
	}

	@Override
    @Transactional
    public void saveRequest(Map requestMap) throws Exception {
		
		//사용자 정보 업데이트
    	String mberFlag = requestMap.get("mberFlag").toString();
    	
    	if (mberFlag.equals("00")) {
    		requestMap.put("mberFlag", "02");
    	} else if (mberFlag.equals("01")) {
    		requestMap.put("mberFlag", "03");
    	} else if (mberFlag.equals("04")) {
    		requestMap.put("mberFlag", "06");
    	} else if (mberFlag.equals("05")) {
    		requestMap.put("mberFlag", "07");
    	}
		visitMapper.updateMberFlag(requestMap);
    	
    	// 배정구간 생성
    	requestMap.put("assignSectionKey", generationKey.genTableKey("TB_ASSIGN_SECTION", "ASSIGN_SECTION_KEY"));
    	visitMapper.insertAssignSection(requestMap);

        // 고객키, 차량키 기본 계약정보 생성
        Map contractMap = new HashMap();
        requestMap.put("contractInfoKey", generationKey.genTableKey("TB_CONTRACT_INFO", "CONTRACT_INFO_KEY"));
        requestMap.put("parkingProduct", "02");
        requestMap.put("requestWay", "01");
        requestMap.put("assignStatus", "02");
        visitMapper.insertContractInfo(requestMap);

        // 계약정보 이력 생성
        requestMap.put("contractHistoryKey", generationKey.genTableKey("TB_CONTRACT_HISTORY", "CONTRACT_HISTORY_KEY"));
        visitMapper.insertContractHistory(requestMap);
        
        // 선택한 구간의 방문주차요금 * 이용개월 계산
        String useMonth = (String) requestMap.get("useMonth");
        int calcMonth = 0;
        if(useMonth.equals("01")){
            calcMonth = 1;
        }else if(useMonth.equals("02")){
            calcMonth = 2;
        }else if(useMonth.equals("03")){
            calcMonth = 3;
        }
        int visitParkCharge = visitMapper.selectVisitParkCharge(requestMap);
        int cost = calcMonth * visitParkCharge;
        requestMap.put("cost", cost);

        // 수납정보 생성
        requestMap.put("purchaseKey", generationKey.genTableKey("TB_QUARTER_PAYMENT", "PURCHASE_KEY"));
        requestMap.put("payMethodCd", "01");
        requestMap.put("statusCd", "00");
        requestMap.put("assignStatus", "01");
        requestMap.put("statCd", "03"); //수납테이블에서 어느건에 대한 데이터인지 구분코드(01:거주자, 02:부정주차, 03:방문주차, 04:월정기, 05:시간주차)
        visitMapper.insertQuarterPayment(requestMap);
    }
    
}
