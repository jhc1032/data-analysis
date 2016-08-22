package com.dataanalysis.mapper;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;


public interface AnalysisMapper {

	public List<TwitterData> selectAllTwitter();
	public List<BlogData> selectAllBlog();
	TwitterData getTwittersByWord(String word);
	BlogData getBlogsByWord(String word);
	TwitterData getTwittersByReTweetCount();
}
