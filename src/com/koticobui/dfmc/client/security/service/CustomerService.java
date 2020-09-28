package com.koticobui.dfmc.client.security.service;

import com.koticobui.dfmc.client.res.mapper.CustomerMapper;
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

import java.util.ArrayList;
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
            if (StringUtils.isEmpty(userData.get("mberId")))
                throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        } else {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
        }

        logger.debug("==============> CustomerService");
        logger.debug("emplyrId: {}", userData.get("mberId"));
        logger.debug("password: {}", userData.get("password"));

        List<GrantedAuthority> roles = new ArrayList();
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));

        String mberNm = "";
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
                "", roles, mberNm, mberPhone, mberEmailAdres, mberBirth, userData.get("esntlId").toString(), passwordDt, failDt, failCount, currentDt);

        return customer;
    }
}
