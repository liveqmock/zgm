<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>入库检测</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<link rel="stylesheet" type="text/css" href="${ctx }/js/validate/jquery.validate.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/admin/style.css">
		<link rel="stylesheet" type="text/css" href="${ctx }/css/admin/theme1.css">
		
		<script type="text/javascript" src="${ctx }/js/jquery-1.6.1.js"></script>
		<script type="text/javascript" src="${ctx }/js/validate/jquery.metadata.js"></script>
		<script type="text/javascript" src="${ctx }/js/validate/jquery.validate.js"></script>
		<script type="text/javascript" src="${ctx }/js/date/WdatePicker.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$("#myForm").validate();
			});
		
    		function addDetail(){
				window.location.href = "${ctx}/supervisor/insCheck/addDetail";
			}
			
			function addRecordInfo(){
				window.location.href = "${ctx}/supervisor/insCheck/addRecordInfo";
			}
			
			//删除
			function del(index){
				if (confirm("确定要删除吗？")){
					$("#myForm").attr("action","${ctx }/supervisor/insCheck/delDetail/" + index);
					$("#myForm").submit();
				}
			}
			
    	</script>
	
	<style type="text/css">
		.button{
			background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;
			border: 1px solid #D9E6F0;
		}
	</style>
	
	</head>

	<body>
		<form action="${ctx }/supervisor/insCheck/saveList" method="post" id="myForm" name="myForm" enctype="multipart/form-data">
			<div align="center" id="content"">
				<div id="box">
					<h3 align="left">
						入库检测
					</h3>
					<div align="left">
						<c:if test="${not empty messageOK}">
							<div class="flash notice">
								&nbsp;&nbsp;${messageOK}
							</div>
						</c:if>
						<c:if test="${not empty messageErr}">
							<div class="flash error">
								&nbsp;&nbsp;${messageErr}
							</div>
						</c:if>
					</div>
					<div>
						入库检测总重量（g）：${ sessionScope.weight[0]} 
						<br>
						光谱法检测重量（g）：${ sessionScope.weight[1]} 
						<br>
						熔金法检测重量（g）：${ sessionScope.weight[2]} 
						<br>
						&nbsp;
					</div>
					<br/>
					<table style="text-align: center; font: 12px/ 1.5 tahoma, arial, 宋体;" width="100%">
						<thead>
							<tr>
								<th width="5%">序号</th>
								<th>款式大类</th>
								<th>检测方法</th>
								<th>检测重量（g）</th>
								<th>检测结果</th>
								<th>&nbsp;</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${detailList}" var="insCheckDetail" varStatus="status">
							<tr>
								<td>${status.count}&nbsp;</td>
								<td>${insCheckDetail.style.name}&nbsp;</td>
								<td>${insCheckDetail.checkMethod.title}&nbsp;</td>
								<td>${insCheckDetail.checkWeight}&nbsp;</td>
								<td>${insCheckDetail.checkResult.title}&nbsp;</td>
								<th>
									<a href="${ctx }/supervisor/insCheck/editDetail/${status.count}">编辑</a>
									<a href="#" onclick="del(${status.count});">删除</a>
								</th>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<div align="center" id="pager">
						<input type="button" value="添加记录" class="button" onclick="addDetail()" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${detailListCount > 0}">
							<input type="submit" value="生成入库检测单" class="button" />
						</c:if>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>

