/*
 * Copyright (C) 2016. by Koticobui All right reserved.
 */
package com.koticobui.dfmc.client.let.model;



/**
 * The type Customer vo.
 */
public class LetterFileVO {
	int letter_id; 
    int letter_file_seq; 
    String letter_file_nm; 
    String letter_file_org_nm; 
    String create_time; 
    String create_id; 
    String update_time; 
    String update_id;
	public int getLetter_id() {
		return letter_id;
	}
	public void setLetter_id(int letter_id) {
		this.letter_id = letter_id;
	}
	public int getLetter_file_seq() {
		return letter_file_seq;
	}
	public void setLetter_file_seq(int letter_file_seq) {
		this.letter_file_seq = letter_file_seq;
	}
	public String getLetter_file_nm() {
		return letter_file_nm;
	}
	public void setLetter_file_nm(String letter_file_nm) {
		this.letter_file_nm = letter_file_nm;
	}
	public String getLetter_file_org_nm() {
		return letter_file_org_nm;
	}
	public void setLetter_file_org_nm(String letter_file_org_nm) {
		this.letter_file_org_nm = letter_file_org_nm;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getCreate_id() {
		return create_id;
	}
	public void setCreate_id(String create_id) {
		this.create_id = create_id;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}
	public String getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(String update_id) {
		this.update_id = update_id;
	}
    
    
}
