package com.dataanalysis.thread;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
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

import com.dataanalysis.dto.BlogData;

public class Test {
	
	private int totalNum;
	private ArrayList<BlogData> blogDatas;
	
	public int getSearchWidth(String search) throws Exception {
		String query = URLEncoder.encode(search, "UTF-8");
		String url = "https://search.naver.com/search.naver?where=post&sm=tab_jum&ie=utf8&query=" + query + "&start=1";
		
		Document forTotal = Jsoup.connect(url)
				.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
		Elements totalSearched = forTotal.select(".title_num");
		String[] array = new String[2];
		array = totalSearched.get(0).text().split("/");
		totalNum = getTotalSearched(array[1].trim());
		if (totalNum > 500) {
			totalNum = 500;
		}
		int searchWidth = (((totalNum / 10) * 10)/200) * 10 + 1;
	
		return searchWidth;
	}
	
	public void search(String search, int pageNo, int searchWidth, String fileName) throws Exception {
		boolean flag = false;
		String query = URLEncoder.encode(search, "UTF-8");
		Date curDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String myCurDate = sdf.format(curDate);
		int num = 0;
		int order = 0;
		 String url =
		 "https://search.naver.com/search.naver?where=post&sm=tab_jum&ie=utf8&query="
		 + query
		 + "&date_from=20030520&date_to=" + myCurDate +
		 "&date_option=4&start=" + pageNo;
//		String url = "https://search.naver.com/search.naver?where=post&sm=tab_jum&ie=utf8&query=" + query + "&start="
//				+ pageNo;
		String[] urlArr = new String[10];

		BufferedWriter out = new BufferedWriter(new FileWriter("C:/Users/stu15/Desktop/test/" + fileName +".txt"));

		
		while (pageNo != searchWidth) {
			System.out.println("pageNo : " + pageNo);
			System.out.println("searchWidth : " + searchWidth); 
			try {
				new Thread();
				Thread.sleep(100);
				Document doc = Jsoup
						.connect("https://search.naver.com/search.naver?where=post&sm=tab_jum&ie=utf8&query="
								 + query
								 + "&date_from=20030520&date_to=" + myCurDate +
								 "&date_option=4&start=" + pageNo)
						.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36")
						.get();

				Elements liList = doc.select("#elThumbnailResultArea li");
				for (Element e : liList) {
					order++;
					String blogUrl = e.select("a").attr("href");
					// urlArr.add(blogUrl);
					urlArr[num] = blogUrl;
					System.out.println(order + "번째: " + blogUrl);
					num++;
					
					String title = e.select("a").attr("title");
					String date = e.select(".txt_inline").text();
					String content = e.select(".sh_blog_passage").text();
					
					BlogData bd = new BlogData();
					bd.setBlogTitle(title);
					bd.setBlogText(content);
					bd.setBlogURL(blogUrl);
					bd.setblogDate(date);
					blogDatas.add(bd);
					
				}

				for (String str : urlArr) {
					if (str == null) {
						flag = true;
						break;
					}

					if (str.contains("blog.naver.com")) {
						new Thread();
						Thread.sleep(100);
						Document doc2 = Jsoup.connect(str)
								.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
						Elements list = doc2.select("frame");
						for (Element e2 : list) {
							if (e2.attr("id").equals("mainFrame")) {
								// System.out.println("mainFrame" +
								// e2.attr("src"));
								Document doc3 = Jsoup.connect("http://blog.naver.com" + e2.attr("src"))
										.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
								Elements list2 = doc3.select("#postListBody p");
								new Thread();
								Thread.sleep(100);
								for (Element e3 : list2) {
									out.write(e3.text());
									out.newLine();
									new Thread();
									Thread.sleep(100);

									// System.out.println(e3.text());
								}

							} else if (e2.attr("id").equals("screenFrame")) {
								new Thread();
								Thread.sleep(100);
								Document doc4 = Jsoup.connect(e2.attr("src"))
										.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
								Elements list3 = doc4.select("#mainFrame");
								for (Element e3 : list3) {
									// System.out.println("screenFrame" +
									// e3.attr("src"));
									new Thread();
									Thread.sleep(100);
									Document doc5 = Jsoup.connect("http://blog.naver.com" + e3.attr("src"))
											.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
									Elements list4 = doc5.select("#postListBody p");
									for (Element e4 : list4) {
										out.write(e4.text());
										out.newLine();
										new Thread();
										Thread.sleep(100);

										// System.out.println(e4.text());
									}
								}
							}
						}
					} else {
						Document doc6 = Jsoup.connect(str)
								.userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
						Elements list5 = doc6.select("p");
						for (Element e5 : list5) {
							out.write(e5.text());
							out.newLine();
							new Thread();
							Thread.sleep(100);
						}
					}

				}
				if (flag)
					break;

			} catch (FileSystemException fe) {
				System.out.println("file error");
			} catch (SocketTimeoutException se) {
				System.out.println("timeout error");
			} catch (HttpStatusException hse) {
				System.out.println("404 error at " + hse.getUrl());
			} catch (SSLHandshakeException sse) {
				System.out.println("SSLHandshakeException: " + sse.getMessage());
			}
			num = 0;
			pageNo += 10;

		}
		out.close();
		Thread.interrupted();
	}

	public int getTotalSearched(String str) {

		String total = "";
		int totalLength = 0;
		int totalSearched = 0;
		StringTokenizer st = new StringTokenizer(str, ",");
		ArrayList<String> strArr = new ArrayList<>();
		while (st.hasMoreTokens()) {
			String temp = st.nextToken();
			strArr.add(temp);
		}
		for (String s : strArr) {
			totalLength += s.length();
			total += s;
		}
		totalSearched = Integer.valueOf(total.substring(0, totalLength - 1));

		return totalSearched;
	}
	
	public void mergeFiles() {
		
		String[] filePaths = new String[20];
		filePaths[0] = "C:/Users/stu15/Desktop/test/testA.txt";
		filePaths[1] = "C:/Users/stu15/Desktop/test/testB.txt";
		filePaths[2] = "C:/Users/stu15/Desktop/test/testC.txt";
		filePaths[3] = "C:/Users/stu15/Desktop/test/testD.txt";
		filePaths[4] = "C:/Users/stu15/Desktop/test/testE.txt";
		for(int i=0; i<15; i++) {
			filePaths[i+5] = "C:/Users/stu15/Desktop/test/test" + (i+1) + ".txt";
		}
		
//		String readFilePath1 = "/Users/jeonghyeoncheol/Desktop/test/testA.txt";
//		String readFilePath2 = "/Users/jeonghyeoncheol/Desktop/test/testB.txt";
//		String readFilePath3 = "/Users/jeonghyeoncheol/Desktop/test/testC.txt";
//		String readFilePath4 = "/Users/jeonghyeoncheol/Desktop/test/testD.txt";
//		String readFilePath5 = "/Users/jeonghyeoncheol/Desktop/test/testE.txt";
//		String readFilePath6 = "/Users/jeonghyeoncheol/Desktop/test/test1.txt";
//		String readFilePath7 = "/Users/jeonghyeoncheol/Desktop/test/test2.txt";
//		String readFilePath8 = "/Users/jeonghyeoncheol/Desktop/test/test3.txt";
//		String readFilePath9 = "/Users/jeonghyeoncheol/Desktop/test/test4.txt";
//		String readFilePath10 = "/Users/jeonghyeoncheol/Desktop/test/test5.txt";
//		String readFilePath11 = "/Users/jeonghyeoncheol/Desktop/test/test6.txt";
//		String readFilePath12 = "/Users/jeonghyeoncheol/Desktop/test/test7.txt";
//		String readFilePath13 = "/Users/jeonghyeoncheol/Desktop/test/test8.txt";
//		String readFilePath14 = "/Users/jeonghyeoncheol/Desktop/test/test9.txt";
//		String readFilePath15 = "/Users/jeonghyeoncheol/Desktop/test/test10.txt";
//		String readFilePath16 = "/Users/jeonghyeoncheol/Desktop/test/test11.txt";
//		String readFilePath17 = "/Users/jeonghyeoncheol/Desktop/test/test12.txt";
//		String readFilePath18 = "/Users/jeonghyeoncheol/Desktop/test/test13.txt";
//		String readFilePath19 = "/Users/jeonghyeoncheol/Desktop/test/test14.txt";
//		String readFilePath20 = "/Users/jeonghyeoncheol/Desktop/test/test15.txt";
		
		String writeFilePath = "C:/Users/stu15/Desktop/test/sample.txt";
		
		File[] files = new File[20];
		for(int i=0; i<20; i++) {
			files[i] = new File(filePaths[i]);
		}
//		files[0] = new File(readFilePath1);
//		files[1] = new File(readFilePath2);
//		files[2] = new File(readFilePath3);
//		
		File writeFile = new File(writeFilePath);
		
		FileWriter fstream = null;
		BufferedWriter out = null;
		try {
			fstream = new FileWriter(writeFile, true);
			out = new BufferedWriter(fstream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		for (File f : files) {
			System.out.println("merging: " + f.getName());
			FileInputStream fis;
			try {
				fis = new FileInputStream(f);
				BufferedReader in = new BufferedReader(new InputStreamReader(fis));
				
				String aLine;
				while ((aLine = in.readLine()) != null) {
					out.write(aLine);
					out.newLine();
				}
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		try {
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
