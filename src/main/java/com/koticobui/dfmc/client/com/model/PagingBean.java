package com.koticobui.dfmc.client.com.model;


/**
 * The type Discount item vo.
 */
public class PagingBean {
	


	  private int currentPage;
	  private int totalCount;
	  private int totalPage;
	  private int startPage;
	  private int endPage;
	  private int articleCount = 20;
	  private int pageCount = 10;
	  private int rowNum;

	  public int getCurrentPage()
	  {
	    if (this.currentPage == 0) {
	      return 1;
	    }

	    return this.currentPage;
	  }

	  public void setCurrentPage(int currentPage) {
	    this.currentPage = currentPage;
	  }
	  public int getTotalCount() {
	    return this.totalCount;
	  }

	  public void setTotalCount(int totalCount) {
	    if (totalCount < this.articleCount) {
	      this.totalPage = 1;
	    }
	    else if (totalCount % this.articleCount == 0) {
	      this.totalPage = (totalCount / this.articleCount);
	    }
	    else {
	      this.totalPage = (totalCount / this.articleCount + 1);
	    }

	    if (this.totalPage <= this.pageCount) {
	      this.startPage = 1;
	      this.endPage = this.totalPage;
	    }
	    else {
	      this.startPage = ((getCurrentPage() - 1) / this.pageCount * this.pageCount + 1);
	      this.endPage = (this.startPage + this.pageCount - 1);
	      if (this.endPage > this.totalPage) {
	        this.endPage = this.totalPage;
	      }
	    }

	    this.totalCount = totalCount;

	    this.rowNum = (this.totalCount - (getCurrentPage() - 1) * this.articleCount);
	  }
	  public int getPageCount() {
	    return this.pageCount;
	  }
	  public void setPageCount(int pageCount) {
	    this.pageCount = pageCount;
	  }
	  public int getTotalPage() {
	    return this.totalPage;
	  }
	  public void setTotalPage(int totalPage) {
	    this.totalPage = totalPage;
	  }
	  public int getArticleCount() {
	    return this.articleCount;
	  }
	  public void setArticleCount(int articleCount) {
	    this.articleCount = articleCount;
	  }
	  public int getStartPage() {
	    return this.startPage;
	  }
	  public int getEndPage() {
	    return this.endPage;
	  }

	  public int getBeginArticleNum()
	  {
	    return (getCurrentPage() - 1) * this.articleCount;
	  }
	  public int getEndArticleNum() {
	    return getCurrentPage() * this.articleCount;
	  }

	  public int getPrevPage() {
	    if (getCurrentPage() == 1) {
	      return -1;
	    }

	    return (getCurrentPage() - this.pageCount - 1) / this.pageCount * this.pageCount + 1;
	  }

	  public int getNextPage() {
	    if (getCurrentPage() == getTotalPage()) {
	      return -2;
	    }

	    int nextPage = (getCurrentPage() + this.pageCount - 1) / this.pageCount * this.pageCount + 1;
	    if (nextPage > this.totalPage) {
	      nextPage = this.totalPage;
	    }
	    return nextPage;
	  }

	  public int getFirstPage() {
	    if (getCurrentPage() == 1) {
	      return -1;
	    }

	    return 1;
	  }

	  public int getLastPage() {
	    if (getCurrentPage() == getTotalPage()) {
	      return -2;
	    }

	    return getTotalPage();
	  }

	  public int getRowNum() {
	    return this.rowNum;
	  }
	  public void setRowNum(int rowNum) {
	    this.rowNum = rowNum;
	  }
}
