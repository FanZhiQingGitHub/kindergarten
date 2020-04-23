package com.great.kindergarten.admin.javabean;

import java.util.List;

public class PageBean<T> {

	/*
		当前页数，由用户指定

	 */
	private Integer currentPageNum;
	private Integer pageSize = 5 ;
	private Integer totalRecords;
	private Integer totalPageNum;
	private Integer prePageNum;
	private Integer nextPageNum;

	//扩展属性
	//一共每页显示5个页码按钮
	private Integer startPage;
	private Integer endPage;
			
	private List<T> list;
		
	//完善属性
	private String url;

	//要想使用分页，必须提供三个参数。一个是要看哪一页，一个是总记录条数，还要每页的记录数
	public PageBean(Integer currentPageNum, Integer totalRecords, Integer pageSize){
		this.currentPageNum = currentPageNum;
		this.totalRecords = totalRecords;
		this.pageSize = pageSize;

		//计算总页数
		if(totalRecords>pageSize) {
			totalPageNum = totalRecords%pageSize == 0?(totalRecords/pageSize):(totalRecords/pageSize+1);
		}else {
			totalPageNum = 1;
			}
		//把当前页码设置为中间页码，起始页码就是当前页码-2，结束页码为当前页码+2
		startPage = currentPageNum - 2;
		endPage = currentPageNum + 2;
		//看看总页数够不够5页
		if(totalPageNum>5){
			//超过了5页，
			//如果出现起始页码小于1的情况，统一设置为起始页面为1
			if(startPage < 1){
				startPage = 1;
				endPage = startPage+4;
			}
			//如果出现结束页码大于总页码的情况，那么将总页码设置为结束页码
			if(endPage>totalPageNum){
				endPage = totalPageNum;
				startPage = endPage-4;
			}
			}else{
				//不够5页
				startPage = 1;
				endPage = totalPageNum;
			}
		}

		public Integer getCurrentPageNum() {
			return currentPageNum;
		}

		public void setCurrentPageNum(Integer currentPageNum) {
			this.currentPageNum = currentPageNum;
		}

		public Integer getPageSize() {
			return pageSize;
		}

		public void setPageSize(Integer pageSize) {
			this.pageSize = pageSize;
		}

		public Integer getTotalRecords() {
			return totalRecords;
		}

		public void setTotalRecords(Integer totalRecords) {
			this.totalRecords = totalRecords;
		}

		public Integer getTotalPageNum() {
			return totalPageNum;
		}

		public void setTotalPageNum(Integer totalPageNum) {
			this.totalPageNum = totalPageNum;
		}

		public Integer getPrePageNum() {
			prePageNum = currentPageNum-1;
			if(prePageNum<1) {
				prePageNum = 1;
			}
			return prePageNum;
		}

		public void setPrePageNum(Integer prePageNum) {
			this.prePageNum = prePageNum;
		}

		public Integer getNextPageNum() {
			nextPageNum = currentPageNum+1;
			if(nextPageNum>totalPageNum) {
				nextPageNum = totalPageNum;
			}
			return nextPageNum;
		}

		public void setNextPageNum(Integer nextPageNum) {
			this.nextPageNum = nextPageNum;
		}

		public Integer getStartPage() {
			return startPage;
		}

		public void setStartPage(Integer startPage) {
			this.startPage = startPage;
		}

		public Integer getEndPage() {
			return endPage;
		}

		public void setEndPage(Integer endPage) {
			this.endPage = endPage;
		}

		public List<T> getList() {
			return list;
		}

		public void setList(List<T> list) {
			this.list = list;
		}

}
