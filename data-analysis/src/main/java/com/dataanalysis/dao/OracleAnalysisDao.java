package com.dataanalysis.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;



@Repository(value = "oracleAnalysisDao")
public class OracleAnalysisDao implements AnalysisDao{

	//@Autowired
	//@Qualifier("memberMapper")
	//private AnalysisMapper analysisMapper;
	
	@Override
	public List<TwitterData> getAllTwitter() {
		
		//return analysisMapper.selectAllTwitter();
		
		//가져올 데이터가 없을경우 임의적으로 데이터 설정
		List<TwitterData> list = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			TwitterData t = new TwitterData();
			t.setTweetId("@D_evilive_D");
			t.setTweetName("*+✧ D•DOG✧+*");
			t.setTweetTime(new Date());
			t.setTweetText("RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도 있군요... http://twitter.com/RSTRY0...");
			t.setTweetImg("https://pbs.twimg.com/profile_images/760583347550625792/ccdmpqW1_normal.jpg");
			list.add(t);
		}
		
		return list;
	}

	@Override
	public List<BlogData> getAllBlog() {
		
		List<BlogData> list2 = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			
			
			BlogData b = new BlogData();
			b.setBlogTitle("blogTitle");
			//b.setBlogDate(new Date());
			b.setBlogText("RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도 있군요... http://twitter.com/RSTRY0...");
			b.setBlogURL("https://pbs.twimg.com/profile_images/760583347550625792/ccdmpqW1_normal.jpg");
			list2.add(b);
		}
		
		return list2;
	}

	@Override
	public List<TwitterData> getTwittersByWord() {
		//가져올 데이터가 없을경우 임의적으로 데이터 설정
		
		List<TwitterData> list = new ArrayList<>();
		
		for (int i = 0; i < 5; i++) {
			TwitterData t = new TwitterData();
			t.setTweetId("@D_evilive_D");
			t.setTweetName("*+✧ D•DOG✧+*");
			t.setTweetTime(new Date());
			t.setTweetText("RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도 있군요... http://twitter.com/RSTRY0...");
			t.setTweetImg("https://pbs.twimg.com/profile_images/760583347550625792/ccdmpqW1_normal.jpg");
			list.add(t);
		}
		
		return list;
	}

	@Override
	public List<BlogData> getBlogsByWord() {
		List<BlogData> list2 = new ArrayList<>();
		
		for (int i = 0; i < 5; i++) {
			BlogData b = new BlogData();
			b.setBlogTitle("blogTitle");
			//b.setBlogDate(new Date());
			b.setBlogText("BlogText");
			b.setBlogURL("https://pbs.twimg.com");
			list2.add(b);
		}
		
		return list2;
	}

	@Override
	public List<TwitterData> getTwittersByReTweetCount() {
		// TODO Auto-generated method stub
		return null;
	}





}
