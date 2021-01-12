package com.koticobui.dfmc.client.donate.model;

import com.koticobui.dfmc.client.com.model.PagingBean;

/**
 * The type Discount item vo.
 */

public class DonateSearchVO extends PagingBean {
	

	  private String searchKey;
	  private String searchValue;
	  private String gubun;
	  private int idx;
	  private int comIdx;
	  private String optionStr;
	  private String pwd;
	  private String searchYear;
	  private String startDate;
	  private String endDate;
	  private String donateName;
	  private int donateIdx;
	  private int CurrentPage;

	  public int getDonateIdx()
	  {
	    return this.donateIdx;
	  }

	  public void setDonateIdx(int donateIdx) {
	    this.donateIdx = donateIdx;
	  }

	  public String getSearchYear() {
	    return this.searchYear;
	  }

	  public void setSearchYear(String searchYear) {
	    this.searchYear = searchYear;
	  }

	  public String getStartDate() {
	    return this.startDate;
	  }

	  public void setStartDate(String startDate) {
	    this.startDate = startDate;
	  }

	  public String getEndDate() {
	    return this.endDate;
	  }

	  public void setEndDate(String endDate) {
	    this.endDate = endDate;
	  }

	  public String getDonateName() {
	    return this.donateName;
	  }

	  public void setDonateName(String donateName) {
	    this.donateName = donateName;
	  }
	  public String getPwd() {
	    return this.pwd;
	  }

	  public void setPwd(String pwd) {
	    this.pwd = pwd;
	  }

	  public int getComIdx() {
	    return this.comIdx;
	  }

	  public void setComIdx(int comIdx) {
	    this.comIdx = comIdx;
	  }

	  public String getOptionStr() {
	    return this.optionStr;
	  }

	  public void setOptionStr(String optionStr) {
	    this.optionStr = optionStr;
	  }

	  public String getGubun() {
	    return this.gubun;
	  }

	  public void setGubun(String gubun) {
	    this.gubun = gubun;
	  }

	  public String getSearchKey() {
	    return this.searchKey;
	  }

	  public void setSearchKey(String searchKey) {
	    this.searchKey = searchKey;
	  }

	  public String getSearchValue() {
	    return this.searchValue;
	  }

	  public void setSearchValue(String searchValue) {
	    this.searchValue = searchValue;
	  }

	  public int getIdx() {
	    return this.idx;
	  }

	  public void setIdx(int idx) {
	    this.idx = idx;
	  }

	  public int getCurrentPage() {
	  	return CurrentPage;
	  }
      
	  public void setCurrentPage(int currentPage) {
	  	CurrentPage = currentPage;
	  }

}
