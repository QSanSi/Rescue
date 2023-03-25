<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-用户-用户注册</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <h1 class="logo-name">HM</h1>
        </div>
        <h3>欢迎注册 HeMaozhu</h3>
        <p>创建一个HeMaozhu新账户</p>
        <form class="form-horizontal m-t" id="Form" onsubmit="return false">
            <div class="form-group">
            	<div class="col-sm-12">
                	<input id="username" name="username" class="form-control" type="text" placeholder="请输入用户名">
                </div>
            </div>
            <div class="form-group">
            	<div class="col-sm-12">
                	<input id="password" name="password" type="password" class="form-control" placeholder="请输入密码">
                </div>
            </div>
            <div class="form-group">
            	<div class="col-sm-12">
                	<input id="confirm_password" name="confirm_password" type="password" class="form-control" placeholder="请再次输入密码">
               	</div>
            </div>
            <div class="form-group">
            	<div class="col-sm-12">
                	<input id="email" name="email" class="form-control" type="email" placeholder="请输入电子邮箱地址">
                </div>
            </div>
            <div class="form-group">
            	<div class="col-sm-12">
                	<input id="tel" name="tel" class="form-control" type="tel" placeholder="请输入手机号码">
                </div>
            </div>
            <div class="form-group text-left">
	            <div class="col-sm-12">
	            	<div class="checkbox i-checks">
						<label> <input type="checkbox" class="checkbox" id="agree" name="agree"> 我同意注册协议
						</label>
					</div>
				</div>
            </div>
            <button type="submit" class="btn btn-primary block full-width m-b">注 册</button>
        </form>
    </div>
    <!-- 全局js -->
    <script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
    <!-- 自定义js -->
    <script src="${ctxstatic}/js/content.js?v=1.0.0"></script>
    <!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
    <!-- jQuery Validation plugin javascript-->
    <script src="${ctxstatic}/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctxstatic}/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctxstatic}/js/demo/form-validate-demo.js"></script>
    <script type="text/javascript">
    $(function() {
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 增加手机号验证规则
		$.validator.addMethod("isMobile",function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
		}, icon + "请正确填写您的手机号码");
		
		// 验证用户名是否被使用
		$.validator.addMethod("nameUsed",function(value, element) {
			var used = false;
			$.ajax({
                dataType : "json",
                type : "post",
                async:false,
                url : "${ctx}/fore/users/check",
                data:{
                	username : value,
                },
                success:function(data){
                	used = data;
                }
            });
			return used;
		}, icon + "用户名已存在");
		
		// 验证手机号是否被使用
		$.validator.addMethod("mobileUsed",function(value, element) {
			var used = false;
			$.ajax({
                dataType : "json",
                type : "post",
                async:false,
                url : "${ctx}/fore/users/checktel",
                data:{
                    tel : value,
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
			$.ajax({
                dataType : "json",
                type : "post",
                async:false,
                url : "${ctx}/fore/users/checkemail",
                data:{
                    email : value,
                },
                success:function(data){
                	used = data;
                }
            });
			return used;
		}, icon + "邮箱已被使用");
		
		$("#Form").validate({
			rules : {
				username : {
					required : true,
					minlength : 4,
					nameUsed : true
				},
				password : {
					required : true,
					minlength : 5
				},
				confirm_password : {
					required : true,
					minlength : 5,
					equalTo : "#password"
				},
				email : {
					required : true,
					email : true,
					emailUsed : true
				},
				topic : {
					required : "#newsletter:checked",
					minlength : 2
				},
				agree : "required",
				tel : {
					required : true,
					minlength : 11,
					isMobile : true,
					mobileUsed : true
				}
			},
			messages : {
				username : {
					required : icon + "请输入您的用户名",
					minlength : icon + "用户名必须三个字符以上"
				},
				password : {
					required : icon + "请输入您的密码",
					minlength : icon + "密码必须5个字符以上"
				},
				confirm_password : {
					required : icon + "请再次输入密码",
					minlength : icon + "密码必须5个字符以上",
					equalTo : icon + "两次输入的密码不一致"
				},
				email : {
					required : icon + "请输入您的电子邮箱",
				},
				agree : {
					required : icon + "必须同意协议后才能注册",
					element : '#agree-error'
				},
				tel : {
					required : icon + "请输入手机号",
					minlength : icon + "不能小于11个字符",
					isMobile : icon + "请正确填写手机号码"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/fore/users/regist',
		            type: 'post',
		            data: $("#Form").serialize(),
		            dataType: 'json',
		            success: function (response) {
		                if (response.code == 0) {
		                	var index = parent.layer.getFrameIndex(window.name);
		                	window.parent.layer.msg("<em style='color:green'>" + response.msg + "</em>", {icon: 1, time: 1000, offset: '0px'}, function(){
		                		window.parent.location.reload();
		                    	window.parent.layer.close(index);
		                	});
		                } else {
		                    window.parent.layer.alert("<em style='color:red'>" + response.msg + "</em>", {icon: 5, offset: '0px'});
		                }
		            }
		        })
			}
		});
    });
    </script>
</body>
</html>
