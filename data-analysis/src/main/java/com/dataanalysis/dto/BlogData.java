package com.dataanalysis.dto;

import java.util.Date;

public class BlogData {
	
 private String blogTitle;
 private Date blogDate;
 private String blogText;
 private String blogURL;
 
public String getBlogTitle() {
	return blogTitle;
}
public void setBlogTitle(String blogTitle) {
	this.blogTitle = blogTitle;
}
public Date getBlogDate() {
	return blogDate;
}
public void setBlogDate(Date blogDate) {
	this.blogDate = blogDate;
}
public String getBlogText() {
	return blogText;
}
public void setBlogText(String blogText) {
	this.blogText = blogText;
}
public String getBlogURL() {
	return blogURL;
}
public void setBlogURL(String blogURL) {
	this.blogURL = blogURL;
}
}
