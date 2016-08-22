package com.dataanalysis.mapper;

import java.util.List;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;


public interface AnalysisMapper {

	public List<TwitterData> selectAllTwitter();
	public List<BlogData> selectAllBlog();
	public List<TwitterData> selectTwittersByWord();
	public List<BlogData> selectBlogsByWord();
	public List<TwitterData> selectTwittersByReTweetCount();
}
