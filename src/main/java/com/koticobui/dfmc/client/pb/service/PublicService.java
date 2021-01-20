/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.pb.service;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;
/**
 * The interface letterService service.
 */
public interface PublicService {
	
	HttpServletRequest annual(HttpServletRequest request);
	
	HttpServletRequest eBook(HttpServletRequest request);

	HttpServletRequest news_Letter(HttpServletRequest request);
	
	HttpServletRequest casebook(HttpServletRequest request);

	HttpServletRequest movie(HttpServletRequest request);

	HttpServletRequest movie_view(HttpServletRequest request);
	
	HttpServletRequest web_contents(HttpServletRequest request);
	
	HttpServletRequest web_contents_view(HttpServletRequest request);

	HttpServletRequest lifeSharing(HttpServletRequest request);

	HttpServletRequest lifeSharing_view(HttpServletRequest request);
	
	HttpServletRequest pressRelease(HttpServletRequest request);

	HttpServletRequest pressRelease_view(HttpServletRequest request);

	HttpServletRequest notice(HttpServletRequest request);
	
	HttpServletRequest notice_view(HttpServletRequest request);
	
	HttpServletRequest comnews(HttpServletRequest request);
	
	HttpServletRequest comnews_view(HttpServletRequest request);

	HttpServletRequest infobefore(HttpServletRequest request);
	
	HttpServletRequest infobefore_view(HttpServletRequest request);

	HttpServletRequest infodata(HttpServletRequest request);
	
	HttpServletRequest infodata_view(HttpServletRequest request);

	HttpServletRequest infolaw(HttpServletRequest request);
	
	HttpServletRequest infolaw_view(HttpServletRequest request);

	HttpServletRequest comrecruit(HttpServletRequest request);
	
	HttpServletRequest comrecruit_view(HttpServletRequest request);

	HttpServletRequest comhuman(HttpServletRequest request);
	
	HttpServletRequest comhuman_view(HttpServletRequest request);
	
	HttpServletRequest organ_agree1(HttpServletRequest request);
	
	HttpServletRequest organ_agree2(HttpServletRequest request);
	
	HttpServletRequest organ_fact(HttpServletRequest request);
	
	HttpServletRequest infodonate(HttpServletRequest request);
	
	HttpServletRequest infotrans(HttpServletRequest request);

	HttpServletRequest infohope(HttpServletRequest request);
	
	HttpServletRequest hire(HttpServletRequest request);

	HttpServletRequest hire_view(HttpServletRequest request);
}
