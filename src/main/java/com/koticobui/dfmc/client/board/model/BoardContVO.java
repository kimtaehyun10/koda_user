package com.koticobui.dfmc.client.board.model;

import java.util.ArrayList;

public class BoardContVO
{
  private int brdNo;
  private int changeBrdNo;
  private int brdContNo;
  private String brdContRe;
  private String brdContClass;
  private String brdTitle;
  private String brdPwd;
  private String brdMkrNm;
  private String brdEml;
  private String brdUrl;
  private String brdDownUrl;
  private String brdLock;
  private String brdContents;
  private String brdHtmlYn;
  private int brdReadNum;
  private String regDm;
  private String myNbsp;
  private String brdFileNm;
  private String brdFileOrgNm;
  private int brdFileSeq;
  private BoardFileVO bean;
  private String brdEtc1;
  private String brdEtc2;
  private String brdEtc3;
  private String brdEtc4;
  private String brdEtc5;
  private ArrayList<BoardFileVO> fileList;

  public ArrayList<BoardFileVO> getFileList()
  {
    return this.fileList;
  }
  public void setFileList(ArrayList<BoardFileVO> fileList) {
    this.fileList = fileList;
  }
  public int getBrdFileSeq() {
    return this.brdFileSeq;
  }
  public void setBrdFileSeq(int brdFileSeq) {
    this.brdFileSeq = brdFileSeq;
  }
  public String getBrdFileOrgNm() {
    return this.brdFileOrgNm;
  }
  public void setBrdFileOrgNm(String brdFileOrgNm) {
    this.brdFileOrgNm = brdFileOrgNm;
  }
  public String getBrdDownUrl() {
    return this.brdDownUrl;
  }
  public void setBrdDownUrl(String brdDownUrl) {
    this.brdDownUrl = brdDownUrl;
  }
  public BoardFileVO getBean() {
    return this.bean;
  }
  public void setBean(BoardFileVO bean) {
    this.bean = bean;
  }
  public String getBrdFileNm() {
    return this.brdFileNm;
  }
  public void setBrdFileNm(String brdFileNm) {
    this.brdFileNm = brdFileNm;
  }
  public String getMyNbsp() {
    return this.myNbsp;
  }
  public void setMyNbsp(String myNbsp) {
    this.myNbsp = myNbsp;
  }
  public int getBrdNo() {
    return this.brdNo;
  }
  public void setBrdNo(int brdNo) {
    this.brdNo = brdNo;
  }

  public int getChangeBrdNo() {
    return this.changeBrdNo;
  }

  public void setChangeBrdNo(int changeBrdNo) {
    this.changeBrdNo = changeBrdNo;
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
  public String getBrdContClass() {
    return this.brdContClass;
  }
  public void setBrdContClass(String brdContClass) {
    this.brdContClass = brdContClass;
  }
  public String getBrdTitle() {
    return this.brdTitle;
  }
  public void setBrdTitle(String brdTitle) {
    this.brdTitle = brdTitle;
  }
  public String getBrdMkrNm() {
    return this.brdMkrNm;
  }
  public void setBrdMkrNm(String brdMkrNm) {
    this.brdMkrNm = brdMkrNm;
  }
  public String getBrdPwd() {
    return this.brdPwd;
  }
  public void setBrdPwd(String brdPwd) {
    this.brdPwd = brdPwd;
  }
  public String getBrdEml() {
    return this.brdEml;
  }
  public void setBrdEml(String brdEml) {
    this.brdEml = brdEml;
  }
  public String getBrdUrl() {
    return this.brdUrl;
  }
  public void setBrdUrl(String brdUrl) {
    this.brdUrl = brdUrl;
  }
  public String getBrdLock() {
    return this.brdLock;
  }
  public void setBrdLock(String brdLock) {
    this.brdLock = brdLock;
  }
  public String getBrdContents() {
    return this.brdContents;
  }
  public void setBrdContents(String brdContents) {
    this.brdContents = brdContents;
  }
  public String getBrdHtmlYn() {
    return this.brdHtmlYn;
  }
  public void setBrdHtmlYn(String brdHtmlYn) {
    this.brdHtmlYn = brdHtmlYn;
  }
  public int getBrdReadNum() {
    return this.brdReadNum;
  }
  public void setBrdReadNum(int brdReadNum) {
    this.brdReadNum = brdReadNum;
  }
  public String getRegDm() {
    return this.regDm;
  }
  public void setRegDm(String regDm) {
    this.regDm = regDm;
  }
  public String getBrdEtc1() {
    return this.brdEtc1;
  }
  public void setBrdEtc1(String brdEtc1) {
    this.brdEtc1 = brdEtc1;
  }
  public String getBrdEtc2() {
    return this.brdEtc2;
  }
  public void setBrdEtc2(String brdEtc2) {
    this.brdEtc2 = brdEtc2;
  }
  public String getBrdEtc3() {
    return this.brdEtc3;
  }
  public void setBrdEtc3(String brdEtc3) {
    this.brdEtc3 = brdEtc3;
  }
  public String getBrdEtc4() {
    return this.brdEtc4;
  }
  public void setBrdEtc4(String brdEtc4) {
    this.brdEtc4 = brdEtc4;
  }
  public String getBrdEtc5() {
    return this.brdEtc5;
  }
  public void setBrdEtc5(String brdEtc5) {
    this.brdEtc5 = brdEtc5;
  }
}
