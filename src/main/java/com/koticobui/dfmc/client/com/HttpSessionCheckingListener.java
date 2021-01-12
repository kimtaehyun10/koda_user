package com.koticobui.dfmc.client.com;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.koticobui.dfmc.client.com.util.SessionService;


public class HttpSessionCheckingListener implements HttpSessionListener {

	private Integer sessionCount;

	//    @Autowired
	//    private CustomerMapper customerMapper;

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		synchronized (this) {
			final ServletContext application = event.getSession().getServletContext();
			sessionCount = (Integer) application.getAttribute("SESSION_COUNT");

			final ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(event.getSession().getServletContext());
			final SessionService sessionService = (SessionService) context.getBean("sessionService");

			try {
				sessionService.insertSession(event.getSession().getId());
			} catch (final Exception e) {
				e.printStackTrace();
			}

			if (sessionCount == null) {
				application.setAttribute("SESSION_COUNT", (sessionCount = 1)); //setting sessioncount inside application scope
			} else {
				application.setAttribute("SESSION_COUNT", sessionCount + 1);
			}
			System.out.println("Session Created : "+ event.getSession().getId());
			System.out.println("Total Sessions : " + sessionCount);
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		synchronized (this) {
			final ServletContext application = event.getSession().getServletContext();
			sessionCount = (Integer) application.getAttribute("SESSION_COUNT");
			application.setAttribute("SESSION_COUNT", sessionCount - 1);
			System.out.println("Session Destroyed: " + event.getSession().getId());
			System.out.println("Total Sessions: " + sessionCount);  
		}
	}
}
