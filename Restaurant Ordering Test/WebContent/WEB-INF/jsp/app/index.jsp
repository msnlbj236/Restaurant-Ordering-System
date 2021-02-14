<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> 
	/* 页面加载的时候添加一个定时器，0秒之后执行hideURLbar函数。hideURLbar函数将页面滚动至坐标（0,1）
	 因为chrome等浏览器会有滚动缓存功能，比如你在A页面滚动后跳转到B页面，点击返回键回到A页面，会发现滚动条位置仍然保持 */
	addEventListener("load", function() { 
			setTimeout(hideURLbar, 0); 
		}, false); 
		
		function hideURLbar(){ 
			window.scrollTo(0,1); 
		}
		
	window.onload = function(){
		//获取用户选中的物品类型
		var tableStatus = "${tableStatus}";
		var agileinfo_search = document.getElementById("agileinfo_search");
		
		//获取下拉框中所有的option
		var options = agileinfo_search.options;
		
		$.each(options,function(i,item){
			//如果option的value值等于用户选择的tableStatus就被选中
			$(item).attr("selected",item.value == tableStatus);
		})
	}	
	
	function dataChange(obj){
		//获取用户输入的餐桌名
		var tableName = $("#tableName").val();
		//餐桌的使用状态
		var tableStatus = obj.value;
		
		window.location = "${pageContext.request.contextPath}/app/index.do?method=submitTable&tableName="+tableName+"&tableStatus="+tableStatus;
	}
</script>

</head>
<body> 
	<!-- banner -->
	<div class="banner" style="height: 900px;">
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
								<li><a href="${pageContext.request.contextPath}/app/index.do" class="active"> Home </a></li>	
								<!-- Mega Menu -->
								<li>
									<a href="${pageContext.request.contextPath}/app/menuList.do" class="dropdown-toggle" >Menu </a>
								</li>
								<li class="w3pages">
									<a href="${pageContext.request.contextPath}/app/order.action?method=list" class="dropdown-toggle">My orders</a>
								</li>  
								<c:if test="${empty session_user }">
									<li class="head-dpdn">
										<a href="${pageContext.request.contextPath}/app/login.do">Login</a>
									</li>
									<li class="head-dpdn">
										<a href="${pageContext.request.contextPath}/app/register.do">Sign up for free</a>
									</li>
								</c:if>
								<c:if test="${not empty session_user }">
									<li class="head-dpdn">
										<a>${session_user.loginName} Hello! </a>
									</li>
									<li class="head-dpdn">
										<a href="${pageContext.request.contextPath}/app/loginout.action">Logout</a>
									</li>
								</c:if>
								<li class="head-dpdn">
									<a href="${pageContext.request.contextPath}/sys/index.action">Backstage Management </a>
								</li>
							</ul>
						</div>
					</nav>
				</div>
			</div>
			<!-- //navigation --> 
		</div>
		<!-- //header-end --> 
		<!-- banner-text -->
		<div class="banner-text">	
			<div class="container" style="padding-left: 280px;margin-top: -100px;">
				<div class="agileits_search">
					<form action="${pageContext.request.contextPath}/app/index.do" method="post">
						<input type="hidden"  name="method"  value="submitTable">
						<div id="serchResult" cstyle="margin-top: 20px;">
							<c:if test="${not empty dinnerTables}">
								<c:forEach items="${dinnerTables}" var="dinnerTable" >
									 <a href="${pageContext.request.contextPath}/app/menu.action?id=${dinnerTable.id}" style="color: white;font-size: 20px;"">
									 	${dinnerTable.tableName}
									 </a>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
								</c:forEach>
							</c:if>
							<c:if test="${ empty dinnerTables}">
								No tables match the requirements now.
							</c:if>
							 <br><br>
						</div>
						<input name="tableName" id="tableName" type="text" placeholder="Table name" >
						<select id="agileinfo_search" name="tableStatus" onchange="dataChange(this)">
							<option value="">All tables</option>
							<option value="1">Tables in use</option>
							<option value="0">Tables not in use</option>
						</select>
						<input type=submit   value="View tables">
					</form>
				</div> 
			</div>
		</div>
	</div>
	
</body>
</html>