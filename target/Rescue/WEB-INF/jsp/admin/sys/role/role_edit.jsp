<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-编辑角色</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="editForm">
							<input type="hidden" value="${role.roleId}" name="roleId">
							<div class="form-group">
								<label class="col-sm-4 control-label">角色名称：</label>
								<div class="col-sm-5">
									<input id="name" name="name" type="text" class="form-control"
										autocomplete="off" value="${role.name}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">角色描述：</label>
								<div class="col-sm-5">
									<input id="remark" type="text" class="form-control"
										name="remark" value="${role.remark}" autocomplete="off">
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
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 验证角色名是否被使用
		$.validator.addMethod("nameUsed",function(value, element) {
			var used = false;
			var id = ${role.roleId};
			$.ajax({
                dataType : "json",
                type : "post",
                async : false,
                url : "${ctx}/sys/role/checkname",
                data:{
                    name : value,
                    roleId : id
                },
                success:function(data){
                	used = data;
                }
            });
			return used;
		}, icon + "角色名已被使用");
		
		// 表单提交
		$("#editForm").validate({
			rules : {
				name : {
					required : true,
					nameUsed : true
				},
				remark : {
					required : true,
					maxlength : 10,
				}
			},
			messages : {
				name : {
					required : icon + "请输入角色名称",
				},
				remark : {
					required : icon + "请输入角色描述",
					minlength : icon + "不能多于10个字符",
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/sys/role/edit',
		            type: 'post',
		            data: $("#editForm").serialize(),
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