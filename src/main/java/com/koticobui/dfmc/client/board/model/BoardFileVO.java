package com.koticobui.dfmc.client.board.model;

public class BoardFileVO
{
  private int brdNo;
  private int brdContNo;
  private String brdContRe;
  private String brdFileSeq;
  private String brdFileNm;
  private String brdFileOrgNm;
  private String regDm;

  public int getBrdNo()
  {
    return this.brdNo;
  }
  public void setBrdNo(int brdNo) {
    this.brdNo = brdNo;
  }
  public int getBrdContNo() {
    return this.brdContNo;
  }
  public void setBrdContNo(int brdContNo) {
    this.brdContNo = brdContNo;
  }
  public String getBrdContRe() {
    return this.brdContRe;
  }
  public void setBrdContRe(String brdContRe) {
    this.brdContRe = brdContRe;
  }
  public String getBrdFileSeq() {
    return this.brdFileSeq;
  }
  public void setBrdFileSeq(String brdFileSeq) {
    this.brdFileSeq = brdFileSeq;
  }
  public String getBrdFileNm() {
    return this.brdFileNm;
  }
  public void setBrdFileNm(String brdFileNm) {
    this.brdFileNm = brdFileNm;
  }
  public String getBrdFileOrgNm() {
    return this.brdFileOrgNm;
  }
  public void setBrdFileOrgNm(String brdFileOrgNm) {
    this.brdFileOrgNm = brdFileOrgNm;
  }
  public String getRegDm() {
    return this.regDm;
  }
  public void setRegDm(String regDm) {
    this.regDm = regDm;
  }
}
