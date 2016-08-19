<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>

<html>
<head>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>

<script type="text/javascript">

	var count =0;

	function idCheck(){
		
		var text = $("#email").val();
		
        var regexp = /[0-9a-zA-Z]/; // 숫자,영문,특수문자
        // var regexp = /[0-9]/; // 숫자만
//         var regexp = /[a-zA-Z]/; // 영문만
        
        for(var i=0; i<text.length; i++){
            if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == false ){
				alert("한글이나 특수문자는 입력불가능 합니다.");
				return false;
			}
        }
        
        overlapCheck();
        
        
	}
	
	function overlapCheck(){
		
		var param = "email" + "=" + $("#email").val();
		if($("#email").val() == '' || $("#email").val()==null)
		{
			alert("이메일을 입력하세요");
			return false;
		}
		
		$.ajax({
			url : "/overlaptest.do",
			type : "GET",
			data : param,
			cache : false,
			async : false,
			dataType : "text",

			success : function(response) {				
				if(response=='0')
				{
					count = 1;
					alert("중복 되지 않습니다. 사용가능 합니다.")
					
				}
				else
				{
					alert("이메일이 중복 됩니다. 다른 이메일을 입력 해주세요");
					return false;
				}	
			},
			error : function(request, status, error) {
				if (request.status != '0') {
					alert("code : " + request.status + "\r\nmessage : "
							+ request.reponseText + "\r\nerror : " + error);
				}
			}


		});
	}
	
	//	}

	function formCheck() {
		var email = document.getElementById('email');
		var password = document.getElementById('password');
		var password_check = document.getElementById('password_check');
		var name = document.getElementById('name');
		var gender = document.getElementById('gender');
		var age = document.getElementById('age'); 
		 
		
		
		if (email.value == '' || email.value == null) {
			alert('이메일을 입력하세요');
			focus.email;
			return false;
		}

		if (password.value == '' || password.value == null) {
			alert('비밀번호를 입력하세요');
			focus.password;
			return false;
		}
		
		if (password_check.value == '' || password_check.value == null) {
			alert('비밀번호확인란을 입력하세요');
			focus.password_hint;
			return false;
		}
		
		/*비밀번호와 비밀번호확인란 같은지 확인*/
		if (password.value != password_check.value){
			alert("비밀번호와 비밀번호 확인란이 다릅니다.");
			focus.passowrd;
			return false;
		}
		
		
		
		if(count == 0)
		{
			alert("중복확인을 눌러주세요");
			return false;
		}
		
		else{
			save();
		}
		
	}
	
	
	function init(){
		count=0;
	}
	
	function save() {
// 		alert($("#password_hint").val());
// 		alert($("#member_HP").val());
		var str3 = document.getElementById('join');
		str3.submit();
		alert("가입이 완료되었습니다.")
	}
	
	function countCheck(){
		if(count==1){
			count=0;
		}
	}
</script>

	<meta charset="utf-8" />
	<title>사용자등록</title>	
</head>
<body>

	<div id="pageContainer">
	
		<%-- <c:import url="/WEB-INF/views/include/header.jsp" /> --%>
		
		<div id="inputcontent">
			<br /><br />
		    <div id="inputmain">
		        <div class="inputsubtitle">회원기본정보</div>
		        
		        <form:form modelAttribute="member" action="register.action" method="post"><!-- 상대경로표시 -->
		         
		        <table class="btable" style="width:400px; border: 1px solid 9CFA85;">
		            <tr>
		                <td height="30" align="center" bgcolor="#FFDEAD">이메일</td>
						<td bgcolor="#E0FFFF"><input type="text" size="30" id="email" name="email" maxlength="30" onkeydown="countCheck();" onkeypress="countCheck();">&nbsp;<input type="button" value="중복확인" onclick='idCheck()'></td>
		            </tr>
		            <tr>
		                <td height="30" align="center" bgcolor="#FFDEAD">비밀번호</td>
						<td bgcolor="#E0FFFF"><input type="password" id="password" name="member_password" size=12 maxlength="12"></td>
		            </tr>
		            <tr>
		            	<td height="30" align="center" bgcolor="#FFDEAD">비밀번호확인</td>
				<td bgcolor="#E0FFFF"><input type="password" id="password_check" name="password_check" size=12 maxlength="12"></td>
		            </tr>
		            <tr>
				<td height="30" align="center" bgcolor="#FFDEAD">성별</td>
				<td bgcolor="#E0FFFF">
				<input name="gender" value="female" checked="checked" type="radio" />여자
				<input name="gender" value="male" type="radio" />남자
			</tr>
			
			<tr>
				<td height="30" align="center" bgcolor="#FFDEAD">연령</td>
				<td bgcolor="#E0FFFF">
				<div class="bir_mm">
									<span class="ps_box">
										<select id="mm" title="대" class="sel" onChange="checkBirthday('check')">
										<option value="">10대</option>
										  	 			
										  	 			<option value="2" >20대</option>
										  	 			<option value="3" >30대</option>
										  	 			<option value="4" >40대</option>
										  	 			<option value="5" >50대 이상</option>										 
				
				 	  	 			</select>
									</span>
									</div>
			
		                 
		           
		            <tr style="display:none"> <%-- 기본 타입을 사용자로 지정 --%>
		                <th>사용자구분</th>
		                <td>
		                	<form:radiobutton path="userType" value="0" checked="checked" label="사용자"  />
		                	<form:radiobutton path="userType" value="1" label="관리자" />
		                </td>
		            </tr>
		            <%-- 모든 입력 요소에 대해 필수 입력 항목 처리 --%>
		        </table>
		        <div class="buttons">
		        	<input type="submit" value="등록" style="height:25px" />
		        	<input type="button" value="취소" style="height:25px"
		        		onclick="location.href='/scheduler/';" />
		        	<!-- location.href='path' : path로 이동하는 javascript 명령 -->
		        </div>
		        </form:form>
		    </div>
		</div>   	
	
	</div>

</body>
</html>