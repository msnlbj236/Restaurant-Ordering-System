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
	//遍历菜系是否删除状态select标签中所有的option标签
	var disabledSelect = document.getElementById("disabled");
	//获取下拉框中所有的option
	var  options = disabledSelect.options;
	
	$.each( options, function(i, option){
	  $(option).attr("selected",option.value == disabled);
	});
}

function disabledChange(obj){
	//获取用户输入的关键字
	var keyword = $("#keyword").val();
	
	//获取被选中的餐桌是否删除的状态
	var disabled = obj.value;
	
	//发送请求
	window.location = "${ctx}/sys/foodType.action?keyword="+keyword+"&disabled="+disabled+"&method=list";
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
					src="../images/sys/title_arrow.gif" /> Food type list
			</div>
		</div>
		<div id="TitleArea_End"></div>
	</div>
	<!-- 过滤条件 -->
	<div id="QueryArea">
		<form action="${ctx }/sys/foodType.action" method="get" target="right">
			<input type="hidden" name="method" value="list">
			<input type="text" id="keyword" name="keyword" value="${keyword}" placeholder="Please enter name of food type.">
			<select name="disabled" id="disabled" onchange="disabledChange(this)">
				<option value="">All</option>
				<option value="0">Deleted</option>
				<option value="1">Remained</option>
			</select>
			<input type="submit" value="Search">
			<a href="${ctx}/sys/foodType.action?method=addPage" target="right"><input type="button" value="Add"></a>
		</form>
	</div>

	<!-- 主内容区域（数据列表或表单显示） -->
	<div id="MainArea">
		<table class="MainArea_Content" style="text-align: center;" cellspacing="0" cellpadding="0">
			<!-- 表头-->
			<thead>
				<tr align="center" valign="middle" id="TableTitle">
					<td>ID</td>
					<td>Food type name</td>
					<td>Created time</td>
					<td>Deleted or not</td>
					<td>Actions</td>
				</tr>
			</thead>
			<!--显示数据列表 -->
			<tbody id="TableData">
				<c:choose>
					<c:when test="${not empty foodTypes}">
						<c:forEach items="${foodTypes}"  var="foodType"  varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>${foodType.typeName }</td>
								<td><fmt:formatDate value="${foodType.createDate }"  pattern="yyyy-MM-dd  HH:ss:mm"/> </td>
								<td>
									<c:if test="${foodType.disabled == 0}">
										Deleted 
									</c:if>
									<c:if test="${foodType.disabled == 1}">
										Remained
									</c:if>
								</td>
								<td>
									<a href="${ctx }/sys/foodType.action?id=${foodType.id}&method=viewUpdate" class="FunctionButton">Update</a>
									<c:if test="${foodType.disabled == 0}">
										<a href="${ctx }/sys/foodType.action?id=${foodType.id}&method=update&disabled=1" class="FunctionButton">Delete</a>
									</c:if>
									<c:if test="${foodType.disabled == 1}">
										<a href="${ctx }/sys/foodType.action?id=${foodType.id}&method=update&disabled=0" class="FunctionButton">Activate</a>
									</c:if>
								</td>
							</tr>
						
						</c:forEach>
					</c:when>
					<c:when test="${empty foodTypes}">
						<tr>
							<td colspan="3" style="text-align: center;">Not found any data you want！</td>
						</tr>
					</c:when>
				</c:choose>
					

			</tbody>
		</table>
	</div>
</body>
</html>
