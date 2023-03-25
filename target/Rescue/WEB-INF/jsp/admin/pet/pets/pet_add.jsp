<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-宠物信息-新增</title>
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
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form" enctype="multipart/form-data">
							<div class="form-group">
								<label class="col-sm-4 control-label">类型：</label>
								<div class="col-sm-5">
									<select id="type" class="chosen-select" name="type" style="width:120px;">
										<option value="-1">请选择类型</option>
										<option value="0">猫咪</option>
										<option value="1">狗狗</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">品种：</label>
								<div class="col-sm-5">
									<input id="variety" name="variety" type="text" class="form-control"
										autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">救助站点：</label>
								<div class="col-sm-5">
									<select id="deptId" class="chosen-select" name="deptId" style="width:120px;">
										<option value="-1">请选择站点</option>
										<c:forEach items="${deptlist}" var="dept">
											<option value="${dept.deptId}">${dept.deptName}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">宠物名：</label>
								<div class="col-sm-5">
									<input id="petname" name="petname" type="text" class="form-control"
										autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">性别：</label>
								<div class="col-sm-5">
									<select id="gendar" class="chosen-select" name="gendar" style="width:120px;">
										<option value="-1">请选择性别</option>
										<option value="0">公</option>
										<option value="1">母</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">年龄：</label>
								<div class="col-sm-5">
									<input id="age" type="text" class="form-control"
										name="age" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">生日：</label>
								<div class="input-group date" id="datepicker" style="padding-left: 15px;width: 160px;">
									<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                	<input id="birthday" name="birthday" type="text" class="form-control"  autocomplete="off">
								</div>
							</div>
							<div class="form-group">
                                <label class="col-sm-4 control-label">照片：</label>
                                <div class="col-sm-5">
                                	<input type="file" accept="image/*" class="form-control" id="file" name="file">
                                </div>
                            </div>
							<div class="form-group">
								<label class="col-sm-4 control-label">是否被领养：</label>
								<div class="col-sm-5">
									<select id="status" class="chosen-select" name="status" style="width:120px;">
										<option value="-1">请选择</option>
										<option value="0">否</option>
										<option value="1">是</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">备注： </label>
								<div class="col-sm-5">
									<textarea id="remark" name="remark" class="form-control"></textarea>
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
	<!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
    <!-- Data picker -->
    <script src="${ctxstatic}/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <!-- Prettyfile -->
    <script src="${ctxstatic}/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				type : {
					min : 0
				},
				variety : {
					required : true
				},
				deptId : {
					min : 0
				},
				petname : {
					required : true
				},
				gendar : {
					min : 0
				},
				status : {
					min : 0
				}
			},
			messages : {
				type : {
					min : icon + "请选择类型"
				},
				variety : {
					required : icon + "请输入品种"
				},
				deptId : {
					min : icon + "请选择站点"
				},
				petname : {
					required : icon + "请输入宠物名"
				},
				gendar : {
					min : icon + "请选择性别"
				},
				status : {
					min : icon + "请选择是或否"
				}
			},
			submitHandler : function(form){
				var form = new FormData(document.getElementById("Form"));
				$.ajax({
		            url: '${ctx}/fore/pet/add',
		            type: 'post',
		            data: form,
		            processData: false,
		            contentType: false,
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
		
		$('#datepicker').datepicker({
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: true,
            autoclose: true
        });
		
		$('#file').prettyFile();
	});
	</script>
</body>
</html>