package com.koticobui.dfmc.client.com;

import java.io.IOException; 
import java.util.Map;

import javax.servlet.ServletException; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 

import org.apache.commons.lang.StringUtils; 
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.Authentication; 
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler; 
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.koticobui.dfmc.client.com.util.SessionService;

public class SigninSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler { 
	
	@Override 
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) 
			throws IOException, ServletException { 
		
		request.getSession().setAttribute("isLocallyAuthenticated", true);
		
        ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
        SessionService sessionService = (SessionService) context.getBean("sessionService");
        
        try {
			Map map = sessionService.selectSession(request.getSession().getId());
			if (map == null) {
				sessionService.insertSession(request.getSession().getId());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String accept = request.getHeader("accept"); 
		if( StringUtils.indexOf(accept, "html") > -1 ) { 
			super.onAuthenticationSuccess(request, response, auth); 
		} else if( StringUtils.indexOf(accept, "xml") > -1 ) { 

		} else if( StringUtils.indexOf(accept, "json") > -1 ) { 

		} 
	} 
}