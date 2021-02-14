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
	function addSubmit(){
		//获取用户输入的菜系名称
		var foodTypeName = $("#foodTypeName").val();
		if(foodTypeName != null && foodTypeName != ""){
			//没有重复返回true  保存菜系名称
			jQuery.ajax({
				   type: "POST",
				   url: "${ctx}/sys/foodType.action?method=addSubmit",
				   data: "foodTypeName="+foodTypeName, 
				   dataType:"text",
				   async:false,
				   success: function(msg){
					   if(msg != null && msg == "success"){
						   $("#message").html("Saved！");
	                    	  $("#foodTypeName").val("");
                      }else if(msg != null && msg == "fail"){
                    	  $("#message").html("This food type already exsits, please enter a new one！");
                    	  $("#foodTypeName").val("");
                      }
				   },error:function(){
					   alert("Something went wrong when loading data.");
				   }
			})
		}else{
       	 	$("#message").html("Please enter food type！");
		}
	}
</script>
</head>
<body>
<!-- 页面标题 -->
<div id="TitleArea">
	<div id="TitleArea_Head"></div>
	<div id="TitleArea_Title">
		<div id="TitleArea_Title_Content">
			<img border="0" width="13" height="13" src="${ctx }/style/images/title_arrow.gif"/>  Add food type
		</div>
    </div>
	<div id="TitleArea_End"></div>
</div>


<!-- 主内容区域（数据列表或表单显示） -->
<div id="MainArea">
	<!-- 表单内容 -->
	<form action="${ctx }/sys/foodType?method=addFoodType" method="post">
		<!-- 本段标题（分段标题） -->
		<div class="ItemBlock_Title">
        	<img width="4" height="7" border="0" src="${ctx }/images/sys/item_point.gif"> Information of food type&nbsp;
        </div>
		<!-- 本段表单字段 -->
        <div class="ItemBlockBorder">
            <div class="ItemBlock">
				<div class="ItemBlock2">
					<table cellpadding="0" cellspacing="0" class="mainForm">
						<tr>
							<td width="80px">Name of food type</td>
							<td>
								<input type="text"  id="foodTypeName" name="foodTypeName" class="InputStyle" /> *
								<label color="red" id="message"></label>
							</td>
						</tr>
					</table>
				</div>
            </div>
        </div>
		<!-- 表单操作 -->
		<div id="InputDetailBar">
			<input type="button"  onclick="addSubmit()" value="Add" class="FunctionButtonInput">
            <a href="javascript:history.go(-1);" class="FunctionButton">Back</a>
        </div>
	</form>
</div>
</body>
</html>
