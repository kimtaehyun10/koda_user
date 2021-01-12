package com.koticobui.dfmc.client.security;

import com.koticobui.dfmc.client.com.mapper.CommonMapper;
import com.koticobui.dfmc.client.security.mapper.CustomerMapper;
import com.koticobui.dfmc.client.security.model.Customer;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.Collection;
import java.util.Date;
import java.util.Map;


/**
 * Created by aircha on 2016. 6. 25..
 */

public class CustomerProvider implements AuthenticationProvider {

    private static final Logger logger = LogManager.getLogger();

    @Autowired
    private UserDetailsService customerService;

    @Autowired
    private CommonMapper commonMapper;

    @Autowired
    private CustomerMapper customerMapper;

    
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String user_id = (String)authentication.getPrincipal();
        String user_pw = (String)authentication.getCredentials();

        logger.debug("==============> CustomerProvider");
        logger.debug("user_id: {}", user_id);
        //logger.debug("user_pw: {}", user_pw);
        
        UserDetails user = customerService.loadUserByUsername(user_id);
        user_pw = customerMapper.encodingPw(user_pw);
        
        logger.debug("==============> CustomerProvider_encodig");
        logger.debug("user_id: {}", user_id);
        logger.debug("user_pw: {}", user_pw);
        
        // 로그인 실패로 locking 여부 확인
        /*Date failDt = null;
        long failCount = ((Customer)user).getFailCount();
        if (failCount >= 5 && ((Customer)user).getFailDt() != null) {
        	failDt = ((Customer)user).getFailDt();
        	long failDtLong = failDt.getTime();
        	
        	Date now = ((Customer)user).getCurrentDt();
        	long nowLong = now.getTime();
        	
        	long interval = (nowLong - failDtLong) / 60000;
        	if (interval >= 0 && interval < 30) {
        		throw new DisabledException("locked");
        	}
        }*/

        // DAMO 페스워드 인코딩
        /*String encodingPassword = commonMapper.encodingHashData(user_pw);

        if (!encodingPassword.equals(user.getPassword())) {
        	commonMapper.updateFailCount(user_id);
            throw new BadCredentialsException(String.valueOf(failCount));
        } 

        commonMapper.resetFailCount(user_id);*/
        

        if (!user_pw.equals(user.getPassword())) {
            throw new BadCredentialsException("wrong password");
        } 
        
        logger.debug("정상 로그인.");

        return new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
