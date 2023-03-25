<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-回访记录-新增</title>
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
						<form class="form-horizontal m-t" onsubmit="return false" id="Form" enctype="multipart/form-data">
							<input id="deptId" type="hidden" value="<shiro:principal property="deptId" />" name="deptId">
							<div class="form-group">
								<label class="col-sm-5 control-label">回访人：</label>
								<div class="col-sm-5">
									<select id="contractId" class="chosen-select" name="contractId" style="width:160px;">
										<option value="-1">请选择回访人</option>
										<c:forEach items="${conlist}" var="con">
											<option value="${con.contractId}">${con.master}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">信息是否更改：</label>
								<div class="col-sm-5">
									<select id="ischange" class="chosen-select" name="ischange" style="width:160px;">
										<option value="-1">请选择...</option>
										<option value="0">否</option>
										<option value="1">是</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">是否合格：</label>
								<div class="col-sm-5">
									<select id="pass" class="chosen-select" name="pass" style="width:160px;">
										<option value="-1">请选择...</option>
										<option value="0">否</option>
										<option value="1">是</option>
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
	<!-- jQuery Validation plugin javascript-->
	<script src="${ctxstatic}/js/plugins/validate/jquery.validate.min.js"></script>
	<script src="${ctxstatic}/js/plugins/validate/messages_zh.min.js"></script>
	<script src="${ctxstatic}/js/demo/form-validate-demo.js"></script>
	<!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				contractId : {
					min : 0
				},
				ischange : {
					min : 0
				},
				pass : {
					min : 0
				}
			},
			messages : {
				contractId : {
					min : icon + "请选择回访人"
				},
				ischange : {
					min : icon + "请选择是或否"
				},
				pass : {
					min : icon + "请选择是或否"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/fore/revisit/add',
		            type: 'post',
		            data: $("#Form").serialize(),
		            dataType: 'json',
		            success: function (response) {
		                if (response.code == 0) {
		                	var index = parent.layer.getFrameIndex(window.name);
		                	window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'}, function(){
		                		window.parent.location.reload();
		                    	window.parent.layer.close(index);
		                	});
		                } else {
		                    window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
		                }
		            }
		        })
			}
		});
	});
	</script>
</body>
</html>