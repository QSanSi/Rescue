<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-志愿者-信息</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<input type="hidden" value="${vol.volId}" name="volId">
							<div class="form-group">
								<label class="col-sm-4 control-label">真实姓名：</label>
								<div class="col-sm-5">
									<input id="realname" name="realname" type="text" class="form-control"
										 value="${vol.realname}" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">性别：</label>
								<div class="col-sm-5">
									<select id="gendar" class="chosen-select" name="gendar" style="width:120px;" disabled="disabled">
										<option value="-1">请选择性别</option>
										<option value="0" <c:if test="${vol.gendar==0}">selected</c:if>>男
										</option>
										<option value="1" <c:if test="${vol.gendar==1}">selected</c:if>>女
										</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="tel" name="tel" type="tel" class="form-control"
										value="${vol.tel}" autocomplete="off" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">身份证信息：</label>
								<div class="col-sm-5">
									<input id="idcard" type="text" class="form-control"
										name="idcard" value="${vol.idcard}" autocomplete="off" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">注册站点：</label>
								<div class="col-sm-5">
									<select id="deptId" class="chosen-select" name="deptId" style="width:120px;" disabled="disabled">
										<option value="-1">请选择站点</option>
										<c:forEach items="${deptlist}" var="dept">
											<option value="${dept.deptId}" <c:if test="${vol.deptId==dept.deptId}">selected</c:if>>${dept.deptName}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">志愿地区：</label>
								<div class="col-sm-5">
                                	<select id="province" name="province" class="chosen-select" style="width:120px;" disabled="disabled">
                                		<option value="-1">-- 请选择省 --</option>
									</select>
									<select id="city" name="city" class="chosen-select" style="width:120px;" disabled="disabled">
                                		<option value="-1">-- 请选择市 --</option>
									</select>
									<select id="district" name="district" class="chosen-select" style="width:120px;" disabled="disabled">
                                		<option value="-1">-- 请选择区/县 --</option>
									</select>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="text-center">
									<button class="btn btn-primary" type="submit">提交</button>
									<button class="btn btn-white" type="reset">重置</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- 自定义js -->
	<script src="${ctxstatic}/js/content.js?v=1.0.0"></script>
	<!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
	<script type="text/javascript">
	var dpaid = ${vol.province};
	var dcaid = ${vol.city};
	var ddaid = ${vol.district};
		$(function(){
			$.ajax({
			    type : "post",
			    url : "${ctx}/area/province", 
			    async : false,
			    dataType:"json",
			    success : function(data) {
			    	for(var i=0;i<data.length;i++){
			    		if(data[i].id == dpaid) {
			    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}else {
			    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}
	                    $("#province").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
			    },
			});
			
			$.ajax({
	        	type : "post",
	            url:"${ctx}/area/city/" + dpaid,
	            async : false,
	            dataType:"json",
	            success:function(data){
	                for(var i=0;i<data.length;i++){
	                	if(data[i].id == dcaid) {
			    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}else {
			    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}
	                    $("#city").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
	            }
	        });
			
			$.ajax({
	        	type : "post",
	            url:"${ctx}/area/district/" + dcaid,
	            async : false,
	            dataType:"json",
	            success:function(data){
	                for(var i=0;i<data.length;i++){
	                	if(data[i].id == ddaid) {
			    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}else {
			    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
			    		}
	                    $("#district").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
	            }
	        });
		});
	</script>
</body>
</html>