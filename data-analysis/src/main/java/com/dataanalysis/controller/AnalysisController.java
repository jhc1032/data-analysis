package com.dataanalysis.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dataanalysis.dto.BlogData;
import com.dataanalysis.dto.TwitterData;
import com.dataanalysis.model.service.AnalysisService;
//데이터 베이스에서 트위터와 블로그 데이터 불러오기
@Controller
@RequestMapping(value = "/analysis/")
public class AnalysisController {

	@Autowired
	@Qualifier("analysisService")
	private AnalysisService analysisService;
	
	//전체 조회
	@RequestMapping(value = "list.action", method = RequestMethod.GET)
	public String list(Model model) {
		// 1. 데이터 조회 (dao 사용)
		List<TwitterData> twitters = analysisService.getAllTwitter();
		List<BlogData> blogs= analysisService.getAllBlog();

		// 2. 데이터 저장 (jsp에서 사용할 수 있도록)
		model.addAttribute("twitters", twitters);
		model.addAttribute("blogs", blogs);

		// 3. 뷰 반환
		return "list_test";
	}
		
	//keyword에 따른 조회
	@RequestMapping(value = "WordDataList.action", method = RequestMethod.GET)
	public String wordDataList(@RequestParam("word") String word, Model model){
		TwitterData wtwitters = analysisService.getTwittersByWord(word);
		BlogData wblogs = analysisService.getBlogsByWord(word);
		model.addAttribute("twitter", wtwitters);
		model.addAttribute("blog", wblogs);
		return "list_test";
	}
	
	
	
	//인기 트위터 조회
	@RequestMapping(value = "rtCountList.action", method = RequestMethod.GET)
	public String rtCountList(Model model){
		TwitterData cTwitters = analysisService.getTwittersByReTweetCount();
		model.addAttribute("twitter", cTwitters);

		return "list_test";
	
	}
		
	
}
		
		
		
		
		
		
	


