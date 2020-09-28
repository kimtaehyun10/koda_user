package com.koticobui.dfmc.client.com.util;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.koticobui.dfmc.client.res.mapper.CustomerMapper;

public class SessionService {
	
	@Autowired
	private CustomerMapper customerMapper;
	
    public int insertSession(String session) throws Exception {
    	return this.customerMapper.insertSession(session);
    }
    public int updateSession(String session) throws Exception {
    	return this.customerMapper.updateSession(session);
    }
    
    public Map selectSession(String session) throws Exception {
    	return this.customerMapper.selectSession(session);
    }
	
}