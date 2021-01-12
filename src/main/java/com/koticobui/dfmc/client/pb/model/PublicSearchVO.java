package com.koticobui.dfmc.client.pb.model;

import com.koticobui.dfmc.client.com.model.PagingBean;


public class PublicSearchVO extends PagingBean
{
  private int brdContNo;
  private int brdNo;
  private int brdContRe;
  private int brdFileSeq;
  private int newsBrdNo1;
  private int newsBrdNo2;
  private String searchKey;
  private String searchValue;
  private String optionStr;
  private String year;
  private String month;

  public int getNewsBrdNo1()
  {
    return this.newsBrdNo1;
  }

  public void setNewsBrdNo1(int newsBrdNo1) {
    this.newsBrdNo1 = newsBrdNo1;
  }

  public int getNewsBrdNo2() {
    return this.newsBrdNo2;
  }

  public void setNewsBrdNo2(int newsBrdNo2) {
    this.newsBrdNo2 = newsBrdNo2;
  }

  public String getYear() {
    return this.year;
  }

  public void setYear(String year) {
    this.year = year;
  }

  public String getMonth() {
    return this.month;
  }

  public void setMonth(String month) {
    this.month = month;
  }

  public int getBrdContRe() {
    return this.brdContRe;
  }

  public void setBrdContRe(int brdContRe) {
    this.brdContRe = brdContRe;
  }

  public int getBrdFileSeq() {
    return this.brdFileSeq;
  }

  public void setBrdFileSeq(int brdFileSeq) {
    this.brdFileSeq = brdFileSeq;
  }

  public int getBrdContNo() {
    return this.brdContNo;
  }

  public void setBrdContNo(int brdContNo) {
    this.brdContNo = brdContNo;
  }

  public int getBrdNo() {
    return this.brdNo;
  }

  public void setBrdNo(int brdNo) {
    this.brdNo = brdNo;
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

  public String getOptionStr() {
    return this.optionStr;
  }

  public void setOptionStr(String optionStr) {
    this.optionStr = optionStr;
  }
}
