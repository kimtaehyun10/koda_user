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
package com.koticobui.dfmc.client.mem.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koticobui.dfmc.client.com.util.GenerationKey;
import com.koticobui.dfmc.client.com.util.GeoCodingComponent;
import com.koticobui.dfmc.client.mem.mapper.MemberMapper;
import com.koticobui.dfmc.client.mem.model.DiscountItemVO;
import com.koticobui.dfmc.client.mem.service.MemberService;


/**
 * The type Customer manage service.
 */
@Service("memberService")
public class MemberServiceImpl implements MemberService {

    private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);

    @Resource(name = "memberMapper")
    private MemberMapper memberMapper;
    
    @Resource(name = "generationKey")
    private GenerationKey generationKey;
    
    @Resource(name = "geoCodingComponent")
    private GeoCodingComponent geoCodingComponent;
    
    
    @Override
    public int searchUseMember(Map requestMap) {

        int result = memberMapper.searchUseMember(requestMap);
        return result;
    }
    
    @Override
    public int mberIdDuplCheck(Map requestMap) {

        int result = memberMapper.mberIdDuplCheck(requestMap);
        return result;
    }
    
    @Override
    public int carNumberDupCheck(Map requestMap) {

        int result = memberMapper.carNumberDupCheck(requestMap);
        return result;
    }

    @Override
    @Transactional
    public void saveMember(Map requestMap, DiscountItemVO discountItemVO) throws Exception {

        // 주소정보를 받아 위치정보를 얻어온다
        getLocation(requestMap);

        // 고객정보 insert
        requestMap.put("esntlId", generationKey.genTableKey("COMTNGNRLMBER", "ESNTL_ID"));
        requestMap.put("mberSttus", "P");
        requestMap.put("groupId", "GROUP_00000000000000");
        requestMap.put("joinCode", "01");
        memberMapper.insertMember(requestMap);
        
        // 차량정보 insert
        requestMap.put("carKey", generationKey.genTableKey("TB_CAR", "CAR_KEY"));
        memberMapper.insertCar(requestMap);
        
        
        // 할인항목 insert
  		if(discountItemVO.getArrDiscountItemKey() != null){
  			
  			for (int i = 0; i < discountItemVO.getArrDiscountItemKey().length; i++) {
  				
  				requestMap.put("discountItemKey", discountItemVO.getArrDiscountItemKey()[i]);
  				
  				String discountDetailKey = "";
  				try {
  					discountDetailKey = generationKey.genTableKey("TB_DISCOUNT_DETAIL", "DISCOUNT_DETAIL_KEY");
  				} catch (Exception e) {
  					e.printStackTrace();
  				}
  				requestMap.put("discountDetailKey", discountDetailKey);
  				
  				//할인내역 저장
  				//int discountDetailResult = publicAssignManageMapper.saveDiscountDetail(requestMap);
  				memberMapper.insertDiscountDetail(requestMap);
  			}
  			
  		}
        /*
        String[] array = (String[]) requestMap.get("discountItemArray");

        //array[0] = "Test1";
        //array[1] = "Test2";
        //array[2] = "Test3";

        ArrayList<String> arrayList = new ArrayList<>();
        for(String temp : array){
          arrayList.add(temp);
        }
        
        
        //ArrayList<String> arrayList = new ArrayList<String>(Arrays.asList(requestMap.get("discountItemArray").toString()));
        
        // 할인항목 insert
        //String discountItem[] = null;
        //if(requestMap.get("discountItemArray") != null){
        //	discountItem = (String[]) requestMap.get("discountItemArray");
        //}
        
        Map discountMap = new HashMap<String, Object>();
        discountMap.put("esntlId", requestMap.get("esntlId"));
        
        for(int i=0; i< arrayList.size(); i++) {
        	discountMap.put("discountDetailKey", generationKey.genTableKey("TB_DISCOUNT_DETAIL", "DISCOUNT_DETAIL_KEY"));
        	discountMap.put("discountItemKey", arrayList.get(i));
        	memberMapper.insertDiscountDetail(discountMap);
        }
        
        
        // 할인항목 insert
        for (Map dcMap : (List<Map>) requestMap.get("discountItemArray")) {
            //dcMap.put("discountDetailKey", discountDetailKeyGnr.getNextStringId());
            dcMap.put("discountDetailKey", generationKey.genTableKey("TB_DISCOUNT_DETAIL", "DISCOUNT_DETAIL_KEY"));
            dcMap.put("esntlId", requestMap.get("esntlId"));
            dcMap.put("discountItemKey", dcMap.get("discountItemKey"));
            memberMapper.insertDiscountDetail(dcMap);
        }
        */

    }
    
    private void getLocation(Map requestMap) throws Exception {
        Map geoCodingMap = geoCodingComponent.getLocationByAddress(requestMap.get("adres") + " " + requestMap.get("detailAdres"));
        requestMap.put("memberLon", geoCodingMap.get("memberLon").toString());
        requestMap.put("memberLat", geoCodingMap.get("memberLat").toString());
    }
    
    @Override
	public Map<String, Object> findMemberId(Map requestMap) {
		
		return memberMapper.findMemberId(requestMap);
	}
	
	@Override
	@Transactional
	public Map<String, Object> findPassword(Map requestMap) {
		
		Map result = new HashMap<String, Object>();
		
		String tempPassword = "";

		for(int i=0; i<8; i++) {
			
			int rndVal = (int)(Math.random() * 62);
			
			if(rndVal < 10) {
				tempPassword += rndVal;
			}else if(rndVal > 35){
				tempPassword += (char)(rndVal + 61);
			}else{
				tempPassword += (char)(rndVal + 55);
			}
		}
		
		requestMap.put("password", tempPassword);
		
		int updateResult = memberMapper.updatePassword(requestMap);
		
		if(updateResult > 0){
			result.put("password", tempPassword);
		}else{
			requestMap.put("password", "");
		}
		
		return result;
	}

}
