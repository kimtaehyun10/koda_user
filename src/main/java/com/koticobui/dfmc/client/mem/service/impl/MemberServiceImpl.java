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
import com.koticobui.dfmc.client.security.model.Customer;
import com.koticobui.dfmc.client.security.service.AuthenticationService;


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

    @Resource(name = "authenticationService")
    private AuthenticationService authenticationService;
    
    @Override
    @Transactional
    public void saveMember(Map requestMap) throws Exception {

        // 고객정보 저장
        memberMapper.insertMember(requestMap);
        
        if (((String)requestMap.get("gubn")).equals("D")) {
            //기증자 정보 저장
            memberMapper.insertDonor(requestMap);
        }else {
        	//수혜자 정보 저장
            memberMapper.insertBenefi(requestMap);
        }
        
        
    }
    
    @Override
    @Transactional
	public void updateMember(Map requestMap) throws Exception {
    	Map result = new HashMap<String, Object>();
    	
    	Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	 // 고객정보 수정
        memberMapper.updateMember(requestMap);
    	
		
	}
    
	//사용자 정보 조회
    @Override
	public Map<String, Object> searchMember(Map requestMap) {

    	Map result = new HashMap<String, Object>();
    	
    	Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	requestMap.put("password", customer.getPassword());

 		result.putAll(memberMapper.searchMember(requestMap));
    	
		return result;
	}

	@Override
    @Transactional
	public void extMember(Map requestMap) throws Exception {
    	Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	memberMapper.extMember(requestMap);
		
	}
    
    @Override
	public int chkPassword(Map requestMap) {
    	Customer customer = authenticationService.getCustomer();
    	
    	requestMap.put("id", customer.getUsername());
    	
    	LOGGER.debug("password : " + customer.getPassword());
    	
        int result = memberMapper.chkPassword(requestMap);
        return result;
	}
    
    @Override
	@Transactional
	public int updatePw(Map requestMap) {
    	
		int updateResult = memberMapper.updatePw(requestMap);
		
		return updateResult;
		
	}
    

 	@Override
    public int mberIdDuplCheck(Map requestMap) {

        int result = memberMapper.mberIdDuplCheck(requestMap);
        return result;
    }


    @Override
    public int mberNickNameDuplCheck(Map requestMap) {

        int result = memberMapper.mberNickNameDuplCheck(requestMap);
        return result;
    }
	    
    
    ///////////////////////////////////
    
    @Override
    public int searchUseMember(Map requestMap) {

        int result = memberMapper.searchUseMember(requestMap);
        return result;
    }
    



	@Override
    public int carNumberDupCheck(Map requestMap) {

        int result = memberMapper.carNumberDupCheck(requestMap);
        return result;
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
	
	
	
}
