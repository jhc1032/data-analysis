var getNow = function() {
	var now = new Date();
	
	var year = now.getFullYear();
	var month = now.getMonth() + 1;
	var date = now.getDate();
	var hour = now.getHours();
	var minute = now.getMinutes();
	var second = now.getSeconds();
	var yyyymmdd = year + (month<10?"0":"") + month + (date<10?"0":"") + date + (hour<10?"0":"") + hour + (minute<10?"0":"") + minute + (second<10?"0":"") + second;
	return yyyymmdd;
};

var formatNumber = function(number) {
	if(number == null){
		return 0;
	}
	
	number = parseInt(number);
	
	if(number == 0){
		return 0;
	}
	
	if (number < 1000) {
		return number;
	}
	
	var modular = number % 1000;
	if (modular < 100) {
		modular = "0" + modular;
	}
	if (modular < 10) {
		modular = "0" + modular;
	}
	
	return formatNumber(number / 1000) + "," + modular;
};

var formatDate = function(date, separator){
	date = "" + date;
	if(separator == null){
		separator = "-";
	}
	
	var year = date.substr(0,4);
	while(year.charAt(0) == '0'){
		year = year.substr(1);
	}
	var month = date.substr(4,2);
	while(month.charAt(0) == '0'){
		month = month.substr(1);
	}
	var day = date.substr(6,2);
	while(day.charAt(0) == '0'){
		day = day.substr(1);
	}
	
	var dateStr = "";
	dateStr += year;
	dateStr += separator;
	dateStr += month;
	dateStr += separator;
	dateStr += day;
	return dateStr;
};

var parseDate = function (dateString) {
	var year = dateString.substring(0, 4);
	var month = dateString.substring(4, 6);
	var day = dateString.substring(6, 8);
	var hours = dateString.substring(8, 10);
	var minutes = dateString.substring(10, 12);
	var seconds = dateString.length == 14? dateString.substring(12, 14):00;
	
	var date = new Date(year, month-1, day, hours, minutes, seconds);

	return date;
};

function getTimeStamp(d, separator) {
	if(separator == null){
		separator = "";
	}
	var s =
		leadingZeros(d.getFullYear(), 4) + separator +
		leadingZeros(d.getMonth() + 1, 2) + separator + 
	   leadingZeros(d.getDate(), 2);
	return s;
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	if (n.length < digits) {
		for ( var i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}