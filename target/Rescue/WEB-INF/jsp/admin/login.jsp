<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>HeMaoZhu登录</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="gray-bg">

	<div class="middle-box text-center loginscreen  animated fadeInDown">
		<div>
			<div>

				<h1 class="logo-name">HM</h1>

			</div>
			<h3>管理员登录</h3>

			<form class="m-t" role="form" action="${ctx}/account/login" method="post">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="用户名" name="username"
						required autocomplete="off">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" placeholder="密码" name="password"
						required>
				</div>
				<c:if test="${not empty errorMsg}">
				<div class="form-group">
					<br>
					<div class="col-sm-10">
						<div class="alert alert-danger">${errorMsg}</div>
					</div>
				</div>
				</c:if>
				<button type="submit" class="btn btn-primary block full-width m-b">登
					录</button>


				<p class="text-muted text-center">
					<a href="login.html#"><small>忘记密码了？</small></a>
				</p>

			</form>
		</div>
	</div>

	<!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>		
	
</body>

</html>
