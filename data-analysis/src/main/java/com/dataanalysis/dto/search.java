package com.dataanalysis.dto;

import java.util.Date;

public class search {
	
    private int search_no;
    private String word;
    private Date reg_date;
    private int member_no;
    
	public int getSearch_no() {
		return search_no;
	}
	public void setSearch_no(int search_no) {
		this.search_no = search_no;
	}
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
}
