<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>编辑入库货物</title>
    
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
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#myForm").validate();
		});
		
		function changeStyle() {
			var selStyle = $("#style").find("option:selected").text();
			$("#styleName").val(selStyle);
		}
		
		function changePurity(ob) {
			var selPurity = $("#purity").find("option:selected").text();
			$("#pledgePurityName").val(selPurity);
		}
		
	</script>
	
  </head>
  
  <body>
    <form id="myForm" name="myForm" action="${ctx}/supervisor/insRecord/updateDetail/${index}" method="post">
    	<div id="content">
    		<div style="margin-bottom: 10px;padding: 5px 10px;" id="box">
    		<h3 id="adduser">编辑入库货物</h3>
    		<br/>
    		<fieldset style="padding: 5px 10px;" id="personal">
    			<legend><h3>请输入相关信息</h3></legend>
    			<br/>
    				<table  cellpadding="0" cellspacing="0" width="100%"  class="list1">
					<tr>
						<td width="30%">
							款式大类:
						</td>
						<td width="70%">
							<select id="style" name="style.id" class="required" onchange="changeStyle()">
								<c:forEach items="${styleList}" var="style">
									<c:choose>
										<c:when test="${style.id == insRecordDetail.style.id }">
											<option selected="selected" value = "${style.id }">${style.name }</option>
										</c:when>
										<c:otherwise>
											<option value = "${style.id }">${style.name }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<input type="hidden" id="styleName" name="style.name" value="${insRecordDetail.style.name}">
						</td>
					</tr>
					<tr>
						<td width="30%">
							标明成色:
						</td>
						<td width="70%">
							<select id="purity" name="pledgePurity.id" class="required" onchange="changePurity()">
								<c:forEach items="${pledgePurityList}" var="pledgePurity">
									<c:choose>
										<c:when test="${pledgePurity.id == insRecordDetail.pledgePurity.id }">
											<option selected="selected" value = "${pledgePurity.id }">${pledgePurity.name }</option>
										</c:when>
										<c:otherwise>
											<option value = "${pledgePurity.id }">${pledgePurity.name }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<input type="hidden" id="pledgePurityName" name="pledgePurity.name" value="${insRecordDetail.pledgePurity.name}">
						</td>
					</tr>
					<tr>
						<td width="30%">
							生产厂家:
						</td>
						<td width="70%">
							<input id="company" name="company" value="${insRecordDetail.company}" class="required" style="background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;"/>
						</td>
					</tr>
					<tr>
						<td width="30%">
							数量（件）:
						</td>
						<td width="70%">
							<input id="amount" name="amount" value="${insRecordDetail.amount}" class="{required:true,number:true}" style="background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;"/>
						</td>
					</tr>
					<tr>
						<td width="30%">
							重量（g）:
						</td>
						<td width="70%">
							<input id="weight" name="weight" value="${insRecordDetail.weight}" class="{required:true,number:true}" style="background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;"/>
						</td>
					</tr>
					<tr>
						<td width="30%">
							备注:
						</td>
						<td width="70%">
							<input id="desc" name="desc" value="${insRecordDetail.desc}" style="background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;"/>
						</td>
					</tr>
					</table>
    			<br/>
    		</fieldset>
    		<br/>
    		<div style="margin-bottom: 5px;padding: 3px;" align="center">
    				<input id="button1" type="submit" value="保存" style="cursor: pointer;font-weight: bold;margin-left: 8px;padding-right: 5px;width: 205px; background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;border: 1px solid #D9E6F0;"/>
    				<input id="button2" type="button" value="取消" onclick="javascript:history.back();" style="cursor: pointer;font-weight: bold;margin-left: 8px;padding-right: 5px;width: 205px;background: url('${ctx}/images/admin/images/form_blue.gif') repeat-x scroll left top #FFFFFF;border: 1px solid #D9E6F0;">
    		</div>
    	</div>
    	</div>
    </form>
  </body>
</html>
