package com.koticobui.dfmc.client.security.service;

import com.ibm.icu.text.SimpleDateFormat;
import com.koticobui.dfmc.client.security.mapper.CustomerMapper;
import com.koticobui.dfmc.client.security.model.Customer;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by aircha on 2016. 6. 25..
 */
public class CustomerService implements UserDetailsService {
    private static final Logger logger = LogManager.getLogger();

    @Autowired
    private CustomerMapper customerMapper;
    
    @Override
    public UserDetails loadUserByUsername(final String userid) throws UsernameNotFoundException {
        Map userData = customerMapper.selectCustomerInfo(userid);

        if (userData != null) {
            if (StringUtils.isEmpty(userData.get("id")))
                throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        } else {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        }

        logger.debug("==============> CustomerService");
        logger.debug("id: {}", userData.get("id"));
        logger.debug("password: {}", userData.get("password"));
        
        //권한부여
        List<GrantedAuthority> roles = new ArrayList();
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));

        String userId = ""; //로그인 사용자 ID
        String mberNm = ""; //로그인 사용자 성명
        String userPw = ""; //로그인 사용자 패스워드
        String userIx = ""; //로그인 사용자 IDX
        String userNk = ""; //로그인 사용자 slrspdla
        Date currentDt = null; //로그인 시간

        if (userData.get("id") != null)
        	userId = userData.get("id").toString();

        if (userData.get("name") != null)
            mberNm = userData.get("name").toString();

        if (userData.get("password") != null)
        	userPw = userData.get("password").toString();

        if (userData.get("idx") != null)
        	userIx = userData.get("idx").toString();

        if (userData.get("nick_name") != null)
        	userNk = userData.get("nick_name").toString();

        if (userData.get("currentDt") != null) {
	        SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	        try {
				currentDt = transFormat.parse((String)userData.get("currentDt"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
        }

        Customer customer = new Customer(userId,mberNm, userPw, userIx, userNk, currentDt,"", roles);
        
        /*String mberNm = "";
        String mberPhone = "";
        String mberEmailAdres = "";
        String mberBirth = "";

        if (userData.get("mberNm") != null)
            mberNm = userData.get("mberNm").toString();
        if (userData.get("mberPhone") != null)
            mberPhone = userData.get("mberPhone").toString();
        if (userData.get("mberEmailAdres") != null)
            mberEmailAdres = userData.get("mberEmailAdres").toString();
        if (userData.get("mberBirth") != null)
            mberBirth = userData.get("mberBirth").toString();
        
        Date passwordDt = null;
        if (userData.get("passwordDt") != null)
        	passwordDt = (Date)userData.get("passwordDt");
        
        Date failDt = null;
        if (userData.get("failDt") != null)
        	failDt = (Date)userData.get("failDt");
        
        long failCount = 0;
        if (userData.get("failCount") != null)
        	failCount = Integer.parseInt(String.valueOf(userData.get("failCount")));
        
        Date currentDt = null;
        if (userData.get("currentDt") != null)
        	currentDt = (Date)userData.get("currentDt");

        Customer customer = new Customer(userData.get("mberId").toString(), userData.get("password").toString(),
                "", roles, mberNm, mberPhone, mberEmailAdres, mberBirth, userData.get("esntlId").toString(), passwordDt, failDt, failCount, currentDt);*/

        return customer;
    }
    
}
