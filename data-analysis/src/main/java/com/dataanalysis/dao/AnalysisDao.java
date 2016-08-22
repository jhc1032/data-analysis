package com.dataanalysis.dao;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;



public interface AnalysisDao {

	List<TwitterData> getAllTwitter();
	List<BlogData> getAllBlog() ;
	TwitterData getTwittersByWord(String word);
	BlogData getBlogsByWord(String word);
	TwitterData getTwittersByReTweetCount();
	//키워드로 찾는것과 rtTweetCount별로 나열이 필요
	
}
