package com.dataanalysis.controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

import org.rosuda.JRI.Rengine;

public class testR{

	public static void main (String[] args) 
    {
         System.out.println("Creating Rengine (with arguments)");
         String[] Rargs = {"--vanilla"};
         Rengine re = new Rengine(Rargs, false, null);
         System.out.println("Rengine created, waiting for R");

         if (!re.waitForR()) {
              System.out.println("Cannot load R");
	return;
         }

         re.eval("library(fpc)");
         re.eval("library(ggplot2)");
         re.eval("library(base64enc)");
         re.eval("library(RCurl)");
         re.eval("library(twitteR)");
         re.eval("library(ROAuth)");
         re.eval("library(Unicode)");
         re.eval("library(plyr)");
         re.eval("library(KoNLP)");
         re.eval("library(wordcloud)");
         re.eval("library(tm)");
         re.eval("library(RColorBrewer)");
         re.eval("setwd(\"C:/BigData/Lab/R/data\")");
         System.out.println("hello");
         
         ///////////////////////////////////////////////////////////////////////////////////////

         //#URL값 변수에 지정
         re.eval("reqURL <- \"https://api.twitter.com/oauth/request_token\"");
         re.eval("accessURL <- \"https://api.twitter.com/oauth/access_token\"");
         re.eval("authURL <- \"https://api.twitter.com/oauth/authorize\"");

         //#트위터에서 받은 네 개의 키 값을 변수에 할당
         re.eval("consumerKey <- \"HG9vqIgC2PCGvmnvot9x6kcPX\"");
         re.eval("consumerSecret <- \"HUqa0rWXegiAKBV5YtsKNiWINOidh0WgKLZlcWGfHnFdzoLh2L\"");
         re.eval("accesstoken <- \"763609684230049792-G8lhmJLlZn2njlTIrQ0QMIF9x9rSH4u\"");
         re.eval("accesstokenSecret <- \"NdCLfdIUkxzqYGrdRwEr9r9o0YcjZZ9C4s2wVaaGrySgR\"");

         re.eval("options(RCurlOptions = list(cainfo = system.file(\"CurlSSL\",\"cacert.pem\",package = \"RCurl\")))");
         re.eval("download.file(url=\"https://curl.haxx.se/ca/cacert.pem\", destfile = \"cacert.pem\")");

         //#인증 처리
         re.eval("setup_twitter_oauth(consumerKey, consumerSecret, accesstoken, accesstokenSecret)");

         //#해당 단어를 언급한 글을 가져오자
         re.eval("keyword <- enc2utf8(\"리우올림픽\")");
         re.eval("tweet_data <- searchTwitter(keyword,lang='ko',n=500)");
         System.out.println("TWEET OK");


         //#결과 중 텍스트에 해당하는 부분만 뽑기
         re.eval("tweet_result.df <- twListToDF(tweet_data)");
         re.eval("tweet_result.text <- tweet_result.df$text");
         re.eval("head(tweet_result.text)");

         //#불필요한 문자 거르기
         re.eval("tweet_result.text <- gsub('\n','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('\r','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('RT','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('https','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('ㅋ','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('ㅠ','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('ㅜ','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('[[:punct:]]','',tweet_result.text)"); 
         re.eval("tweet_result.text <- gsub('@[[:graph:]]*','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('[A-z]','',tweet_result.text)");
         re.eval("tweet_result.text <- gsub('\\d+','',tweet_result.text)");
         re.eval("tweet_result.text");

         //#문자 분리
         re.eval("tweet_result_nouns <- Map(extractNoun, tweet_result.text)");
         re.eval("tweet_result_nouns");


         //#쓸모없는 문자 제거
         re.eval("tweet_result_wordsvec <- unlist(tweet_result_nouns, use.names = F)");
         re.eval("tweet_result_wordsvec <- Filter(function(x){nchar(x)>=2}, tweet_result_wordsvec)");
         re.eval("tweet_result_wordsvec");

         re.eval("NROW(tweet_result_wordsvec)");
         re.eval("write(tweet_result_wordsvec, \"tweet_data.txt\")");
         re.eval("tweet_data2 <- read.table(\"tweet_data.txt\")");
         re.eval("tweet_wordcount <- table(tweet_data2)");
         re.eval("tweet_top10 <- head(sort(tweet_wordcount, decreasing = T),10)");

/*
         //#컬러 세팅
         re.eval("pal <- brewer.pal(8,\"Set2\")");

         //#워드 클라우드 그리기
         //re.eval("dev.new()");
         re.eval("wordcloud(names(tweet_wordcount), freq=tweet_wordcount, scale=c(5,1),min.freq=10, random.order=F, rot.per=.25, random.color=T,colors=pal)");

         re.eval("savePlot(\"tweet_wordcloud.png\", type=\"png\")");
         //re.eval("plot.new()");
*/
         /*//#bar 형태의 그래프 그리기
         re.eval("tweet_top10");
         re.eval("tweet_max <- max(tweet_top10)");
         re.eval("tweet_bp <- barplot(tweet_top10, main= \"트위터 검색어 top10\", col=rainbow(10),cex.names=0.7,las=2,ylim=c(0,tweet_max+200))");
         re.eval("tweet_pct <- round(tweet_top10/sum(tweet_top10)*100,1)");
         re.eval("tweet_pct");

         //#비율, 건수 표
         re.eval("text(x=tweet_bp, y=tweet_top10*1.05, labels=paste(\"(\",tweet_pct,\"%\",\")\"), col=\"black\",cex=0.7)");
         re.eval("text(x=tweet_bp, y=tweet_top10*0.95, labels=paste(tweet_top10,\"건\"), col=\"black\",cex=0.7)");

         re.eval("savePlot(\"tweet_barplot.png\", type=\"png\")");
         re.eval("plot.new()");

         //#pie형 그래프 그리기
         re.eval("tweet_top10");
         re.eval("tweet_pct");
         re.eval("names(tweet_top10)");
         re.eval("tweet_lab <- paste(names(tweet_top10),\"\n\",tweet_pct,\"%\")");
         re.eval("pie(tweet_top10, main=\"트위터 검색어 top10\", col=rainbow(10),cex=0.8,labels=tweet_lab)");
         re.eval("savePlot(\"tweet_pie.png\", type=\"png\")");


         //#감성분석
         re.eval("tweet_text <- laply(tweet_data, function(t)t$getText())");
         re.eval("tweet_text <- tweet_text[Encoding(tweet_text)==\"UTF-8\"]");
         re.eval("tweet_text <- gsub('\\x','',tweet_text)");
         re.eval("tweet_text <- tweet_text[-4]");
         re.eval("head(tweet_text)");

         re.eval("tweet_df <- as.data.frame(tweet_text)");
         re.eval("View(tweet_df)");

         re.eval("pos.word = scan(\"positive-words-ko-v2.txt\", encoding = \"UTF-8\", what=\"character\",comment.char=\";\")");
         re.eval("neg.word = scan(\"negative-words-ko-v2.txt\", encoding = \"UTF-8\", what=\"character\",comment.char=\";\")");

         re.eval("tweet_score=score.sentiment(tweet_text, pos.word, neg.word, .progress='text')");
         re.eval("hist(tweet_score$score)");*/
         
   }
}
