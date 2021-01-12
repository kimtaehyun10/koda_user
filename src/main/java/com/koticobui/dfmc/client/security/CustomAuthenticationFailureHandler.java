package com.koticobui.dfmc.client.security;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.koticobui.dfmc.client.security.mapper.CustomerMapper;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Resource(name = "customerMapper")
    private CustomerMapper customerMapper;
    
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

		String url = "";
		
		int apprFlag = customerMapper.checkApprFlag((String)request.getParameter("user_id"));
		
		if (apprFlag > 0) {
			url = "/mem/memLogin.l?loginError=05";
		}else {
			url = "/mem/memLogin.l?loginError=01";
		}
		
	
		//request.getSession().setAttribute("failCount", "-1");
		
		//if (exception.getClass().isAssignableFrom(DisabledException.class)) {
			//계정 잠김
		//	String message = exception.getMessage();
		//	if (message.equals("locked")) {
		//		url = "/mem/memLogin.l?loginError=03";
		//	}
		//} else if (exception.getClass().isAssignableFrom(BadCredentialsException.class)) {
		//	String message = exception.getMessage();
		//	request.getSession().setAttribute("failCount", message);
		//}
		
		setDefaultFailureUrl(url);
		super.onAuthenticationFailure(request, response, exception);
	}
}