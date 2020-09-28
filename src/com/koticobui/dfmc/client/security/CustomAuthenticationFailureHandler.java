package com.koticobui.dfmc.client.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {

		String url = "/?loginError=01";
		request.getSession().setAttribute("failCount", "-1");
		
		if (exception.getClass().isAssignableFrom(DisabledException.class)) {
			//계정 잠김
			String message = exception.getMessage();
			if (message.equals("locked")) {
				url = "/?loginError=03";
			}
		} else if (exception.getClass().isAssignableFrom(BadCredentialsException.class)) {
			String message = exception.getMessage();
			request.getSession().setAttribute("failCount", message);
		}
		
		setDefaultFailureUrl(url);
		super.onAuthenticationFailure(request, response, exception);
	}
}