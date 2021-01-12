package com.koticobui.dfmc.client.custom;

import com.koticobui.dfmc.client.com.model.PagingBean;
/*    */ import javax.servlet.jsp.JspException;
/*    */ import javax.servlet.jsp.JspWriter;
/*    */ import javax.servlet.jsp.PageContext;
/*    */ import javax.servlet.jsp.tagext.TagSupport;
	 
	 public class NewCustomPagingTag extends TagSupport
	 {
	   private static final long serialVersionUID = 1L;
	   private PagingBean pagingObj;
	   private String goListScript;
	 
	   public PagingBean getPagingObj()
	   {
	     return this.pagingObj;
	   }
	 
	   public void setPagingObj(PagingBean pagingObj)
	   {
	     this.pagingObj = pagingObj;
	   }
	 
	   public String getGoListScript()
	   {
	     if ((this.goListScript == null) || ("".equals(this.goListScript)))
	       this.goListScript = "goList";
	     return this.goListScript;
	   }
	 
	   public void setGoListScript(String goListScript)
	   {
	     this.goListScript = goListScript;
	   }
	 
	   public int doStartTag()
	     throws JspException
	   {
	     return 1;
	   }
	 
	   public int doEndTag()
	     throws JspException
	   {
	     try
	     {
	       StringBuffer tag = new StringBuffer();
	 
	       tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(this.pagingObj.getFirstPage()).append("\" class=\"pagination__arrow prev-full\" onclick=\"").append(getGoListScript()).append("('").append(this.pagingObj.getFirstPage()).append("', this);return false;\"></a>");
	       tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(this.pagingObj.getPrevPage()).append("\" class=\"pagination__arrow prev\" onclick=\"").append(getGoListScript()).append("('").append(this.pagingObj.getPrevPage()).append("', this);return false;\"></a>");
		   tag.append("<div class=\"pagination__number\">");
	       for (int i = this.pagingObj.getStartPage(); i <= this.pagingObj.getEndPage(); i++) {
	         if (i == this.pagingObj.getCurrentPage())
	           tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(i).append("\" class=\"active\" onclick=\"").append(getGoListScript()).append("('").append(i).append("', this);return false;\"title=\"").append(i).append(" 페이지\">").append(i + "</a>");
	         else
	           tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(i).append("\" onclick=\"").append(getGoListScript()).append("('").append(i).append("', this);return false;\"title=\"").append(i).append(" 페이지\">").append(i + "</a>");
	       }
	       tag.append("</div>");
	       tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(this.pagingObj.getNextPage()).append("\" class=\"pagination__arrow next\" onclick=\"").append(getGoListScript()).append("('").append(this.pagingObj.getNextPage()).append("', this);return false;\"></a>");
	       tag.append("<a href=\"javascript:void(0);\" data-page-no=\"").append(this.pagingObj.getLastPage()).append("\" class=\"pagination__arrow next-full\" onclick=\"").append(getGoListScript()).append("('").append(this.pagingObj.getLastPage()).append("', this);return false;\"></a>");
	 
	       this.pageContext.getOut().write(tag.toString());
	     }
	     catch (Exception e)
	     {
	       throw new JspException("IO Error : " + e.getMessage());
	     }
	     return 6;
	   }
 }
