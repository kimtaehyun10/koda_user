package com.koticobui.dfmc.client.com.menu.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koticobui.dfmc.client.com.service.CommonService;
import com.koticobui.dfmc.client.let.service.LetterService;

/**
 * Created by aircha on 2016. 6. 26..
 */
@Controller
public class MenuController {
    @Resource(name = "commonService")
    private CommonService commonService;
	
	@RequestMapping(value = "/main/contents.c")
	public String contentPage(
			  @RequestParam("menuCd") String menuCd
			, @RequestParam("seqCd1") String seqCd1
			, @RequestParam("seqCd2") String seqCd2
			, HttpServletRequest request
			, ModelMap model) {
		
		String menuUrl = "";
		
		Map requestMap = new HashMap<String, Object>();
		requestMap.put("menuCd", menuCd);
		requestMap.put("seqCd1", seqCd1);
		requestMap.put("seqCd2", seqCd2);
		
		menuUrl = commonService.searchMenuUrl(requestMap);
		
		if (menuCd != null || seqCd1 != null || seqCd2 != null) {
			List<Map<String, Object>> mlist = commonService.searchSubMenuList(requestMap);	

		    request.setAttribute("mlist", mlist);
		}

	    request.setAttribute("menuCd", menuCd);
	    request.setAttribute("seqCd1", seqCd1);
	    request.setAttribute("seqCd2", seqCd2);
		
		return menuUrl;

	}
}
