<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-分配角色</title>
<link rel="shortcut icon" href="favicon.ico">
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row x_title">
			<div class="col-md-6">
				<h3>选择角色</h3>
			</div>
		</div>
		<div class="ibox-content">
			<form id="data-form" class="form-horizontal" onsubmit="return false">
				<div class="form-group">
					<div class="col-sm-10">
						<input type="hidden" name="userId" value="${userId}">
						<c:forEach items="${userRoleList}" var="userRole">
							<div class="checkbox i-checks">
								<label> <input type="checkbox" name="roleId"
	                                   value="${userRole.roleId}" 
	                                   <c:if test="${not empty userRole.userId}">checked</c:if> > <i></i>
									${userRole.name}
								</label>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="hr-line-dashed"></div>
				<div class="text-center">
					<button class="btn btn-primary" type="submit">保存</button>
				</div>
			</form>
		</div>
	</div>
	<!-- 全局js -->
    <script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>

    <!-- 自定义js -->
    <script src="${ctxstatic}/js/content.js?v=1.0.0"></script>

    <!-- iCheck -->
    <script src="${ctxstatic}/js/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
            });
        });
        $('#data-form').submit(function(){
        	$.ajax({
                url: '${ctx}/sys/admin/assign/role',
                type: 'post',
                data: $("#data-form").serialize(),
                dataType: 'json',
                success: function (response) {
                    if (response.code == 0) {
                        window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'}, function(){
	                		window.parent.location.reload();
	                    	window.parent.layer.close(index);
	                	});
                    } else {
                        window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
                    }
                }
            })
        });
    </script>
</body>
</html>