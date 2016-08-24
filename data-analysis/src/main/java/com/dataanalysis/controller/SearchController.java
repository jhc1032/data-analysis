package com.dataanalysis.controller;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.net.SocketTimeoutException;
import java.net.URLEncoder;
import java.nio.file.FileSystemException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import javax.net.ssl.SSLHandshakeException;

import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dataanalysis.thread.SearchBlog;

@Controller
public class SearchController {

	@RequestMapping(value = "/search.action", method = RequestMethod.POST)
	public String search(@RequestParam("search") String search) {
		System.out.println(search);
		
		SearchBlog sb = new SearchBlog(search);
		sb.processSearch();
		
		return "list_test";
	}
	
}
