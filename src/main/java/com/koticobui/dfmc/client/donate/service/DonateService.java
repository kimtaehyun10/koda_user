/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.donate.service;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;
/**
 * The interface letterService service.
 */
public interface DonateService {
	
	HttpServletRequest member(HttpServletRequest request);
	
	HttpServletRequest member_view(HttpServletRequest request);

	@Transactional
	Map<String, Object> member_like_update(HttpServletRequest request);
	
	@Transactional
	void member_com_insert(HttpServletRequest request);

//	@Transactional
//	void choice_insert(HttpServletRequest request);
	
	HttpServletRequest letter(HttpServletRequest request);
	
	HttpServletRequest letter_view(HttpServletRequest request);

	@Transactional
	void letter_com_insert(HttpServletRequest request);

	@Transactional
	Map<String, Objects> pwd_action(HttpServletRequest request);	

	HttpServletRequest letter_form(HttpServletRequest request);

	@Transactional
	Map<String, Objects> letter_insert(HttpServletRequest request);
	
	@Transactional
	Map<String, Objects> letter_update(HttpServletRequest request);

	@Transactional
	Map<String, Objects> letter_delete(HttpServletRequest request);
	
	HttpServletRequest receipt(HttpServletRequest request);
	
	HttpServletRequest receipt_view(HttpServletRequest request);

	@Transactional
	void receipt_com_insert(HttpServletRequest request);

	HttpServletRequest receipt_form(HttpServletRequest request);

	@Transactional
	Map<String, Objects> receipt_insert(HttpServletRequest request);
	
	@Transactional
	Map<String, Objects> receipt_update(HttpServletRequest request);

	@Transactional
	Map<String, Objects> receipt_delete(HttpServletRequest request);

	HttpServletRequest story(HttpServletRequest request);

	@Transactional
	HttpServletRequest story_view(HttpServletRequest request);
	
	@Transactional
	void story_com_insert(HttpServletRequest request);
	
	HttpServletRequest story_form(HttpServletRequest request);

	@Transactional
	Map<String, Objects> story_insert(HttpServletRequest request);

	@Transactional
	Map<String, Objects> story_update(HttpServletRequest request);
	
	@Transactional
	Map<String, Objects> story_delete(HttpServletRequest request);
}
