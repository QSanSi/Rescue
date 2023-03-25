<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-宠物信息-详细信息</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-42">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<input type="hidden" value="${pet.petId}" name="petId">
							<div class="form-group">
								<label class="col-sm-4 control-label">类型：</label>
								<div class="col-sm-5">
									<select id="type" class="chosen-select" name="type" style="width:120px;" disabled="disabled">
										<option value="-1">请选择类型</option>
										<option value="0" <c:if test="${pet.type==0}">selected</c:if>>猫咪</option>
										<option value="1" <c:if test="${pet.type==1}">selected</c:if>>狗狗</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">品种：</label>
								<div class="col-sm-5">
									<input id="variety" name="variety" type="text" class="form-control"
										readonly="readonly" value="${pet.variety}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">救助站点：</label>
								<div class="col-sm-5">
									<select id="deptId" class="chosen-select" name="deptId" style="width:120px;" disabled="disabled">
										<option value="-1">请选择站点</option>
										<c:forEach items="${deptlist}" var="dept">
											<option value="${dept.deptId}" <c:if test="${pet.deptId==dept.deptId}">selected</c:if>>${dept.deptName}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">宠物名：</label>
								<div class="col-sm-5">
									<input id="petname" name="petname" type="text" class="form-control"
										readonly="readonly"  value="${pet.petname}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">性别：</label>
								<div class="col-sm-5">
									<select id="gendar" class="chosen-select" name="gendar" style="width:120px;" disabled="disabled">
										<option value="-1">请选择性别</option>
										<option value="0" <c:if test="${pet.gendar==0}">selected</c:if>>公</option>
										<option value="1" <c:if test="${pet.gendar==1}">selected</c:if>>母</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">年龄：</label>
								<div class="col-sm-5">
									<input id="age" type="text" class="form-control"
										name="age" readonly="readonly" value="${pet.age}">
								</div>
							</div>
							<div class="form-group" id="data_1">
								<label class="col-sm-4 control-label">生日：</label>
								<div class="input-group date" id="datepicker" style="padding-left: 15px;width: 160px;">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                	<input id="birthday" readonly="readonly" name="birthday" type="text" class="form-control" value="${pet.birthday}">
								</div>
							</div>
							<div class="form-group">
                                <label class="col-sm-4 control-label">照片：</label>
                                <div class="col-sm-5">
	                                <c:if test="${empty pet.photo}">
										<img src="http://fpoimg.com/500x500?text=No IMG Was Uploaded" class="img-responsive"/>
									</c:if>
									<c:if test="${not empty pet.photo}">
										<img src="${ctx}${pet.photo}" class="img-responsive">
									</c:if>
                                </div>
                            </div>
							<div class="form-group">
								<label class="col-sm-4 control-label">是否被领养：</label>
								<div class="col-sm-5">
									<select id="status" class="chosen-select" name="status" style="width:120px;" disabled="disabled">
										<option value="-1">请选择...</option>
										<option value="0" <c:if test="${pet.status==0}">selected</c:if>>否</option>
										<option value="1" <c:if test="${pet.status==1}">selected</c:if>>是</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">备注： </label>
								<div class="col-sm-5">
									<textarea id="remark" name="remark" readonly="readonly" class="form-control">${pet.remark}</textarea>
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
    <!-- Data picker -->
    <script src="${ctxstatic}/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <!-- Prettyfile -->
    <script src="${ctxstatic}/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
    <script type="text/javascript">
    $('#datepicker').datepicker({
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    </script>
</body>
</html>