package com.dataanalysis.thread;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.SocketTimeoutException;
import java.net.URLEncoder;
import java.nio.file.FileSystemException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.net.ssl.SSLHandshakeException;

import org.jsoup.Connection;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

public class TweetData {
	
	public void tweetText(String search) {
		// public static void main(String ar[]) {
		AccessToken accesstoken = new AccessToken("763609684230049792-G8lhmJLlZn2njlTIrQ0QMIF9x9rSH4u",
				"NdCLfdIUkxzqYGrdRwEr9r9o0YcjZZ9C4s2wVaaGrySgR");
		Twitter twitter = TwitterFactory.getSingleton();
		twitter.setOAuthConsumer("HG9vqIgC2PCGvmnvot9x6kcPX", "HUqa0rWXegiAKBV5YtsKNiWINOidh0WgKLZlcWGfHnFdzoLh2L");
		twitter.setOAuthAccessToken(accesstoken);

		String str = "";

		long lowestStatusId = Long.MAX_VALUE;
		boolean finished = false;
		int counter = 0;
		int max = 10;

		try {

			User user = twitter.verifyCredentials();
			Query query = new Query(URLEncoder.encode(search, "UTF-8"));
			QueryResult result;

			while (!finished) {
				result = twitter.search(query);
				List<Status> tweets = result.getTweets();

				for (Status tweet : tweets) {
					
					System.out.println("------------------------------------------------------");
					System.out.println("@" + tweet.getUser().getScreenName() + " - " + tweet.getText());
					lowestStatusId = Math.min(tweet.getId(), lowestStatusId);

					str += tweet.getText();
					
//					out.write(tweet.getText());
//					out.newLine();
//					
//					TweetData td = new TweetData();
//					td.setTitle(title);
//					
//					tweetDatas.add(td);
				}

				query.setMaxId(lowestStatusId - 1);
				counter++;
				if (counter >= max)
					finished = true;
			}

			// System.exit(0);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Failed to search tweets: " + e.getMessage());
			System.exit(-1);
		}

	}


	public void search() throws Exception {

		//String query = URLEncoder.encode(search, "UTF-8");
		Date curDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String myCurDate = sdf.format(curDate);

//		BufferedWriter out = new BufferedWriter(
//				new FileWriter("/Users/jeonghyeoncheol/Desktop/test2/" + fileName + ".txt"));
		
		

		try {
			new Thread();
			Thread.sleep(100);
			Document doc = Jsoup.connect("https://twitter.com/search?q=spring%20since%3A2016-07-22%20until%3A2016-08-22&src=typd")
					.get();

			Elements eles = doc.select(".js-tweet-text-container");
			for (Element e : eles) {
				System.out.println(e.text());
			}

		} catch (FileSystemException fe) {
			System.out.println("file error");
		} catch (SocketTimeoutException se) {
			System.out.println("timeout error");
		} catch (HttpStatusException hse) {
			System.out.println("404 error at " + hse.getUrl());
		} catch (SSLHandshakeException sse) {
			System.out.println("SSLHandshakeException: " + sse.getMessage());
		}
//		out.close();
	}

	public int getTotalSearched() {

		int total = 0;
		
		try {
			Connection conn = Jsoup.connect("https://twitter.com/search?q=spring%20since%3A2016-07-22%20until%3A2016-08-22&src=typd");
			Document doc1 = conn.get();
			Document doc = Jsoup.connect("https://twitter.com/search?q=spring%20since%3A2016-07-22%20until%3A2016-08-22&src=typd")
					.get();
			Elements eles = doc1.select(".js-tweet-text-container");
			total = eles.size();
			Elements eles2 = doc.select(".js-tweet-text-container");
			
			System.out.println(total);
			System.out.println(eles2.size());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return total;
		
	}

	public void mergeFiles() {

		String[] filePaths = new String[20];
		for (int i = 0; i < 15; i++) {
			filePaths[i] = "/Users/jeonghyeoncheol/Desktop/test/test" + (i + 1) + ".txt";
		}

		// String readFilePath1 =
		// "/Users/jeonghyeoncheol/Desktop/test/testA.txt";
		// String readFilePath2 =
		// "/Users/jeonghyeoncheol/Desktop/test/testB.txt";
		// String readFilePath3 =
		// "/Users/jeonghyeoncheol/Desktop/test/testC.txt";
		// String readFilePath4 =
		// "/Users/jeonghyeoncheol/Desktop/test/testD.txt";
		// String readFilePath5 =
		// "/Users/jeonghyeoncheol/Desktop/test/testE.txt";
		// String readFilePath6 =
		// "/Users/jeonghyeoncheol/Desktop/test/test1.txt";
		// String readFilePath7 =
		// "/Users/jeonghyeoncheol/Desktop/test/test2.txt";
		// String readFilePath8 =
		// "/Users/jeonghyeoncheol/Desktop/test/test3.txt";
		// String readFilePath9 =
		// "/Users/jeonghyeoncheol/Desktop/test/test4.txt";
		// String readFilePath10 =
		// "/Users/jeonghyeoncheol/Desktop/test/test5.txt";
		// String readFilePath11 =
		// "/Users/jeonghyeoncheol/Desktop/test/test6.txt";
		// String readFilePath12 =
		// "/Users/jeonghyeoncheol/Desktop/test/test7.txt";
		// String readFilePath13 =
		// "/Users/jeonghyeoncheol/Desktop/test/test8.txt";
		// String readFilePath14 =
		// "/Users/jeonghyeoncheol/Desktop/test/test9.txt";
		// String readFilePath15 =
		// "/Users/jeonghyeoncheol/Desktop/test/test10.txt";
		// String readFilePath16 =
		// "/Users/jeonghyeoncheol/Desktop/test/test11.txt";
		// String readFilePath17 =
		// "/Users/jeonghyeoncheol/Desktop/test/test12.txt";
		// String readFilePath18 =
		// "/Users/jeonghyeoncheol/Desktop/test/test13.txt";
		// String readFilePath19 =
		// "/Users/jeonghyeoncheol/Desktop/test/test14.txt";
		// String readFilePath20 =
		// "/Users/jeonghyeoncheol/Desktop/test/test15.txt";

		String writeFilePath = "/Users/jeonghyeoncheol/Desktop/test/sample.txt";

		File[] files = new File[15];
		for (int i = 0; i < 15; i++) {
			files[i] = new File(filePaths[i]);
		}
		// files[0] = new File(readFilePath1);
		// files[1] = new File(readFilePath2);
		// files[2] = new File(readFilePath3);
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
