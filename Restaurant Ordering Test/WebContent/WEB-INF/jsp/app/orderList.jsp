<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order list</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
</head>
<body> 
	<!-- banner -->
	<div class="banner about-w3bnr">
		<!-- header -->
		<div class="header">
			<!-- //header-one -->    
			<!-- navigation -->
			<div class="navigation agiletop-nav">
				<div class="container">
					<nav class="navbar navbar-default">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header w3l_logo">
							
							<h1><a href="${ctx}/app/index.do">Ordering system</a></h1>
						</div> 
						<div class="collapse navbar-collapse" id="bs-megadropdown-tabs">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="${pageContext.request.contextPath}/app/index.do" class="active">Home</a></li>	
								<!-- Mega Menu -->
								<li>
									<a href="${pageContext.request.contextPath}/app/menuList.do" class="dropdown-toggle" >Menu </a>
								</li>
								<li class="w3pages">
									<a href="${pageContext.request.contextPath}/app/order.action?method=list" class="dropdown-toggle">My Orders</a>
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
									<a href="${pageContext.request.contextPath}/sys/index.action">Backstage management</a>
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
			<li><a href="${ctx}/app/index.do"><i class="fa fa-home"></i> Home</a></li> 
			<li class="active">My orders</li>
		</ol>
	</div>
	<!-- //breadcrumb -->
	<!-- products -->
	<div class="products">	 
		<div class="container">
			<div class="col-md-12 ">
				<!-- 查询 所有订单遍历  未付款的排在上面     开始-->
				<div class="rsidebar-top col-md-12">
					<!-- 遍历所有的订单 -->
					<c:if test="${not empty orders }">
						<c:forEach items="${orders}" var="order">
							<div class="sidebar-row">
								<h4>
									<span class="col-md-10">
										${order.dinnerTable.tableName}
										Order Id：${order.orderCode}
										Placed time：<fmt:formatDate value="${order.orderDate}"  pattern="yyyy-MM-dd HH:mm:ss"/>
									</span>
									<span class="col-md-2">
										<font color="#0096e6">
											<c:if test="${order.orderStatus ==1 }">
												Paid
											</c:if>
											<c:if test="${order.orderStatus ==0 }">
												<c:if test="${order.disabled ==1 }">
													Cancelled 
												</c:if>
												<c:if test="${order.disabled ==0 }">
												Need a payment
												</c:if>
											</c:if>
											￥<fmt:formatNumber value="${order.totalPrice }" pattern="0.00"></fmt:formatNumber>
										</font>
									</span>
								</h4>
								<ul class="faq">
									<c:forEach items="${order.orderDetails }" var="orderDetail">
										<li>
											<a href="#">
												<span class="col-md-8">${orderDetail.food.foodName }</span>
												<span class="col-md-2">${orderDetail.buyNum} share</span>
												<span class="col-md-2">
													￥<fmt:formatNumber value="${orderDetail.food.price*orderDetail.discount}" pattern="0.00"></fmt:formatNumber>
												</span>
											</a>
										</li>
									</c:forEach>
								</ul>
							<hr>
							</div>
						</c:forEach>
					</c:if>

					<!-- <div class="sidebar-row"><center><font color="red">There is no order now！</font></center></div> -->
				</div>	 
				</div>
				<div class="clearfix">&nbsp;</div>
				<!-- 查询 所有订单遍历  未付款的排在上面		结束-->
			</div>
		</div>
</body>
</html>