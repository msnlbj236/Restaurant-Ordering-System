<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Menu</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
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
							<h1><a href="index.do">Ordering system</a></h1>
						</div> 
						<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="${pageContext.request.contextPath}/app/index.do" class="active">Home</a></li>	
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
										<a>${session_user.loginName} Hello！</a>
									</li>
									<li class="head-dpdn">
										<a href="${pageContext.request.contextPath}/app/loginout.action">Logout</a>
									</li>
								</c:if>
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
			<li><a href="${pageContext.request.contextPath}/app/index.do"><i class="fa fa-home"></i> Home</a></li> 
			<li class="active">Menu</li>
		</ol>
	</div>
	<!-- //breadcrumb -->
	<!-- products -->
	<div class="products">	 
		<div class="container">
			<div class="col-md-9 product-w3ls-right"> 
				<div class="product-top">
					<h4>Food type</h4>
					<div class="clearfix"> </div>
				</div>
				<div class="products-row">
					<c:if test="${not empty foods }">
						<c:forEach items="${foods}"  var="food">
							<div class="col-xs-6 col-sm-4 product-grids">
								<div class="flip-container">
									<div class="flipper agile-products">
											<div class="front"> 
												<img  src="${pageContext.request.contextPath}/images/app/food/${food.img}" style="width: 250px;height: 150px" class="img-responsive" alt="img">
												<div class="agile-product-text">              
													<h5>${food.foodName}</h5>  
												</div> 
											</div>
											<div class="back">
												<h4>${food.foodName}</h4>
												<p>${food.remark}</p>
												<h6>
													<fmt:formatNumber value="${food.price*food.discount}" pattern="0.00"></fmt:formatNumber><sup>￥</sup>
												</h6>
												<a href="#" >Details</a>
											</div>
									</div>
								</div> 
							</div> 
						</c:forEach>
					</c:if>
					<c:if test="${ empty foods }">
						Sorry, we have no food in this food type currently.
					</c:if>
					<!-- <center><font color="red"> 当前类别暂未有食品</font></center>  -->
				</div>	
			</div>	 
			<div class="col-md-3 rsidebar" style="width: 22%;">
				<div class="rsidebar-top">
					<div class="sidebar-row">
						<h4>Food type</h4>
						<ul class="faq">
							<c:forEach items="${foodTypes}" var="foodType">
								<li class="item1">
								<a href="${pageContext.request.contextPath}/app/menuList.do?foodTypeId=${foodType.id}" >
									${foodType.typeName }
								</a></li>
							</c:forEach>
						</ul>
						<div class="clearfix"> </div> 
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>