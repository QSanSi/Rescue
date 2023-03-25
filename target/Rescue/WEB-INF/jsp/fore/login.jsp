<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu - 用户 - 登录</title>
<link href="${ctxstatic}/css/login.css" rel="stylesheet">
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="signin">
    <div class="signinpanel">
        <div class="row">
            <div class="col-sm-7">
                <div class="signin-info">
                    <div class="logopanel m-b">
                        <h1>HeMaozhu</h1>
                    </div>
                    <div class="m-b"></div>
                    <h4>欢迎来到 <strong>HeMaozhu平台</strong></h4>
                    <ul class="m-b">
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势一</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势二</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势三</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势四</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势五</li>
                    </ul>
                    <strong>还没有账号？ <a id="regist" href="javascript:void(0);">立即注册&raquo;</a></strong>
                </div>
            </div>
            <div class="col-sm-5">
                <form id="login" onsubmit="return false">
                    <h4 class="no-margins">登录：</h4>
                    <p class="m-t-md">登录到HeMaozhu</p>
                    <input id="username" name="username" type="text" class="form-control uname" placeholder="用户名" />
                    <input id="password" name="password" type="password" class="form-control pword m-b" placeholder="密码" />
                    <a href="javascript:void(0);">忘记密码了？</a>
                    <button class="btn btn-success btn-block" type="submit">登录</button>
                </form>
            </div>
        </div>
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2020 All Rights Reserved. HeMaozhu
            </div>
        </div>
    </div>
    <!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<!-- jQuery Validation plugin javascript-->
	<script src="${ctxstatic}/js/plugins/validate/jquery.validate.min.js"></script>
	<script src="${ctxstatic}/js/plugins/validate/messages_zh.min.js"></script>
	<script src="${ctxstatic}/js/demo/form-validate-demo.js"></script>
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 表单提交
		$("#login").validate({
			rules : {
				username : {
					required : true
				},
				password : {
					required : true
				}
			},
			messages : {
				username : {
					required : icon + "请输入用户名"
				},
				password : {
					required : icon + "请输入密码"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/fore/users/userlogin',
		            type: 'post',
		            data: $("#login").serialize(),
		            dataType: 'json',
		            success: function (response) {
		                if (response.code == 0) {
		                	layer.msg("<em style='color:green'>" + response.msg + "</em>", {icon: 1, time: 1000, offset: '0px'}, function(){
		                		window.location.href = '${ctx}/page/foreindex';
		                	});
		                } else {
		                    layer.alert("<em style='color:red'>" + response.msg + "</em>", {icon: 5, offset: '0px'});
		                }
		            }
		        })
			}
		});
	});
	
	// 新增
	$('#regist').click(function() {
		var title = "注册";
		var url = "${ctx}/fore/users/regist";
		layer.open({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [ '80%', '80%' ],
			fix : false,
			maxmin : true,
			content : url
		});
	});
	</script>
</body>

</html>
