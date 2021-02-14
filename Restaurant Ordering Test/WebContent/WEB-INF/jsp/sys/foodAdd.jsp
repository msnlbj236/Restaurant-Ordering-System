<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="common.jsp" %>
<%@taglib  prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<!-- 包含公共的JSP代码片段 -->
<title>Ordering system</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	//菜品名失去焦点调用
	function ajaxFoodName(){
		var flag = true;
		$("#message").html("");
		//获取用户输入的菜品名
		var foodName = $("#foodName").val();
		if(foodName == null || foodName == ""){
			$("#message").html("Food name cannot be blank");
			flag = false;
		}else{
			//查询用户输入的菜品名是否已经存在
			jQuery.ajax({
				   type: "POST",
				   url: "${ctx}/sys/food.action?method=ajaxFoodName",
				   data: "foodName="+foodName, 
				   dataType:"text",
				   async:false,
				   success: function(msg){
					   if(msg != null && msg == "fail"){
                    	  $("#message").html("This food name already exsits, please enter a new one！");
                    	  $("#foodName").val("");
                    	  flag = false;
                      }
				   },error:function(){
					   alert("Something went wrong when loading data.");
				   }
			})
		}
		return flag;
	}
	
	function ajaxPrice(){
		var flag = true;
		$("#message").html("");
		var price = $("#price").val();
		
		if(price == null || price == ""){
			$("#message").html("Food price cannot be blank.");
			flag = false;
		}else if(!/^(([1-9]\d*[.]\d\d?)|([0][.]\d\d?)|([1-9]\d*)|0)$/.test(price)){
			//校验价格是否符合要求
			/* 价格有小数     2.00 12.22     0.2 0.22
				价格是整数  32   2
				价格为0
				
				*  匹配前面的表达式零次或多次 
				?  匹配前面的子表达式零次或一次
				https://www.jb51.net/tools/regexsc.htm
			*/
			$("#message").html("please enter food price correctly！");
			$("#price").val("");
			flag = false;
		}
		return flag;
	}
	
	
	function ajaxNum(){
		var flag = true;
		$("#message").html("");
		var discount = $("#discount").val();
		
		if(discount != null && discount != ""){
			//判断是否符合要求  0-1  			0  0.22      1   1.0   1.00 
			//0([.]\d{1,2})?|1([.]0{1,2})?
			if(!/^(0([.]\d{1,2})?|1([.]0{1,2})?)$/.test(discount)){
				$("#message").html("Discount can only be 2 decimals between 0 and 1.");
				$("#discount").val("");
				flag = false;
			}
		}
		return flag;
	}
	
	function addSubmitTest(){
		//再次进行校验
		if(!ajaxFoodName() || !ajaxPrice() || !ajaxNum()){
			return false;
		}
		
		//获取的是上传文件的本地路径  C:\fakepath\木瓜牛奶.jpg
		var imgName = $("#img").val();
		
		//找到最后.的索引值
		var extStar = imgName.lastIndexOf(".");
		//获取 .jpg  改为小写
		var  ext = imgName.substring(extStar,imgName.length).toLowerCase();
		
		if(imgName == null || imgName == "" ){
			$("#message").html("Please upload food image of png,jpg,gif,jpeg,bmp format");
			return false;
		}else if(ext.match(/.png|.jpg|.gif|.jpeg|.bmp/i) == null){
			//表明用户上传的文件不符合要求
			$("#message").html("Sorry, the food image can only be png,jpg,gif,jpeg,bmp format.");
			return false;
		}
		//提交表单
		document.getElementById("form").submit();
	}
</script>
</head>
<body>

<!-- 页面标题 -->
<div id="TitleArea">
	<div id="TitleArea_Head"></div>
	<div id="TitleArea_Title">
		<div id="TitleArea_Title_Content">
			<img border="0" width="13" height="13" src="../images/sys/title_arrow.gif"/> Add new food
		</div>
    </div>
	<div id="TitleArea_End"></div>
</div>

<!-- 主内容区域（数据列表或表单显示） -->
<div id="MainArea">
	 <!-- from标签必须设置  enctype="multipart/form-data" 默认post -->
	<form id="form" action="${ctx}/sys/food.action" method="post" enctype="multipart/form-data">
		<input type="hidden" name="method" value="addSubmit">
		<!-- 本段标题（分段标题） -->
		<div class="ItemBlock_Title">
        	<img width="4" height="7" border="0" src="../images/sys/item_point.gif">Food information&nbsp;
        </div>
		<!-- 本段表单字段 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
				<div class="ItemBlock2">
					<table cellpadding="0" cellspacing="0" class="mainForm">
                    	<tr>
							<td width="80px">Food type</td>
							<td>
	                            <select name="foodTypeId" id="foodTypeId" name="cid" style="width:150px">
									<c:forEach items="${foodTypes}"  var="foodType">
										<option value="${foodType.id}">${foodType.typeName}</option>
									</c:forEach>
	                            </select>
	                             *
	                             <label color="red" id="message"></label>
	                        </td>
						</tr>
						<tr>
							<td width="80px">Food name</td>
							<td><input type="text" id="foodName" name="foodName" onblur="ajaxFoodName()" value="" class="InputStyle"/> *</td>
						</tr>
						<tr>
							<td>Price</td>
							<td><input type="text" placeholder="can only be number, and should have 2 decimals"  onblur="ajaxPrice()" id="price" name="price" value="" class="InputStyle" /> *</td>
						</tr>
                        <tr>
							<td>Discount</td>
							<td><input type="text" placeholder="between 0-1, e.g.0.8" onblur="ajaxNum()" value="" id="discount" name="discount" class="InputStyle" /></td>
						</tr>
						
						<tr>
							<td>Introduction</td>
							<td><textarea name="remark" value="" id="remark" class="TextareaStyle"></textarea></td>
						</tr>
						<tr>
							<td width="80px">food image</td>
							<td>
								<input type="file" id="img" name="img"/> *
							</td>
						</tr>
					</table>
				</div>
            </div>
        </div>
		
		
		<!-- 表单操作 -->
		<div id="InputDetailBar">
			<input type="button" onclick="addSubmitTest()" value="Add" class="FunctionButtonInput">
            <a href="javascript:history.go(-1);" class="FunctionButton">Back</a>
        </div>
	</form>
</div>
</body>
</html>
