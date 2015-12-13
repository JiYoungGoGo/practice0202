package org.jy.domain;

public class Criteria {

	private int page;
	private int perPageNum;
	
	public Criteria(){
		this.page=1;
		this.perPageNum=10;
		
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page<1){
			page=1;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum<=0||perPageNum>100){
			this.perPageNum=10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]/n";
	}
	
	
	
}
