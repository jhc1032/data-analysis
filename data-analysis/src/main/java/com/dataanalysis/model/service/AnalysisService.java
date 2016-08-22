package com.dataanalysis.model.service;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;

public interface AnalysisService {
	
	public List<TwitterData> getAllTwitter();
	public List<BlogData> getAllBlog() ;
	TwitterData getTwittersByWord(String word);
	BlogData getBlogsByWord(String word);
	TwitterData getTwittersByReTweetCount();

}
