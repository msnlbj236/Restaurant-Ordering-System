<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Order details</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="text/javascript">
	//Make a payment
	function pay(orderId){
		window.location.href="${pageContext.request.contextPath}/app/order.action?method=pay&orderId="+orderId;
	}
	
	//Cancel the order
	function deleteOrder(orderId){
		window.location.href="${pageContext.request.contextPath}/app/order.action?method=delete&orderId="+orderId;
	}
</script>
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
							
							<h1><a href="${pageContext.request.contextPath}/app/index.do">Ordering system</a></h1>
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
			<li><a href="index.do"><i class="fa fa-home"></i> Home</a></li> 
			<li class="active">${dinnerTable.tableName} order details</li>
		</ol>
	</div>
	<!-- //breadcrumb -->
	<!-- products -->
	<div class="products">	 
		<div class="container">
			<div class="col-md-12 ">
				<!-- 查询 所有订单遍历  未付款的排在上面     开始-->
				<div class="rsidebar-top col-md-12">
					<div class="sidebar-row">

						<!--遍历为付款未删除的订单开始-->
						<c:if test="${not empty orders}">
							<c:forEach  items="${orders}"  var="order">
								<h4>
								<span class="col-md-12">
									Order id：${order.orderCode}
									Placed time：<fmt:formatDate value="${order.orderDate}"  pattern="yyyy-MM-dd HH:mm:ss"/>
								</span>
								</h4>
								<ul class="faq">
									<!-- 订单明细遍历开始 -->
									<c:if test="${not empty  order.orderDetails}">
										<c:forEach items="${order.orderDetails}"  var="orderDetail">
											<li>
												<a href="#">
													<span class="col-md-8">${orderDetail.food.foodName}</span>
													<span class="col-md-2">${orderDetail.buyNum}份</span>
													<span class="col-md-2">
														￥<fmt:formatNumber value="${orderDetail.food.price*orderDetail.discount}" pattern="0.00"></fmt:formatNumber>
													</span>
												</a>
											</li>
										</c:forEach>
									</c:if>
									<!-- 订单明细遍历结束 -->
								</ul>
								<br/>
								<span class="col-md-8"></span>
								<span class="col-md-4">
									<font color="#0096e6">
									总计:￥ <fmt:formatNumber value="${order.totalPrice}" pattern="0.00"></fmt:formatNumber></font>
										<!-- 订单id -->
										<c:if test="${order.orderStatus == 0 && (session_user.id == order.creatUserId)}">
											<!-- 参数为订单id -->
											<input type="button" onclick="pay(${order.id})" value="Make a payment">
											<input type="button" onclick="deleteOrder(${order.id})" value="Cancel the order">
										</c:if>
								</span>
							</c:forEach>	
						</c:if>
						<!--遍历订单结束-->

						<!-- <center><font color="red">There is no order now.！</font></center> -->
					</div>	 
				</div>
				<div class="clearfix">&nbsp;</div>
			</div>
		</div>
	</div>
</body>
</html>