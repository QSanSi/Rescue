<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-同城领养-文章页面</title>
<link rel="shortcut icon" href="favicon.ico"> 
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content  animated fadeInRight article">
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1">
				<div class="ibox">
					<div class="ibox-content">
						<div class="pull-right">
							<strong>${user.username}</strong>
							<span class='text-muted'> <i class='fa fa-clock-o'></i> ${createTime}</span>
						</div>
						<div class="text-center article-title"><h1>${cd.title}</h1></div>
						<div class="hr-line-dashed"></div>
						<div class="row">
							<div class="col-sm-7">
								<c:if test="${empty cd.photo}">
									<img src="http://fpoimg.com/500x500?text=No IMG Was Uploaded" class="img-responsive" style="float: right;"/>
								</c:if>
								<c:if test="${not empty cd.photo}">
									<img src="${ctx}${cd.photo}" class="img-responsive" style="float: right;">
								</c:if>
                            </div>
							<div class="col-sm-5">
                            	<h2><strong>名字：</strong> ${cd.petname}</h2>
                            	<h2><strong>品种：</strong> ${cd.variety}</h2>
                            	<h2><strong>性别：</strong> 
                            		<c:if test="${cd.gendar==0}">公</c:if>
                                    <c:if test="${cd.gendar==1}">母</c:if>
                                </h2>
                            	<h2><strong>年龄：</strong> ${cd.age}</h2>
                            	<h2><strong>生日：</strong> ${cd.birthday}</h2>
                            </div>
						</div>
						<div class="hr-line-dashed"></div>
						${cd.content}
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
</body>
</html>