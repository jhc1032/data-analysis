<%@ page language="java" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8" />
    <title></title>
</head>

<script type="text/javascript">
	Document.getElementById('test').innerHTML = 'abc';
</script>
<body>
	<form id="searchfrom" action="search.action" method="post">
		<input type="text" id="search" name="search"/>
		<input type="submit" value="검색"/>
	</form>
	
	<p id="test"></p>    
</body>
</html>