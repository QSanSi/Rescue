<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-新增用户</title>
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
						<form class="form-horizontal m-t" onsubmit="return false" id="addForm">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户名：</label>
								<div class="col-sm-5">
									<input id="username" name="username" class="form-control"
										type="text" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">密码：</label>
								<div class="col-sm-5">
									<input id="password" name="password" class="form-control"
										type="password" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">确认密码：</label>
								<div class="col-sm-5">
									<input id="confirm_password" name="confirm_password"
										class="form-control" type="password" autocomplete="off"> <span
										class="help-block m-b-none"><i
										class="fa fa-info-circle"></i> 请再次输入您的密码</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">邮箱：</label>
								<div class="col-sm-5">
										<input id="email" type="email" class="form-control"
										name="email" required aria-required="true" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="mobile" type="tel" class="form-control"
										name="mobile" required data-rule-isMobile="true" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">所属部门：</label>
								<div class="col-sm-5">
									<select class="chosen-select" name="deptId" style="width:120px;">
										<option value="-1">请选择部门</option>
										<c:forEach items="${deptlist}" var="dept">
											<option value="${dept.deptId}">${dept.deptName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="text-center">
									<button class="btn btn-primary" type="submit">提交</button>
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
        $.validator.addMethod("checkUsername", function(value, element) {
            var ret = false;
            $.ajax({
                dataType:"json",
                type:"post",
                async:false,
                url:"${ctx}/sys/admin/check",
                data:{
                    username : value
                },
                success:function(data){
                    ret = data;
                }
            });
            return ret;
        }, icon + "用户名已存在");
        
     	// 增加手机号验证规则
		$.validator.addMethod("isMobile",function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
			}, icon + "请正确填写您的手机号码");
     	
     	// 验证手机号是否被使用
		$.validator.addMethod("mobileUsed",function(value, element) {
			var used = false;
			$.ajax({
                dataType : "json",
                type : "post",
                async : false,
                url : "${ctx}/sys/admin/checkmobile",
                data:{
                    mobile : value
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
                async : false,
                url : "${ctx}/sys/admin/checkemail",
                data:{
                    email : value
                },
                success:function(data){
                	used = data;
                }
            });
			return used;
		}, icon + "邮箱已被使用");
     	
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
        $("#addForm").validate({
            rules : {
				username : {
					required : true,
					rangelength : [ 3, 16 ],
					checkUsername : true
				},
				password : {
					required : true,
					rangelength : [ 4, 16 ]
				},
				confirm_password : {
					required : true,
					rangelength : [ 4, 16 ],
					equalTo : "#password"
				},
				email : {
					required : true,
					email : true,
					emailUsed : true
				},
				mobile : {
					required : true,
					minlength : 11,
					isMobile : true,
					mobileUsed : true
				},
			},
			messages : {
				username : {
					required : icon + "请输入您的用户名",
					rangelength : icon + "用户名长度必须为{0}到{1}",
				},
				password : {
					required : icon + "请输入您的密码",
					rangelength : icon + "密码长度必须为{0}到{1}"
				},
				confirm_password : {
					required : icon + "请再次输入密码",
					rangelength : icon + "密码长度必须为{0}到{1}",
					equalTo : icon + "两次输入密码不一致"
				},
				email : {
					required : icon + "请输入您的邮箱",
				},
				mobile : {
					required : icon + "请输入您的手机号",
					minlength : icon + "不能小于11个字符",
					isMobile : icon + "请正确填写手机号码"
				}
			},
			submitHandler : function(form){
                $.ajax({
                    url: '${ctx}/sys/admin/add',
                    type: 'post',
                    data: $("#addForm").serialize(),
                    dataType: 'json',
                    success: function (response) {
                        if (response.code == 0) {
                        	var index = parent.layer.getFrameIndex(window.name);
                            window.parent.layer.msg(response.msg, {icon: 1, time: 500, offset: '0px'}, function(){
                            	window.parent.location.reload();
                            	window.parent.layer.close(index);
                            });
                        } else {
                            window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
                        }
                    }
                });
          	}
		});
	});
	</script>
</body>
</html>