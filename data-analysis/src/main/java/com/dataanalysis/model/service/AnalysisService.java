package com.dataanalysis.model.service;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;

public interface AnalysisService {
	
	public List<TwitterData> getAllTwitter();
	public List<BlogData> getAllBlog() ;
	public List<TwitterData>  getTwittersByWord();
	public List<BlogData> getBlogsByWord();
	public List<TwitterData> getTwittersByReTweetCount();
}
