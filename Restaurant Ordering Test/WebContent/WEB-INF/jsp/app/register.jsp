<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>注册</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<!-- Custom Theme files -->
<!-- regex.js是正则表达式的一系列判断 -->
<script type=text/javascript src="${pageContext.request.contextPath}/js/regex.js"></script>
<script type="text/javascript">
	$(function(){
		//不同意协议  注册提交按钮为灰无法使用
	    var regBtn = jQuery("#register");
	    jQuery("#readme").change(function(){
	    	//选中已同意，返回true
	        var checkedValue = jQuery("#readme").prop("checked");
	        if(checkedValue){
	            regBtn.prop("disabled",false);
	            regBtn.css("background","#08cae2");
	        }else{
	            regBtn.prop("disabled",true);
	            regBtn.css("background","#909090");
	        }
	    });
	});
	
	function  formOnblur(id){
		//获取当前需要校验的输入框的值
		var  fieldValue = document.getElementById(id).value;
		document.getElementById(id+"_error").innerHTML="";
		var flag = true;
		if(id == "loginName"){
			if(fieldValue == null || fieldValue == ""){
				document.getElementById(id+"_error").innerHTML="Please enter your username";
				flag = false;
			}else{
				//校验登录名是否已经在数据库存在
				$.ajax({
				   type: "POST",
				   url: "${pageContext.request.contextPath}/app/register.do",
				   data: "method=ajaxLoginName&loginName="+fieldValue,
				   //同步请求
				   async:false,  
				   success: function(msg){
				     	if(msg){
				     		document.getElementById(id+"_error").innerHTML=msg;
				     		flag = false;
				     	}
				   }
				});
			}
		}else if(id == "phone"){
			if(fieldValue == null || fieldValue == ""){
				document.getElementById(id+"_error").innerHTML="Please enter your phone number.";
				flag = false;
			}else{
				if(!checkPhone(fieldValue)){
					document.getElementById(id+"_error").innerHTML="Your phone number is not valid.";
					flag = false;
				}
			}
		}else if(id == "email"){
			if(fieldValue == null || fieldValue == ""){
				document.getElementById(id+"_error").innerHTML="Please enter your email address.";
				flag = false;
			}else{
				if(!checkEmail(fieldValue)){
					document.getElementById(id+"_error").innerHTML="Your email address is not valid.";
					flag = false;
				}
			}
		}else if(id == "passWord"){
			if(fieldValue == null || fieldValue == ""){
				flag = false;
				document.getElementById(id+"_error").innerHTML="Please enter your password, which consists of 6-16 characters or numbers.";
			}else{
				if(!checkPassword(fieldValue)){
					flag = false;
					document.getElementById(id+"_error").innerHTML="Your password is not valid.";
				}
			}
		}else if(id == "okPassWord"){
			if(fieldValue == null || fieldValue == "" ||
					$("#passWord").val() == null  || $("#passWord").val() == "" ||
					$("#passWord").val() != fieldValue){
				flag = false;
				document.getElementById(id+"_error").innerHTML="Two password should be consistent and cannot be blank.";
			}
		}
		return flag;
	}
	
	function onRegister(){
		//获取所有输入框的ID
		var ids = ["loginName","phone","email","passWord","okPassWord"];
		
		//遍历所有输入框的ID
		for (var i = 0; i < ids.length; i++) {
			//只有其中一个输入框不符合要求，就不提交表单
			if(!formOnblur(ids[i])){
				//不符合要求
				return false;
			}
		} 
		
		//提交表单
		document.getElementById("registerform").submit();
	}
	
	
	
</script> 
</head>
<body> 
	<!-- banner -->
	<div class="banner about-w3bnr">
		<!-- header -->
		<div class="header">
			<!-- navigation -->
			<div class="navigation agiletop-nav">
				<div class="container">
					<nav class="navbar navbar-default">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header w3l_logo">
							<h1><a href="${pageContext.request.contextPath}/app/index.do">Ordering system</a></h1>
						</div> 
						<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="${pageContext.request.contextPath}/app/index.do" class="active">Home</a></li>	
								<!-- Mega Menu -->
								<li class="dropdown">
									<a href="${pageContext.request.contextPath}/app/menuList.do" class="dropdown-toggle" >Menu </a>
								</li>
								<li class="w3pages">
									<a href="${pageContext.request.contextPath}/app/order.action?method=list" >My orders</a>
								</li>  
								<li class="head-dpdn">
									<a href="${pageContext.request.contextPath}/sys/index.action">Backstage Management</a>
								</li>
							</ul>
						</div>
					</nav>
				</div>
			</div>
			<!-- //navigation --> 
		</div>
		<!-- //header-end --> 
	</div>
	<!-- //banner -->    
	<!-- breadcrumb -->  
	<div class="container">	
		<ol class="breadcrumb w3l-crumbs">
			<li><a href="app/index.action"><i class="fa fa-home"></i> Menu</a></li> 
			<li class="active">Register</li>
		</ol>
	</div>
	<!-- //breadcrumb -->
	<!-- sign up-page -->
	<div class="login-page about">
		<div class="container"> 
			<h3 class="w3ls-title w3ls-title1">Register a new account</h3>  
			<div class="login-agileinfo"> 
				<form action="${pageContext.request.contextPath}/app/register.do" method="post" id="registerform"  onsubmit="return  onRegister()"> 
					<center> <font color="red">${message}</font></center>
					<input type="hidden" name="method"  value="submitTable">
					<input class="agile-ltext" type="text" id="loginName" name="loginName" placeholder="Username"  autocomplete="off"
						 onblur="formOnblur(this.id);" required="" >
					<label id="loginName_error" class="null"></label>
							
					<input class="agile-ltext" type="text" id="phone" name="phone" placeholder="Phone" 
						 onblur="formOnblur(this.id);" required="">
					<label id="phone_error" class="null"></label>
												
					<input class="agile-ltext" type="email" id="email" name="email" placeholder="E-mail" 
						 onblur="formOnblur(this.id);" required="">
					<label id="email_error" class="null"></label>
					
					<input class="agile-ltext" type="password"  id="passWord" name="passWord" placeholder="Password consists of 6-16 characters or number." 
						 onblur="formOnblur(this.id);" required="">
					<label id="passWord_error" class="null"></label>
			            
					<input class="agile-ltext" type="password"  id="okPassWord" name="okPassWord" placeholder="Confirm password" 
						 onblur="formOnblur(this.id);" required="">
	                <label id="okPassWord_error" class="null"></label>
			            
					<div class="wthreelogin-text"> 
						<ul> 
							<li>
								<label class="checkbox">
									<input type="checkbox" name="readme" id="readme"  checked="checked"><i></i> 
									<span> I have carefully read and agreed to 《Terms of service of ordering system》</span>
								</label> 
							</li> 
						</ul>
						<!-- <div class="clearfix"> </div> -->
					</div><div> 
					<input type="submit" id="register" onclick="onRegister()" value="Register"> </div>
				</form>
				<p>Already have an account?  <a href="${pageContext.request.contextPath}/app/login.do"> Sign in now!</a></p> 
			</div>	 
		</div>
	</div>
	<div class="copyw3-agile"> 
		<div class="container">
			<p>Patent belongs to XXX &copy; 2018. Ordering system All.</p>
		</div>
	</div>
</body>
</html>