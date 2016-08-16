// JavaScript Document
$(document).ready(function() {

	//When page loads...
	$(".tab_content01").hide(); //Hide all content
	$("ul.mainTab01 li:first").addClass("active").show(); //Activate first tab
	$(".tab_content01:first").show(); //Show first tab content

	//On Click Event
	$("ul.mainTab01 li").click(function() {

		$("ul.mainTab01 li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content01").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).show();
		//$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});

$(document).ready(function() {

	//When page loads...
	$(".tab_content02").hide(); //Hide all content
	$("ul.mainTab02 li:first").addClass("active").show(); //Activate first tab
	$(".tab_content02:first").show(); //Show first tab content

	//On Click Event
	$("ul.mainTab02 li").click(function() {

		$("ul.mainTab02 li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content02").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).show();
		//$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});
