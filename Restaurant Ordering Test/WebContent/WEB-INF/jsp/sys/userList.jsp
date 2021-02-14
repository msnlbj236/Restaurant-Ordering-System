<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ include file="common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!-- 包含公共的JSP代码片段 -->
<title>Ordering system</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript">
//文档加载完后
window.onload=function(){
	//获取后台保存的disabled值
	var disabled = "${disabled}";
	var disabledSelect = document.getElementById("disabled");
	//获取下拉框中所有的option
	var  options = disabledSelect.options;
	
	$.each( options, function(i, option){
	  $(option).attr("selected",option.value == disabled);
	});
	
	
	var searchType = "${searchType}";
	var searchTypeSelect = document.getElementById("searchType");
	//获取下拉框中所有的option
	var  options = searchTypeSelect.options;
	
	$.each( options, function(i, option){
	  $(option).attr("selected",option.value == searchType);
	});
}

function disabledChange(obj){
	//获取用户输入的关键字
	var keyword = $("#keyword").val();
	
	//获取被选中的餐桌是否删除的状态
	var disabled = obj.value;
	
	//发送请求
	window.location = "${ctx}/sys/userList.action?keyword="+keyword+"&disabled="+disabled+"&method=list&searchType="+$("#searchType").val();
}
</script>
</head>
<body>
	<!-- 页面标题 -->
	<div id="TitleArea">
		<div id="TitleArea_Head"></div>
		<div id="TitleArea_Title">
			<div id="TitleArea_Title_Content">
				<img border="0" width="13" height="13"
					src="../images/sys/title_arrow.gif" /> User list
			</div>
		</div>
		<div id="TitleArea_End"></div>
	</div>
	<!-- 过滤条件 -->
	<div id="QueryArea">
		<form action="${ctx }/sys/userList.action" method="get" target="right">
			<input type="hidden" name="method" value="list">
			<input type="text" id="keyword" name="keyword" value="${keyword}"  >
			<!-- 餐桌使用状态的select标签 -->
			<select name="searchType" id="searchType" onchange="typeChange(this)" >
				<option value="name">Name</option>
				<option value="email">Email</option>
				<option value="phone">Phone</option>
			</select>
			<select name="disabled" id="disabled" onchange="disabledChange(this)">
				<option value="">All</option>
				<option value="0">Remained</option>
				<option value="1">Deleted</option>
			</select>
			<input type="submit" value="Search">
			<a href="${ctx}/sys/userList.action?method=addPage" target="right"><input type="button" value="Add"></a>
		</form>
	</div>

	<!-- 主内容区域（数据列表或表单显示） -->
	<div id="MainArea">
		<table class="MainArea_Content" style="text-align: center;" cellspacing="0" cellpadding="0">
			<!-- 表头-->
			<thead>
				<tr align="center" valign="middle" id="TableTitle">
					<td>ID</td>
					<td>Name</td>
					<td>Email</td>
					<td>Phone number</td>
					<td>Created user</td>
					<td>Created time</td>
					<td>Condition</td>
					<td>Action</td>
				</tr>
			</thead>
			<!--显示数据列表 -->
			<tbody id="TableData">
				<c:choose>
					<c:when test="${not empty users}">
						<c:forEach items="${users}"  var="user"  varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>${user.loginName }</td>
								<td>${user.email }</td>
								<td>${user.phone }</td>
								<td>${user.createUser.loginName }</td>
								<td><fmt:formatDate value="${user.createDate }"  pattern="yyyy-MM-dd  HH:ss:mm"/> </td>
								<td>
									<c:if test="${user.disabled == 0}">
										Remained
									</c:if>
									<c:if test="${user.disabled == 1}">
										Deleted
									</c:if>
								</td>
								<td>
									<a href="${ctx }/sys/userList.action?id=${user.id}&method=viewUpdate" class="FunctionButton">Update</a>
									<c:if test="${user.disabled == 0}">
										<a href="${ctx }/sys/userList.action?id=${user.id}&method=update&disabled=1" class="FunctionButton">Delete</a>
									</c:if>
									<c:if test="${user.disabled == 1}">
										<a href="${ctx }/sys/userList.action?id=${user.id}&method=update&disabled=0" class="FunctionButton">Activate</a>
									</c:if>
								</td>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:when test="${empty foodTypes}">
						<tr>
							<td colspan="3" style="text-align: center;">Not found the data you want！</td>
						</tr>
					</c:when>
				</c:choose>
					

			</tbody>
		</table>
	</div>
</body>
</html>
