package com.dataanalysis.dao;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;



public interface AnalysisDao {

	List<TwitterData> getAllTwitter();
	List<BlogData> getAllBlog() ;
	List<TwitterData>  getTwittersByWord();
	List<BlogData> getBlogsByWord();
	List<TwitterData> getTwittersByReTweetCount();
	
}
