<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-领养文章-详细</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form" enctype="multipart/form-data">
							<input id="deptId" type="hidden" value="<shiro:principal property="deptId" />" name="deptId">
							<div class="form-group">
								<label class="col-sm-1 control-label">待领养宠物：</label>
								<div class="col-sm-5">
									<input id="title" name="title" type="text" class="form-control"
										value="${pet.petname}" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标题：</label>
								<div class="col-sm-5">
									<input id="title" name="title" type="text" class="form-control"
										value="${adopt.title}" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">介绍：</label>
								<div class="col-sm-5">
									<textarea class="form-control" name="introduction" readonly="readonly" id="introduction">${adopt.introduction}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标签：</label>
								<div class="col-sm-5">
									<input id="title" name="title" type="text" class="form-control"
										value="${adopt.tag}" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">内容：</label><br>
								<div class="col-sm-11">${adopt.content}</div>
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
</body>
</html>