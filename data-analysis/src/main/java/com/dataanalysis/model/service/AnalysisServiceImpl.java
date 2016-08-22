package com.dataanalysis.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.dataanalysis.dao.AnalysisDao;
import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;

@Service("analysisService")
public class AnalysisServiceImpl implements AnalysisService {
	
	@Autowired
	@Qualifier("oracleAnalysisDao")
	private AnalysisDao analysisDao;

	@Override
	public List<TwitterData> getAllTwitter() {
		
		return analysisDao.getAllTwitter();
	}

	@Override
	public List<BlogData> getAllBlog() {
		
		return analysisDao.getAllBlog();
	}

	@Override
	public TwitterData getTwittersByWord(String word) {
		
		return analysisDao.getTwittersByWord(word);
	}

	@Override
	public BlogData getBlogsByWord(String word) {
		// TODO Auto-generated method stub
		return analysisDao.getBlogsByWord(word);
	}

	@Override
	public TwitterData getTwittersByReTweetCount() {
		// TODO Auto-generated method stub
		return analysisDao.getTwittersByReTweetCount();
	}

}
