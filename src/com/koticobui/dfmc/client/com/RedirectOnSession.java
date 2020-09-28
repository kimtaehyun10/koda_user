package com.koticobui.dfmc.client.com;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.koticobui.dfmc.client.com.util.SessionService;

/**
 * 2018-01-25
 * @author june han
 *
 * 세션 request가 발생하면 DB에 마지막 시간을 기록한다.
 * 다만, request 마지막 시간을 체크하기 위한 동작은 DB에 시간을 남기지 않는다.
 * 이렇게 저장된 시간은 화면에서 10분간격으로 DB를 체크해서 session 만료시간으로
 * 설정된 시간이 초과되면 강제로 로그아웃 시키는데 이용한다.
 * 
 * session은 HttpSessionCheckingListener에서
 * 세션이 만들어지면 무조건 DB에 insert를 하고 이후부터는 여기서 시간만 업데이트 해준다.
 */
public class RedirectOnSession implements Filter {
	
    public void destroy() {
        // TODO Auto-generated method stub
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    	HttpServletRequest req = (HttpServletRequest)request;
    	HttpSession session = req.getSession();
    	
    	//request가 발생하면 DB에 세션 마지막 request 시간을 기록한다.
    	if (session.getAttribute("isLocallyAuthenticated") != null) {
    		String auth = session.getAttribute("isLocallyAuthenticated").toString();
    		String uri = req.getRequestURI();
    		
    		//화면에서 세션 request 체크하기 위한 동작은 업데이트를 하지 않도록 한다.
    		if (auth.equals("true") && uri.equals("/com/selectSession.json") == false) {
    			ServletContext application = session.getServletContext();
    			ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(application);
    			SessionService sessionService = (SessionService) act.getBean("sessionService");
    			try {
					sessionService.updateSession(session.getId());
				} catch (Exception e) {
					e.printStackTrace();
				}
    		}
    	}
    	
        chain.doFilter(request, response);
    }

    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }
}