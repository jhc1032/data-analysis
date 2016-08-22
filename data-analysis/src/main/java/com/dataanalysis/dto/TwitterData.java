package com.dataanalysis.dto;

import java.util.Date;

public class TwitterData {
 private String tweetImg;
 private String tweetId;
 private String tweetName;
 private Date tweetTime;
 private String tweetText;
 private int reTweetCount;
 
public String getTweetImg() {
	return tweetImg;
}
public void setTweetImg(String tweetImg) {
	this.tweetImg = tweetImg;
}
public String getTweetId() {
	return tweetId;
}
public void setTweetId(String tweetId) {
	this.tweetId = tweetId;
}
public String getTweetName() {
	return tweetName;
}
public void setTweetName(String tweetName) {
	this.tweetName = tweetName;
}
public Date getTweetTime() {
	return tweetTime;
}
public void setTweetTime(Date tweetTime) {
	this.tweetTime = tweetTime;
}
public String getTweetText() {
	return tweetText;
}
public void setTweetText(String tweetText) {
	this.tweetText = tweetText;
}
public int getReTweetCount() {
	return reTweetCount;
}
public void setReTweetCount(int reTweetCount) {
	this.reTweetCount = reTweetCount;
}
 
}
