<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-用户-编辑用户</title>
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
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<input type="hidden" value="${user.userId}" name="userId">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户名：</label>
								<div class="col-sm-5">
									<input id="username" name="username" type="text" class="form-control"
										 readonly="readonly" value="${user.username}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">密码：</label>
								<div class="col-sm-5">
									<input id="password" name="password" type="password" class="form-control"
										value="${user.password}" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">邮箱：</label>
								<div class="col-sm-5">
									<input id="email" type="email" class="form-control"
										name="email" value="${user.email}" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="tel" type="tel" class="form-control"
										name="tel" value="${user.tel}" autocomplete="off">
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
			// 增加手机号验证规则
			$.validator.addMethod("isMobile",function(value, element) {
				var length = value.length;
				var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
				return this.optional(element) || (length == 11 && mobile.test(value));
				}, icon + "请正确填写您的手机号码");
			
			// 验证手机号是否被使用
			$.validator.addMethod("mobileUsed",function(value, element) {
				var used = false;
				var id = ${user.userId};
				$.ajax({
	                dataType : "json",
	                type : "post",
	                async : false,
	                url : "${ctx}/fore/users/checktel",
	                data:{
	                    tel : value,
	                    userId : id
	                },
	                success:function(data){
	                	used = data;
	                }
	            });
				return used;
			}, icon + "手机号已被使用");
	     	
			// 验证手邮箱是否被使用
			$.validator.addMethod("emailUsed",function(value, element) {
				var used = false;
				var id = ${user.userId};
				$.ajax({
	                dataType : "json",
	                type : "post",
	                async : false,
	                url : "${ctx}/fore/users/checkemail",
	                data:{
	                    email : value,
	                    userId : id
	                },
	                success:function(data){
	                	used = data;
	                }
	            });
				return used;
			}, icon + "邮箱已被使用");
			
			// 表单提交
			$("#Form").validate({
				rules : {
					password : {
						required : true
					},
					email : {
						required : true,
						email : true,
						emailUsed : true
					},
					tel : {
						required : true,
						minlength : 11,
						isMobile : true,
						mobileUsed : true
					}
				},
				messages : {
					password : {
						required : icon + "请输入新密码"
					},
					email : {
						required : icon + "请输入邮箱",
					},
					tel : {
						required : icon + "请输入手机号",
						minlength : icon + "不能小于11个字符",
						isMobile : icon + "请正确填写手机号码"
					}
				},
				submitHandler : function(form){
					$.ajax({
			            url: '${ctx}/fore/users/update',
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