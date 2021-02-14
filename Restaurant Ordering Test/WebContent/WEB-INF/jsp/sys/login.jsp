<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx}/css/sys/login.css" rel="stylesheet" type="text/css" />

<style type="text/css">

</style>
<script type="text/javascript">
if(window.location != parent.window.location){
	   //将当前页面作为最顶级页面
	   parent.window.location = window.location;
	   
}

//在页面完成加载时调用
window.onload = function(){
	document.getElementById("loginname").focus();
	document.onkeydown = function(){
		// firefox没有window.event对象
		var event = arguments[0] ? arguments[0] : window.event;
		if (event.keyCode === 13){
			submitTable();
		}
	};
};

function submitTable(){
	//验证用户名和密码是否输入
	var loginname = document.getElementById("loginname").value;
	if(loginname == null || loginname == "" || loginname.length == 0){
		$("#message").html("Please enter your username！");
		document.getElementById("loginname").focus;
		return false;
	} 
	var password = document.getElementById("password").value;
	if(password == null || password == "" || password.length == 0){
		$("#message").html("Please enter your password！");
		document.getElementById("password").focus;
		return false;
	} 
	document.getElementById("loginform").submit();

}
</script>
</head>

<body>
 	
	<!-- 上部 -->
	<div id="Head_1">
		<!-- 标题 -->
		<div id="Head_1_Logo">
			<b style="font-family: '黑体'">Ordering system backstage login</b>
        </div>
	</div>
	<div class="logo_box">
		<form action="${ctx}/sys/login.do" method="post" id="loginform"> 
			<input type="hidden"  name="method" value="submitTable">
			<center> <font color="red"  id="message">${message}</font></center>
			<div class="input_outer">
				<span class="u_user"></span>
				<input name="loginname" id="loginname" class="text" autocomplete="off"   placeholder="Please enter your username" style="color: black !important" class="text">
			</div>
			<div class="input_outer">
				<span class="us_uer"></span>
				<input name="password" id="password" placeholder="Please enter your password"  type="password" autocomplete="off" class="text" style="color: black !important; position:absolute; z-index:100;" >
			</div>
			<input id="remenber" name="remenber" value="reme" class="checkbox" type="checkbox"><span>Remember for one week</span>
			<a href="${ctx}/sys/register.do" style="float:right;color: #0096e6;">Register！</a>
			<div class="mb2">
				<a class="act-but submit" href="javascript:;" onclick="submitTable()"  style="color: black">Login</a>
			</div>
		</form>
	</div>
</body>
</html>