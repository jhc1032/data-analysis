<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta http-equiv="content-Script-type" content="text/javascript">
<meta http-equiv="content-Style-type" content="text/css">
<title>bigdata</title>
<link rel="stylesheet" href="/scheduler/resources/css/index.css" type="text/css">
<link rel="stylesheet" href="/scheduler/resources/css/website.css" type="text/css" media="screen">
<script type="text/javascript" async=""	src="http://www.google-analytics.com/ga.js"></script>
<script type="text/javascript" src="/scheduler/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/scheduler/resources/js/ui/effects.core.js"></script>
<!-- 탭부분  스크립트-->
<script type="text/javascript" src="/scheduler/resources/js/jquery-ui.js"></script>
<script type="text/javascript" 	src="/scheduler/resources/js/jquery.tinyscrollbar.min.js"></script>
<script type="text/javascript" src="/scheduler/resources/js/util.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		bindTweetBtnClickEvent();
		bindDocumentSearch();
		bindMoreDocumentSearch();
		loadTweetDocument('');
		loadBlogDocument('');
		loadTweetRtDocument('');
		$(".recentTweet").show();
		$(".rtTweet").hide();
		$(".btnArea li:first").css("text-decoration", "underline");
		$(".btnArea2 li:first").css("text-decoration", "underline");
		bindChangeTweetOrder();
		bindSearchKeyword();
	});
	var bindTweetBtnClickEvent = function() {
		$('li.retweetBtn a,li.replyBtn a,li.followBtn a').live(
				'click',
				function() {
					var href = $(this).attr('href');
					window.open(href, '_blank',
							'width=710,height=400,scrollbars=0,,location=0');
					return false;
				});
	};

	var bindDocumentSearch = function() {
		$(".overview dd > a").live('click', function() {
			var association = $(this).text();
			popKeyWd(association);
		});
	};

	var bindMoreDocumentSearch = function() {
		$(".moreTweet").live('click', function() {
			pagingDocument($(this));
		});
	};

	var bindChangeTweetOrder = function() {
		$(".btnArea a").click(
				function() {
					var parent = $(this).parent().parent().children().each(
							function(index, elm) {
								$(elm).css("text-decoration", "none");
							});
					$(this).parent().css("text-decoration", "underline");
					var order = $(this).attr("order");
					if (order == 'recent') {
						$(this).parent().parent().parent().children(
								".recentTweet").show();
						$(this).parent().parent().parent().children(".rtTweet")
								.hide();
					} else {
						$(this).parent().parent().parent().children(
								".recentTweet").hide();
						$(this).parent().parent().parent().children(".rtTweet")
								.show();
					}
				});
		$(".btnArea2 a").click(
				function() {
					var parent = $(this).parent().parent().children().each(
							function(index, elm) {
								$(elm).css("text-decoration", "none");
							});
					$(this).parent().css("text-decoration", "underline");
					var order = $(this).attr("order");
					if (order == 'recent') {
						$(this).parent().parent().parent().children(
								".recentTweet").show();
						$(this).parent().parent().parent().children(".rtTweet")
								.hide();
					} else {
						$(this).parent().parent().parent().children(
								".recentTweet").hide();
						$(this).parent().parent().parent().children(".rtTweet")
								.show();
					}
				});
	}

	var loadTweetDocument = function(association) {
		var keyword = '너무예뻐';

		var url = "/socialSearch/document_ajax.html";
		var params = {
			keyword : keyword,
			association : association
		};
		/* $("#innerTweet1")
				.html(
						"<div class='loading'><img src='/scheduler/resources/images/loading2.gif'></div>"); */
		$("#innerTweet1").load(
				url,
				$.param(params),
				function(data) {
					var tempTag = '<div id="temp"></div>';
					var $newHtml = $(tempTag).append(data);
					var newList = $newHtml.children(".tweetBox").toArray();
					var tweetCount = 0;
					var pageNum = -1;
					if (newList.length > 1) {
						tweetCount = $(newList[0]).attr("count");
						pageNum = $(newList[0]).attr("pageNum");
					}
					;
					$("#tweetCount").html(formatNumber(tweetCount) + '건');
					$(".tweetCount").html(formatNumber(tweetCount) + '건');
					$("#tweetCount").attr("count", tweetCount);

					$("#innerTweet2").html(data);

					if (pageNum == -1) {
						$("#innerTweet1").parent().children(
								".moreTweet[order=recent]").css('display',
								'none');
						$("#innerTweet2").parent().children(
								".moreTweet[order=recent]").css('display',
								'none');

						$("#innerTweet1").parent().children(
								".moreTweet[order=recent]").removeClass(
								'recentTweet');
						$("#innerTweet2").parent().children(
								".moreTweet[order=recent]").removeClass(
								'recentTweet');
					} else {
						$("#innerTweet1").parent().children(
								".moreTweet[order=recent]").attr("pageNum",
								pageNum);
						$("#innerTweet2").parent().children(
								".moreTweet[order=recent]").attr("pageNum",
								pageNum);
					}
				});
	};

	var loadTweetRtDocument = function(association) {
		var keyword = '너무예뻐';

		var url = "/socialSearch/document_ajax.html";
		var params = {
			keyword : keyword,
			association : association,
			order : 'rt'
		};
		/* $("#innerRtTweet1")
				.html(
						"<div class='loading'><img src='/scheduler/resources/images/loading2.gif'></div>"); */
		$("#innerRtTweet1").load(
				url,
				$.param(params),
				function(data) {
					var tempTag = '<div id="temp"></div>';
					var $newHtml = $(tempTag).append(data);
					var newList = $newHtml.children(".tweetBox").toArray();
					var tweetCount = 0;
					var pageNum = -1;
					if (newList.length > 1) {
						tweetCount = $(newList[0]).attr("count");
						pageNum = $(newList[0]).attr("pageNum");
					}
					;
					//		$("#tweetCount").html(formatNumber(tweetCount)+'건');
					//		$("#tweetCount").attr("count", tweetCount);
					//		$(".tweetCount").html(formatNumber(tweetCount)+'건');
					//		$("#totalCount").html(formatNumber(getTweetCount()+getBlogCount()));
					//		$("#totalCount").attr("count", getTweetCount()+getBlogCount());
					$("#innerRtTweet2").html(data);

					if (pageNum == -1) {
						$("#innerRtTweet1").parent().children(
								".moreTweet[order=rt]").css('display', 'none');
						$("#innerRtTweet2").parent().children(
								".moreTweet[order=rt]").css('display', 'none');

						$("#innerRtTweet1").parent().children(
								".moreTweet[order=rt]").removeClass('rtTweet');
						$("#innerRtTweet2").parent().children(
								".moreTweet[order=rt]").removeClass('rtTweet');
					} else {
						$("#innerRtTweet1").parent().children(
								".moreTweet[order=rt]")
								.attr("pageNum", pageNum);
						$("#innerRtTweet2").parent().children(
								".moreTweet[order=rt]")
								.attr("pageNum", pageNum);
					}
				});
	};

	var loadBlogDocument = function(association) {
		var keyword = '너무예뻐';

		var url = "/socialSearch/document_ajax.html";
		var params = {
			keyword : keyword,
			association : association,
			source : 'blog'
		};
		/* $("#innerBlog1")
				.html(
						"<div class='loading'><img src='/scheduler/resources/images/loading2.gif'></div>"); */
		$("#innerBlog1").load(
				url,
				$.param(params),
				function(data) {
					var tempTag = '<div id="temp"></div>';
					var $newHtml = $(tempTag).append(data);
					var newList = $newHtml.children(".blogBox").toArray();
					var tweetCount = 0;
					var pageNum = -1;
					if (newList.length > 1) {
						tweetCount = $(newList[0]).attr("count");
						pageNum = $(newList[0]).attr("pageNum");
					}
					;
					$("#blogCount").html(formatNumber(tweetCount) + '건');
					$(".blogCount").html(formatNumber(tweetCount) + '건');
					$("#blogCount").attr("count", tweetCount);

					$("#innerBlog2").html(data);

					if (pageNum == -1) {
						$("#innerBlog1").parent().children(".moreTweet").css(
								'display', 'none');
						$("#innerBlog2").parent().children(".moreTweet").css(
								'display', 'none');
					} else {
						$("#innerBlog1").parent().children(".moreTweet").attr(
								"pageNum", pageNum);
						$("#innerBlog2").parent().children(".moreTweet").attr(
								"pageNum", pageNum);
					}
				});
	};

	var pagingDocument = function($this) {
		var source = $this.attr('source');
		var pageNum = $this.attr('pageNum');
		pageNum = parseInt(pageNum);
		if (pageNum == -1)
			return;
		var keyword = '너무예뻐';
		var order = $this.attr('order');
		var url = "/socialSearch/document_ajax.html";
		var params = {
			keyword : keyword,
			source : source,
			pageNum : pageNum,
			order : order
		};
		var className = source == 'twitter' ? 'tweetBox' : 'blogBox';
		//	$("#mainTab01_03").html("<div class='loading'><img src='/scheduler/resources/images/loading2.gif'></div>");
		$.ajax({
			url : url,
			data : params,
			success : function(data) {
				var tempTag = '<div id="temp"></div>';
				var $newHtml = $(tempTag).append(data);
				var newList = $newHtml.children("div." + className).toArray();
				var parent = $this.prev();
				//			var lastChild = parent.children("." + className);
				var pageNum = 0;
				for (var i = 0; i < newList.length; i++) {
					parent.append(newList[i]);
					pageNum = $(newList[i]).attr("pageNum");
				}
				if (pageNum == -1)
					$this.css('display', 'none');
				else
					$this.attr("pageNum", pageNum);
			}
		});
	};

	var getTweetCount = function() {
		var tweetCount = $("#tweetCount").attr("count");
		return parseInt(tweetCount);
	};

	var getBlogCount = function() {
		return parseInt($("#blogCount").attr("count"));
	};

	var bindSearchKeyword = function() {
		$("#searchKeyword").keypress(function(e) {
			if (e.keyCode == 13)
				searchKeyword();
		});
	};

	var searchKeyword = function() {
		var searchKeyword = $('#searchKeyword').val();
		if ($.trim(searchKeyword) == '') {
			alert('키워드를 입력하세요.');
			$('#searchKeyword').focus();
			return;
		} else {
			$('#keyword').val(searchKeyword);
			var url = '/searchKeywordMap.html';
			location.href = url + "?" + $.param({
				"keyword" : searchKeyword
			});
		}
	}

	var popKeyWd = function(andKeyword) {

		$('#andKeyword').val(andKeyword);
		var frm = document.seekForm;

		var iWidth = 780;
		var iHeight = 700;
		var iLeft = ((window.screen.availWidth - iWidth) / 2) - 20;
		var iTop = ((window.screen.availHeight - iHeight) / 2) - 40;
		var sFeatures = "scrollbars=yes,status=no,toolbar=no,resizable=yes,left="
				+ iLeft
				+ ","
				+ "top="
				+ iTop
				+ ","
				+ "width="
				+ iWidth
				+ ","
				+ "height=" + iHeight;

		window.open("", "popup_post", sFeatures);
		frm.target = "popup_post";
		frm.action = "/popKeyWd.html";
		frm.submit();
	}
</script>
<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-24519747-3' ]);
	_gaq.push([ '_trackPageview', '/searchKeywordMap.html' ]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl'
				: 'http://www')
				+ '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>

<!-- Flex Setting Start -->
<link rel="stylesheet" type="text/css"
	href="/scheduler/resources/swf/history/history.css">
<script src="/scheduler/resources/swf/AC_OETags.js" language="javascript"></script>
<script src="/scheduler/resources/swf/history/history.js" language="javascript"></script>
<script language="JavaScript" type="text/javascript">
	// Globals
	// Major version of Flash required
	var requiredMajorVersion = 9;
	// Minor version of Flash required
	var requiredMinorVersion = 0;
	// Minor version of Flash required
	var requiredRevision = 124;
</script>
<!-- Flex Setting End -->
<script type="text/javascript">
	$(document).ready(function() {
		showKeywordNet();
	});

	/*************************************** flex 관련  *******************************************/
	function getMovieName(movieName) {
		if (navigator.appName.indexOf("Microsoft") != -1) {
			return window[movieName];
		} else {
			return document[movieName];
		}
	}

	function getFlexApp(appName) {
		if (document.embeds[appName])
			return document.embeds[appName];
		if (window.document[appName])
			return window.document[appName];
		if (window[appName])
			return window[appName];
		if (document[appName])
			return document[appName];
		return null;
	}

	function showKeywordNet() {
		try {
			getFlexApp('MainSpringGraph').jsShowKeywdNet($('#keyword').val(),
					$('#startDate').val(), $('#endDate').val(), 100, '', '');
		} catch (err) {
			;
		}
	}

	function sendBothWord(root, child) {
		//alert(root);
		//alert(child);
		popKeyWd(child);
	}

	function popKeyWd(andKeyword) {

		$('#andKeyword').val(andKeyword);
		var frm = document.seekForm;

		var iWidth = 780;
		var iHeight = 700;
		var iLeft = ((window.screen.availWidth - iWidth) / 2) - 20;
		var iTop = ((window.screen.availHeight - iHeight) / 2) - 40;
		var sFeatures = "scrollbars=yes,status=no,toolbar=no,resizable=yes,left="
				+ iLeft
				+ ","
				+ "top="
				+ iTop
				+ ","
				+ "width="
				+ iWidth
				+ ","
				+ "height=" + iHeight;

		window.open("", "popup_post", sFeatures);
		frm.target = "popup_post";
		frm.action = "/popKeyWd.html";
		frm.submit();
	}
</script>


</head>

<body>

	<div id="wrap">

		<!-- header -->
		<div id="header">
			<!-- 큰제목 클릭시 메인으로 -->
			<h1 style="width: 140px; overflow: hidden;">
				<a href="/index.html">data-analysis</a>
			</h1>
			
			<ul class="menu">
				<li><a href="/index.html?keyword=너무예뻐">홈</a></li>
				<li><a href="/socialSearch.html?keyword=너무예뻐">소셜 검색</a></li>
				<li><a href="/searchKeywordMap.html?keyword=너무예뻐" 	class="active">데이터 분석</a></li>

			</ul>
			<ul class="searchBox">
				<li><input type="text" class="input_txt" id="searchKeyword"
					name="searchKeyword" value="너무예뻐"></li>
			</ul>
		</div>
		<!-- // header -->

		<!--  submenu -->

		<div id="submenu">
			<ul>
				<li><a href="/searchKeywordMap.html?keyword=너무예뻐" class="active">연관어 분석</a></li>
				<li><a href="/searchKeywordTransition.html?keyword=너무예뻐">감성 분석</a></li>
				<!--  <li><a href="/searchKeywordOpinion.html?keyword=너무예뻐">탐색어 여론</a></li>-->
			</ul>
		</div>
		<!-- // submenu -->

		<!-- 전체 칸 -->
		<div id="container">
			<div id="headHeight">
				<!-- 상단고정영역 -->
			</div>
			<!-- contents -->
			<div id="contents">
				<!-- tweetmobWrap -->
				<div class="tweetmobWrap">
					<div class="tweetmobHead"></div>
					<!-- tweetmobMiddle -->
					<div class="tweetmobMiddle">
						<!--지정된 기간 표시  -->
						<p class="timePeriod">기간: 2016-07-16 ~ 2016-08-16</p>
						<!--#submenu 선택 에 대한 제목  -->
						<h2>
							<em>'키워드' </em>연관어 분석
						</h2>
						
						<!-- 엑셀 파일 제공 -->
						<p class="excel">
							<a href="#');" title="엑셀 다운로드는 소셜메트릭스Biz 유료 버전에서 제공됩니다."><img
								src="/scheduler/resources/images/iconExcel.png" alt="엑셀 다운로드"></a>
						</p>
						<!--// 엑셀 파일 -->
						
						<!-- 트위터와 블로그에서 긁어온 연관어 분석한 맵  -->
						<h3>연관어</h3>
						<div class="flex_box">
							<script language="JavaScript" type="text/javascript">
							</script>
							<embed src="/scheduler/resources/swf/MainSpringGraph.swf" width="100%"
								height="100%" align="middle" id="MainSpringGraph" quality="high"
								bgcolor="#ffffff" name="MainSpringGraph"
								allowscriptaccess="sameDomain"
								pluginspage="http://www.adobe.com/go/getflashplayer"
								type="application/x-shockwave-flash">
							<noscript>&lt;object
								classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
								id="MainSpringGraph" width="100%" height="100%"
								codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab"&gt;
								&lt;param name="movie"
								value="/scheduler/resources/swf/MainSpringGraph.swf" /&gt; &lt;param
								name="quality" value="high" /&gt; &lt;param name="bgcolor"
								value="#ffffff" /&gt; &lt;param name="allowScriptAccess"
								value="sameDomain" /&gt; &lt;embed
								src="/scheduler/resources/swf/MainSpringGraph.swf" quality="high"
								bgcolor="#ffffff" width="100%" height="100%"
								name="MainSpringGraph" align="middle" play="true" loop="false"
								quality="high" allowScriptAccess="sameDomain"
								type="application/x-shockwave-flash"
								pluginspage="http://www.adobe.com/go/getflashplayer"&gt;
								&lt;/embed&gt; &lt;/object&gt;</noscript>
						</div>

						<!-- 전체/트위터/블로그 리스트 선택에 대한 정보 불러오기-->
						<form name="seekForm" id="seekForm" method="post" target="_self">
							<input type="hidden" id="startDate" name="startDate" value="2016-07-16"> 
							<input type="hidden" id="endDate" name="endDate" value="2016-08-16"> 
							<input type="hidden" id="keyword" name="keyword" value="너무예뻐"> 
							<input type="hidden" id="andKeyword" name="andKeyword" value="">
						</form>

						<!-- 트윗몹 리스트 -->
						<div class="section">
							<!-- 전체 /트위터/블로그 리스트에 대한 카테고리 선택 -->
							<ul class="mainTab01">
								<li class="active"><a href="#mainTab01_01">전체</a></li>
								<li><a href="#mainTab01_02">트위터</a></li>
								<li><a href="#mainTab01_03">블로그</a></li>
							</ul>
							<!-- 리스트 데이터 넣는 컨테이너   -->	
							<div class="tab_container01">
								<!-- '전체'선택시 리스트 컨테이너  -->
								<div id="mainTab01_01" class="tab_content01" style="display: block;">

									<!-- tweetAndBlogWrap -->
									<div class="tweetAndBlogWrap">
										<!-- tweetWrap -->
										<div class="tweetWrap">
											<ul class="btnArea">
												<li style="text-decoration: underline;"><a
													href="javascript:;" order="recent">최신</a></li>
												<li>|</li>
												<li><a href="javascript:;" order="rt">인기</a></li>
											</ul>
											
											<h3>
												트위터<em class="tweetCount">125,145건</em>
											</h3>
											
											<!-- **최신 트위터에 대한 리스트 목록 -->
											<div class="recentTweet" id="innerTweet1">

												<!-- tweetBox / 첫번째 -->
												<div class="tweetBox" count="125145" pagenum="2">
													<!-- 트위터 사진 -->
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/745410424821022720/kbGkQopA_normal.jpg"
															width="48" height="48">
													</p>
													<!-- 트위터 내용 -->
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/Bstar_95" target="_blank">@Bstar_95</a>
															</li>
															<li class="tweetName">앤캐야 사랑해! teddy곰</li>
															<li class="tweetTime">2016/08/16</li>
															<li class="tweetText"><a
																href="https://twitter.com/Bstar_95/status/765397665274208262"
																target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템
																	테라스도 있군요... http://twitter.com/RSTRY0...</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=765397665274208262">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=765397665274208262">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=2366976835">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 두번째-->
												<div class="tweetBox" count="125145" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/760583347550625792/ccdmpqW1_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/D_evilive_D" target="_blank">@D_evilive_D</a>
															</li>
															<li class="tweetName">*+✧ D•DOG✧+*</li>
															<li class="tweetTime">2016/08/16</li>
															<li class="tweetText"><a
																href="https://twitter.com/D_evilive_D/status/765397545744904193"
																target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템
																	테라스도 있군요... http://twitter.com/RSTRY0...</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=765397545744904193">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=765397545744904193">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=2839181642">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 세번째 -->
												<div class="tweetBox" count="125145" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/756847077640933376/UQVHVK4n_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/knightload_hwe"
																target="_blank">@knightload_hwe</a></li>
															<li class="tweetName">✨커뮤 휘✨</li>
															<li class="tweetTime">2016/08/16</li>
															<li class="tweetText"><a
																href="https://twitter.com/knightload_hwe/status/765397539034017792"
																target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템
																	테라스도 있군요... http://twitter.com/RSTRY0...</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=765397539034017792">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=765397539034017792">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=2453013294">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 네번째 -->
												<div class="tweetBox" count="125145" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/745625319973883905/SqSyHr6f_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/turq_turtle" target="_blank">@turq_turtle</a>
															</li>
															<li class="tweetName">터키</li>
															<li class="tweetTime">2016/08/16</li>
															<li class="tweetText"><a
																href="https://twitter.com/turq_turtle/status/765397430464425984"
																target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템
																	테라스도 있군요... http://twitter.com/RSTRY0...</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=765397430464425984">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=765397430464425984">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=1694350346">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 다섯번째 -->
												<div class="tweetBox" count="125145" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/751475936239841280/yNR3SZ4L_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/COMaK_k" target="_blank">@COMaK_k</a>
															</li>
															<li class="tweetName">노예와착취홈 쿨P 꼬마기쨩</li>
															<li class="tweetTime">2016/08/16</li>
															<li class="tweetText"><a
																href="https://twitter.com/COMaK_k/status/765397298868129792"
																target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템
																	테라스도 있군요... http://twitter.com/RSTRY0...</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=765397298868129792">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=765397298868129792">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=3382577479">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->
											</div>
											
											<!-- 트위터 더보기  -->
											<div class="moreTweet recentTweet" source="twitter"	order="recent" pagenum="2">
												<a href="javascript:;">더보기</a>
											</div>
											<!--// **최신 트위터에 대한 리스트 목록 끝 -->
											
											<!--**인기 트윗에 대한 목록 -->
											<div class="rtTweet" id="innerRtTweet1"	style="display: none;">

												<!-- tweetBox 1 -->
												<div class="tweetBox" count="100" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/738204485135171584/qj_fvDQ9_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/puppystore_1992"
																target="_blank">@puppystore_1992</a></li>
															<li class="tweetName">PUPPY STORE</li>
															<li class="tweetTime">2016/07/30</li>
															<li class="tweetTime">(RT 4,292회)</li>
															<li class="tweetText"><a
																href="https://twitter.com/puppystore_1992/status/759097665720164353"
																target="_blank">너무 예뻐ㅜ 배겨나💕🍬
																	http://twitter.com/puppystore_1992/status/759097665720164353/photo/1</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=759097665720164353">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=759097665720164353">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=728962561">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 2-->
												<div class="tweetBox" count="100" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/756432461001691136/7vm--sT6_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/momigpie" target="_blank">@momigpie</a>
															</li>
															<li class="tweetName">momi(인용RT x)</li>
															<li class="tweetTime">2016/07/11</li>
															<li class="tweetTime">(RT 3,744회)</li>
															<li class="tweetText"><a
																href="https://twitter.com/momigpie/status/752157266808147969"
																target="_blank">아쿠아 오라(Aqua Aura). 색 정말 미쳤죠... 너무
																	예뻐............. 깨끗한 바닷물을 굳혀 놓은 것 같고 말야.
																	http://twitter.com/momigpie/status/752157266808147969/photo/1</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=752157266808147969">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=752157266808147969">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=146927802">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 3-->
												<div class="tweetBox" count="100" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/756432461001691136/7vm--sT6_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/momigpie" target="_blank">@momigpie</a>
															</li>
															<li class="tweetName">momi(인용RT x)</li>
															<li class="tweetTime">2016/07/12</li>
															<li class="tweetTime">(RT 2,809회)</li>
															<li class="tweetText"><a
																href="https://twitter.com/momigpie/status/752851886223466496"
																target="_blank">페리스테라이트(Peristerite), 은은하고 푸른 진주빛으로
																	아쿠아 문스톤이라고도 부른다는 듯. 사장석의 일종이며 이름은 비둘기를 뜻하는 그리스어
																	peristera에서 왔다고 한다 흑흑 너무 예뻐ㅠㅠㅠㅠ
																	http://twitter.com/momigpie/status/752851886223466496/photo/1</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=752851886223466496">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=752851886223466496">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=146927802">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 4-->
												<div class="tweetBox" count="100" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/763667155808165888/ne7zTEKy_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/Psyco__romance"
																target="_blank">@Psyco__romance</a></li>
															<li class="tweetName">✁뒤져있는 봄오랑✨</li>
															<li class="tweetTime">2016/08/09</li>
															<li class="tweetTime">(RT 2,353회)</li>
															<li class="tweetText"><a
																href="https://twitter.com/Psyco__romance/status/762705437632319492"
																target="_blank">다정공이 좋다지만 침대에선 다정하지 않았으면 좋겠는게 모든 앤오들
																	마음 아니겠습니까? 허리 밑으론 자본주의로 존나 다정리스여야함. 어떻게 해. 너무 예뻐. 허리 좀
																	더 들어봐. 소리 참지 말고.</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=762705437632319492">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=762705437632319492">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=382490690">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->

												<!-- tweetBox 5-->
												<div class="tweetBox" count="100" pagenum="2">
													<p class="tweetPicture">
														<img
															src="https://pbs.twimg.com/profile_images/760515558630576132/4TESgMOK_normal.jpg"
															width="48" height="48">
													</p>
													<div class="tweetArea">
														<ul>
															<li class="tweetID"><a
																href="https://twitter.com/Tentazione__" target="_blank">@Tentazione__</a>
															</li>
															<li class="tweetName">Tentazione</li>
															<li class="tweetTime">2016/07/16</li>
															<li class="tweetTime">(RT 2,200회)</li>
															<li class="tweetText"><a
																href="https://twitter.com/Tentazione__/status/754311030503710724"
																target="_blank">테니 노란모자 거꾸로 쓰고 😭😭😭😭 민소매 소취했는데 역시
																	민소매ㅜㅜㅜㅜ 완벽해써ㅜㅜㅠㅜㅜ 너무 예뻐ㅜㅜㅜㅜㅜ 우리시티 분량좀 잘챙겨주세여... @슴 #TEN
																	#NCT
																	http://twitter.com/Tentazione__/status/754311030503710724/video/1</a></li>
														</ul>
														<ul>
															<li class="retweetBtn"><a
																href="https://twitter.com/intent/retweet?tweet_id=754311030503710724">Retweet</a></li>
															<li class="replyBtn"><a
																href="https://twitter.com/intent/tweet?in_reply_to=754311030503710724">Reply</a></li>
															<li class="followBtn"><a
																href="https://twitter.com/intent/user?user_id=974413824">Follow</a></li>
														</ul>
													</div>
												</div>
												<!-- tweetBox -->
											</div>
											<!-- 인기 트위터 더보기 -->											
											<div class="moreTweet rtTweet" source="twitter" order="rt"
												pagenum="2" style="display: none;">
												<a href="javascript:;">더보기</a>
											</div>
											<!--**인기 트윗에 대한 목록 끝-->
										</div>
										<!-- // tweetWrap 끝-->


										<!-- blogWrap -->
										<div class="blogWrap">
											<h3>
												블로그<em class="blogCount">2,482건</em>
											</h3>
											<!-- 블로그 리스트 -->
											<div id="innerBlog1">

												<!-- blogBox 1-->
												<div class="blogBox" count="2482" pagenum="2">
													<ul>
														<li class="blogTitle"><a
															href="http://blog.naver.com/aqua547/220788275948"
															target="_blank">7살, 5살의 여름 : 가평 명지계곡</a></li>
														<li class="blogDate">2016/08/15</li>
														<li class="blogText">너무나 무더운 이번 여름 - 박남편과 하루 오프 맞아
															다녀온 가평 명지 계곡 새로 산 텐트도 칠 겸, 가까운 계곡으로 ...</li>
														<li class="blogURL"><a
															href="http://blog.naver.com/aqua547/220788275948"
															target="_blank">http://blog.naver.com/aqua547/220788275948</a></li>
													</ul>
												</div>
												<!-- // blogBox -->

												<!-- blogBox 2-->
												<div class="blogBox" count="2482" pagenum="2">
													<ul>
														<li class="blogTitle"><a
															href="http://blog.naver.com/0303cat/220788202524"
															target="_blank">니시지마 타카히로/ 아리무라 카스미 (...</a></li>
														<li class="blogDate">2016/08/15</li>
														<li class="blogText">얼마전에 알게된 사실인데.... &lt;언젠가 이 사랑을
															떠올리면 분명 울어버릴 것 같아&gt;에 나오는 이부키상이 AAA(트리플 ...</li>
														<li class="blogURL"><a
															href="http://blog.naver.com/0303cat/220788202524"
															target="_blank">http://blog.naver.com/0303cat/220788202524</a></li>
													</ul>
												</div>
												<!-- // blogBox -->

												<!-- blogBox 3-->
												<div class="blogBox" count="2482" pagenum="2">
													<ul>
														<li class="blogTitle"><a
															href="http://blog.naver.com/0506backhyun/220788200854"
															target="_blank">[경범]두번째 고백</a></li>
														<li class="blogDate">2016/08/15</li>
														<li class="blogText">[경범/박경비범] 두번째 고백 w.파이 - “후..” 거울
															속에 남자가 긴장한 모습으로 자신의 머리를 매만졌다. 그리고는...</li>
														<li class="blogURL"><a
															href="http://blog.naver.com/0506backhyun/220788200854"
															target="_blank">http://blog.naver.com/0506backhyun/220788200854</a></li>
													</ul>
												</div>
												<!-- // blogBox -->

												<!-- blogBox 4-->
												<div class="blogBox" count="2482" pagenum="2">
													<ul>
														<li class="blogTitle"><a
															href="http://blog.naver.com/0jooooo/220788191434"
															target="_blank">8월 일상 (1)</a></li>
														<li class="blogDate">2016/08/15</li>
														<li class="blogText">8월이 밝았어요 쭈리는 덥지도않니 딱붙어가지고는 8월 2일
															화요일 학원 알바 면접보구 엄마아빠랑 장어먹으롱ㅋㅋ 난생 처음 ...</li>
														<li class="blogURL"><a
															href="http://blog.naver.com/0jooooo/220788191434"
															target="_blank">http://blog.naver.com/0jooooo/220788191434</a></li>
													</ul>
												</div>
												<!-- // blogBox -->

												<!-- blogBox 5-->
												<div class="blogBox" count="2482" pagenum="2">
													<ul>
														<li class="blogTitle"><a
															href="http://blog.naver.com/skdld77/220788160011"
															target="_blank">[뷔진/태형/석진/방탄소년단팬픽/방탄팬...</a></li>
														<li class="blogDate">2016/08/15</li>
														<li class="blogText">뷔진X공항에서 ((사진한장으로 현게인증한 뷔진이들))
															"우와..." &#8203; &#8203; 볼은 발그레해가지고 공...</li>
														<li class="blogURL"><a
															href="http://blog.naver.com/skdld77/220788160011"
															target="_blank">http://blog.naver.com/skdld77/220788160011</a></li>
													</ul>
												</div>
												<!-- // blogBox -->
											</div>
											
											<!-- 블로그 리스트 더보기 -->
											<div class="moreTweet" source="blog" pagenum="2">
												<a href="javascript:;">더보기</a>
											</div>

										</div>
										<!--// blogWrap -->

									</div>
									<!-- // tweetAndBlogWrap -->
								</div>
								
								<!-- '트위터'선택에 대한 리스트 컨테이너 -->
								<div id="mainTab01_02" class="tab_content01" style="display: none;">
									<ul class="btnArea2">
										<li style="text-decoration: underline;"><a
											href="javascript:;" order="recent">최신</a></li>
										<li>|</li>
										<li><a href="javascript:;" order="rt">인기</a></li>
									</ul>
									<h3>
										트위터<em class="tweetCount">125,145건</em>
									</h3>
									<div class="recentTweet" id="innerTweet2">

										<!-- tweetBox -->
										<div class="tweetBox" count="125145" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/745410424821022720/kbGkQopA_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/Bstar_95" target="_blank">@Bstar_95</a>
													</li>
													<li class="tweetName">앤캐야 사랑해! teddy곰</li>
													<li class="tweetTime">2016/08/16</li>
													<li class="tweetText"><a
														href="https://twitter.com/Bstar_95/status/765397665274208262"
														target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도
															있군요... http://twitter.com/RSTRY0...</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=765397665274208262">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=765397665274208262">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=2366976835">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="125145" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/760583347550625792/ccdmpqW1_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/D_evilive_D" target="_blank">@D_evilive_D</a>
													</li>
													<li class="tweetName">*+✧ D•DOG✧+*</li>
													<li class="tweetTime">2016/08/16</li>
													<li class="tweetText"><a
														href="https://twitter.com/D_evilive_D/status/765397545744904193"
														target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도
															있군요... http://twitter.com/RSTRY0...</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=765397545744904193">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=765397545744904193">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=2839181642">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="125145" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/756847077640933376/UQVHVK4n_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/knightload_hwe" target="_blank">@knightload_hwe</a>
													</li>
													<li class="tweetName">✨커뮤 휘✨</li>
													<li class="tweetTime">2016/08/16</li>
													<li class="tweetText"><a
														href="https://twitter.com/knightload_hwe/status/765397539034017792"
														target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도
															있군요... http://twitter.com/RSTRY0...</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=765397539034017792">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=765397539034017792">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=2453013294">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="125145" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/745625319973883905/SqSyHr6f_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/turq_turtle" target="_blank">@turq_turtle</a>
													</li>
													<li class="tweetName">터키</li>
													<li class="tweetTime">2016/08/16</li>
													<li class="tweetText"><a
														href="https://twitter.com/turq_turtle/status/765397430464425984"
														target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도
															있군요... http://twitter.com/RSTRY0...</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=765397430464425984">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=765397430464425984">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=1694350346">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="125145" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/751475936239841280/yNR3SZ4L_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/COMaK_k" target="_blank">@COMaK_k</a>
													</li>
													<li class="tweetName">노예와착취홈 쿨P 꼬마기쨩</li>
													<li class="tweetTime">2016/08/16</li>
													<li class="tweetText"><a
														href="https://twitter.com/COMaK_k/status/765397298868129792"
														target="_blank">RT @RSTRY01: 런칭기념 케이크! 너무 예뻐! 국민템 테라스도
															있군요... http://twitter.com/RSTRY0...</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=765397298868129792">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=765397298868129792">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=3382577479">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->
									</div>
									<!-- 트위터 더보기 -->
									<div class="moreTweet recentTweet" source="twitter"
										order="recent" pagenum="2">
										<a href="javascript:;">더보기</a>
									</div>
									
									<!-- 인기 트윗 리스트 -->
									<div class="rtTweet" id="innerRtTweet2" style="display: none;">
										<!-- tweetBox -->
										<div class="tweetBox" count="100" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/738204485135171584/qj_fvDQ9_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/puppystore_1992" target="_blank">@puppystore_1992</a>
													</li>
													<li class="tweetName">PUPPY STORE</li>
													<li class="tweetTime">2016/07/30</li>
													<li class="tweetTime">(RT 4,292회)</li>
													<li class="tweetText"><a
														href="https://twitter.com/puppystore_1992/status/759097665720164353"
														target="_blank">너무 예뻐ㅜ 배겨나💕🍬
															http://twitter.com/puppystore_1992/status/759097665720164353/photo/1</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=759097665720164353">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=759097665720164353">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=728962561">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="100" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/756432461001691136/7vm--sT6_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/momigpie" target="_blank">@momigpie</a>
													</li>
													<li class="tweetName">momi(인용RT x)</li>
													<li class="tweetTime">2016/07/11</li>
													<li class="tweetTime">(RT 3,744회)</li>
													<li class="tweetText"><a
														href="https://twitter.com/momigpie/status/752157266808147969"
														target="_blank">아쿠아 오라(Aqua Aura). 색 정말 미쳤죠... 너무
															예뻐............. 깨끗한 바닷물을 굳혀 놓은 것 같고 말야.
															http://twitter.com/momigpie/status/752157266808147969/photo/1</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=752157266808147969">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=752157266808147969">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=146927802">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="100" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/756432461001691136/7vm--sT6_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/momigpie" target="_blank">@momigpie</a>
													</li>
													<li class="tweetName">momi(인용RT x)</li>
													<li class="tweetTime">2016/07/12</li>
													<li class="tweetTime">(RT 2,809회)</li>
													<li class="tweetText"><a
														href="https://twitter.com/momigpie/status/752851886223466496"
														target="_blank">페리스테라이트(Peristerite), 은은하고 푸른 진주빛으로
															아쿠아 문스톤이라고도 부른다는 듯. 사장석의 일종이며 이름은 비둘기를 뜻하는 그리스어
															peristera에서 왔다고 한다 흑흑 너무 예뻐ㅠㅠㅠㅠ
															http://twitter.com/momigpie/status/752851886223466496/photo/1</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=752851886223466496">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=752851886223466496">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=146927802">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="100" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/763667155808165888/ne7zTEKy_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/Psyco__romance" target="_blank">@Psyco__romance</a>
													</li>
													<li class="tweetName">✁뒤져있는 봄오랑✨</li>
													<li class="tweetTime">2016/08/09</li>
													<li class="tweetTime">(RT 2,353회)</li>
													<li class="tweetText"><a
														href="https://twitter.com/Psyco__romance/status/762705437632319492"
														target="_blank">다정공이 좋다지만 침대에선 다정하지 않았으면 좋겠는게 모든 앤오들
															마음 아니겠습니까? 허리 밑으론 자본주의로 존나 다정리스여야함. 어떻게 해. 너무 예뻐. 허리 좀 더
															들어봐. 소리 참지 말고.</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=762705437632319492">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=762705437632319492">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=382490690">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->

										<!-- tweetBox -->
										<div class="tweetBox" count="100" pagenum="2">
											<p class="tweetPicture">
												<img
													src="https://pbs.twimg.com/profile_images/760515558630576132/4TESgMOK_normal.jpg"
													width="48" height="48">
											</p>
											<div class="tweetArea">
												<ul>
													<li class="tweetID"><a
														href="https://twitter.com/Tentazione__" target="_blank">@Tentazione__</a>
													</li>
													<li class="tweetName">Tentazione</li>
													<li class="tweetTime">2016/07/16</li>
													<li class="tweetTime">(RT 2,200회)</li>
													<li class="tweetText"><a
														href="https://twitter.com/Tentazione__/status/754311030503710724"
														target="_blank">테니 노란모자 거꾸로 쓰고 😭😭😭😭 민소매 소취했는데 역시
															민소매ㅜㅜㅜㅜ 완벽해써ㅜㅜㅠㅜㅜ 너무 예뻐ㅜㅜㅜㅜㅜ 우리시티 분량좀 잘챙겨주세여... @슴 #TEN
															#NCT
															http://twitter.com/Tentazione__/status/754311030503710724/video/1</a></li>
												</ul>
												<ul>
													<li class="retweetBtn"><a
														href="https://twitter.com/intent/retweet?tweet_id=754311030503710724">Retweet</a></li>
													<li class="replyBtn"><a
														href="https://twitter.com/intent/tweet?in_reply_to=754311030503710724">Reply</a></li>
													<li class="followBtn"><a
														href="https://twitter.com/intent/user?user_id=974413824">Follow</a></li>
												</ul>
											</div>
										</div>
										<!-- tweetBox -->
									</div>
									<!-- 인기트윗더보기 -->
									<div class="moreTweet rtTweet" source="twitter" order="rt"
										pagenum="2" style="display: none;">
										<a href="javascript:;">더보기</a>
									</div>
								</div>
								
								<!-- '블로그'에 대한 컨테이너 -->
								<div id="mainTab01_03" class="tab_content01"
									style="display: none;">
									<h3>
										블로그<em class="blogCount">2,482건</em>
									</h3>
									<div id="innerBlog2">

										<!-- blogBox 1-->
										<div class="blogBox" count="2482" pagenum="2">
											<ul>
												<li class="blogTitle"><a
													href="http://blog.naver.com/aqua547/220788275948"
													target="_blank">7살, 5살의 여름 : 가평 명지계곡</a></li>
												<li class="blogDate">2016/08/15</li>
												<li class="blogText">너무나 무더운 이번 여름 - 박남편과 하루 오프 맞아 다녀온
													가평 명지 계곡 새로 산 텐트도 칠 겸, 가까운 계곡으로 ...</li>
												<li class="blogURL"><a
													href="http://blog.naver.com/aqua547/220788275948"
													target="_blank">http://blog.naver.com/aqua547/220788275948</a></li>
											</ul>
										</div>
										<!-- // blogBox -->

										<!-- blogBox 2-->
										<div class="blogBox" count="2482" pagenum="2">
											<ul>
												<li class="blogTitle"><a
													href="http://blog.naver.com/0303cat/220788202524"
													target="_blank">니시지마 타카히로/ 아리무라 카스미 (...</a></li>
												<li class="blogDate">2016/08/15</li>
												<li class="blogText">얼마전에 알게된 사실인데.... &lt;언젠가 이 사랑을
													떠올리면 분명 울어버릴 것 같아&gt;에 나오는 이부키상이 AAA(트리플 ...</li>
												<li class="blogURL"><a
													href="http://blog.naver.com/0303cat/220788202524"
													target="_blank">http://blog.naver.com/0303cat/220788202524</a></li>
											</ul>
										</div>
										<!-- // blogBox -->

										<!-- blogBox 3-->
										<div class="blogBox" count="2482" pagenum="2">
											<ul>
												<li class="blogTitle"><a
													href="http://blog.naver.com/0506backhyun/220788200854"
													target="_blank">[경범]두번째 고백</a></li>
												<li class="blogDate">2016/08/15</li>
												<li class="blogText">[경범/박경비범] 두번째 고백 w.파이 - “후..” 거울
													속에 남자가 긴장한 모습으로 자신의 머리를 매만졌다. 그리고는...</li>
												<li class="blogURL"><a
													href="http://blog.naver.com/0506backhyun/220788200854"
													target="_blank">http://blog.naver.com/0506backhyun/220788200854</a></li>
											</ul>
										</div>
										<!-- // blogBox -->

										<!-- blogBox 4-->
										<div class="blogBox" count="2482" pagenum="2">
											<ul>
												<li class="blogTitle"><a
													href="http://blog.naver.com/0jooooo/220788191434"
													target="_blank">8월 일상 (1)</a></li>
												<li class="blogDate">2016/08/15</li>
												<li class="blogText">8월이 밝았어요 쭈리는 덥지도않니 딱붙어가지고는 8월 2일
													화요일 학원 알바 면접보구 엄마아빠랑 장어먹으롱ㅋㅋ 난생 처음 ...</li>
												<li class="blogURL"><a
													href="http://blog.naver.com/0jooooo/220788191434"
													target="_blank">http://blog.naver.com/0jooooo/220788191434</a></li>
											</ul>
										</div>
										<!-- // blogBox -->

										<!-- blogBox 5-->
										<div class="blogBox" count="2482" pagenum="2">
											<ul>
												<li class="blogTitle"><a
													href="http://blog.naver.com/skdld77/220788160011"
													target="_blank">[뷔진/태형/석진/방탄소년단팬픽/방탄팬...</a></li>
												<li class="blogDate">2016/08/15</li>
												<li class="blogText">뷔진X공항에서 ((사진한장으로 현게인증한 뷔진이들))
													"우와..." &#8203; &#8203; 볼은 발그레해가지고 공...</li>
												<li class="blogURL"><a
													href="http://blog.naver.com/skdld77/220788160011"
													target="_blank">http://blog.naver.com/skdld77/220788160011</a></li>
											</ul>
										</div>
										<!-- // blogBox -->
									</div>
									<!-- 블로그 더보기 -->
									<div class="moreTweet" source="blog" pagenum="2">
										<a href="javascript:;">더보기</a>
									</div>

								</div>

							</div>
						</div>
						<!-- // 트윗몹 리스트 -->

					</div>
					<!-- // tweetmobMiddle -->

					<div class="tweetmobBottom"></div><!-- 라인 -->
				</div>
				<!-- tweetmobWrap -->
			</div>
			<!-- contents -->
			<div id="footerHeight">
				<!-- 상단고정영역 -->
			</div>
		</div>
		<!-- container -->


		<!-- footer -->
		<div id="footer">
			<ul class="bannrtLink">
			</ul>
			<ul class="btnBox">

				<li><a href="/contactUs.html">Contact Us</a></li>
			</ul>
			<p class="copyright">Copyright © Daumsoft. All rights reserved.</p>
			<p class="email">
				유료 서비스 신규 가입 문의: <a href="mailto:access@socialmetrics.co.kr">access@socialmetrics.co.kr</a>
			</p>

		</div>
		<!-- //footer -->

	</div>





	<div id="safari_rememberDiv">
		<input type="text" id="safari_remember_field" style="width: 500px;">
	</div>
	<div id="safari_formDiv"></div>
	<div id="safarireloader"
		style="position: absolute; top: -9999px; left: -9999px;">
		<iframe id="safarireloader-iframe" src="about:blank" frameborder="no"
			scrolling="no"></iframe>
	</div>
</body>
</html>