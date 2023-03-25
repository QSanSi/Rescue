<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-契约协议-修改</title>
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
							<input type="hidden" value="${con.contractId}" name="contractId">
							<div class="form-group">
								<label class="col-sm-4 control-label">领养人：</label>
								<div class="col-sm-5">
									<input id="master" name="master" type="text" class="form-control"
										readonly="readonly" value="${con.master}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">年龄：</label>
								<div class="col-sm-5">
									<input id="age" type="text" class="form-control"
										name="age" readonly="readonly" value="${con.age}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">职业：</label>
								<div class="col-sm-5">
									<input id="career" name="career" type="text" class="form-control"
										readonly="readonly" value="${con.career}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="tel" name="tel" type="tel" class="form-control"
										readonly="readonly" value="${con.tel}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">居住地址： </label>
								<div class="col-sm-5">
									<textarea id="addr" name="addr" readonly="readonly" class="form-control">${con.addr}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">身份证信息：</label>
								<div class="col-sm-5">
									<input id="idcard" type="text" class="form-control"
										name="idcard" readonly="readonly" value="${con.idcard}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">领养站点：</label>
								<div class="col-sm-5">
									<input id="deptId" type="text" class="form-control"
										name="deptId" readonly="readonly" value="${dept.deptName}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">领养宠物：</label>
								<div class="col-sm-5">
									<select id="petId" class="chosen-select" name="petId" style="width:200px;" disabled="disabled">
										<option value="-1">请选择宠物</option>
										<c:forEach items="${petlist}" var="pet">
											<option value="${pet.petId}" <c:if test="${con.petId==pet.petId}">selected</c:if>>${pet.petname}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
                                <label class="col-sm-4 control-label">契约照片：</label>
                                <div class="col-sm-5">
	                                <c:if test="${empty con.contract}">
										<img src="http://fpoimg.com/500x500?text=No IMG Was Uploaded" class="img-responsive"/>
									</c:if>
									<c:if test="${not empty con.contract}">
										<img src="${ctx}${con.contract}" class="img-responsive">
									</c:if>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">协议照片：</label>
                                <div class="col-sm-5">
                                	<c:if test="${empty con.agreement}">
										<img src="http://fpoimg.com/500x500?text=No IMG Was Uploaded" class="img-responsive"/>
									</c:if>
									<c:if test="${not empty con.agreement}">
										<img src="${ctx}${con.agreement}" class="img-responsive">
									</c:if>
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
    <!-- Prettyfile -->
    <script src="${ctxstatic}/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
</body>
</html>