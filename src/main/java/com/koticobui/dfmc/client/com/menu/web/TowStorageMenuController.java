/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */

package com.koticobui.dfmc.client.com.menu.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by aircha on 2016. 5. 19..
 */
@Controller
public class TowStorageMenuController {
	
	//견인보관소 메뉴관리
	
	//견인보관소안내
	@RequestMapping(value = "/tow/towStorageInfo.c")
    public String towStorageInfo(HttpServletRequest request, ModelMap model) throws Exception {

		return "tow/towStorageInfo";
    }
	
}
