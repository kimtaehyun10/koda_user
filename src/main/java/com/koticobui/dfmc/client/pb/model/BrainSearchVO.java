package com.koticobui.dfmc.client.pb.model;

import com.koticobui.dfmc.client.com.model.PagingBean;


public class BrainSearchVO extends PagingBean
{
  private String hospitalArea;
  private String hospitalType;
  private String searchKey;
  private String searchValue;
  private int famEvntIdx;
  private int brdNo;
  private int brdFileSeq;
  private int brdContNo;
  private String optionStr;

  public int getFamEvntIdx()
  {
    return this.famEvntIdx;
  }
  public void setFamEvntIdx(int famEvntIdx) {
    this.famEvntIdx = famEvntIdx;
  }
  public String getOptionStr() {
    return this.optionStr;
  }
  public void setOptionStr(String optionStr) {
    this.optionStr = optionStr;
  }
  public int getBrdContNo() {
    return this.brdContNo;
  }
  public void setBrdContNo(int brdContNo) {
    this.brdContNo = brdContNo;
  }
  public int getBrdFileSeq() {
    return this.brdFileSeq;
  }
  public void setBrdFileSeq(int brdFileSeq) {
    this.brdFileSeq = brdFileSeq;
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
  public int getBrdNo() {
    return this.brdNo;
  }
  public void setBrdNo(int brdNo) {
    this.brdNo = brdNo;
  }
  public String getHospitalArea() {
    return this.hospitalArea;
  }
  public void setHospitalArea(String hospitalArea) {
    this.hospitalArea = hospitalArea;
  }
  public String getHospitalType() {
    return this.hospitalType;
  }
  public void setHospitalType(String hospitalType) {
    this.hospitalType = hospitalType;
  }
}
