<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-更新资源</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/fontawesome-iconpicker/fontawesome-iconpicker.min.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form id="editForm" class="form-horizontal" onsubmit="return false">
							<input type="hidden" name="parentId" value="${parent.resourceId}">
							<input type="hidden" name="resourceId" value="${resource.resourceId}">
							<div class="form-group">
								<label class="control-label col-sm-4">上级资源：</label>
								<div class="col-sm-5">
									<input type="text" value=" ${parent.name}" class="form-control"
										readonly>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">资源名称 <span class="required">*：</span></label>
								<div class="col-sm-5">
									<input type="text" name="name" value="${resource.name}" class="form-control" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">资源路径：</label>
								<div class="col-sm-5">
									<input type="text" name="url" value="${resource.url}" class="form-control" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">权限名称：</label>
								<div class="col-sm-5">
									<input type="text" name="permission" value="${resource.permission}" class="form-control" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">资源类型 <span class="required">*：</span></label>
								<div class="col-sm-5">
									<select class="chosen-select" style="width:120px;" tabindex="2" name="type">
										<option value="-1">请选择资源类型</option>
										<option value="0"
											<c:if test="${resource.type==0}">selected</c:if>>目录
										</option>
										<option value="1"
											<c:if test="${resource.type==1}">selected</c:if>>菜单
										</option>
										<option value="2"
											<c:if test="${resource.type==2}">selected</c:if>>按钮
										</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">选择图标：</label>
								<div class="col-sm-5">
									<input name="icon" class="form-control icp icp-auto" value="${resource.icon}"
										data-input-search="true" value="" type="text" autocomplete="off"/>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4">排序：</label>
								<div class="col-sm-5">
									<input type="text" name="orderNum" value="${resource.orderNum}" class="form-control" autocomplete="off">
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
	<!-- fontawesome-iconpicker -->
	<script src="${ctxstatic}/js/plugins/fontawesome-iconpicker/fontawesome-iconpicker.js"></script>
	<!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
	<script type="text/javascript">
	// fontawesome-iconpicker
	$(function() {
	    // 图标可以点击选中 icp-auto 操作图标元素
	    $('.icp-auto').iconpicker({
	        title: '请选择一个图标',
	        //  指定图标
	        //icons:['fa-github', 'fa-heart', 'fa-html5', 'fa-css3'],
	        // 添加其他图标 加入 bootstrap  glyphicon 字体图标
	        icons: $.merge(['glyphicon-home', 'glyphicon-repeat', 'glyphicon-search',
	            'glyphicon-arrow-left', 'glyphicon-arrow-right', 'glyphicon-star'], $.iconpicker.defaultOptions.icons),
	        fullClassFormatter: function(val){
	            if(val.match(/^fa-/)){
	                return 'fa '+ val;
	            }else{
	                return 'glyphicon ' + val;
	            }
	        },
	        component: '.input-group-addon', // 图标存放容器
	       /* Placements: inline topLeftCorner topLeft top topRight topRightCorner rightTop right rightBottom bottomRightCorner bottomRight bottom bottomLeft bottomLeftCorner leftBottom left leftTop*/
	        placement:'right',  // 图标容器位置
	    });

	    // 图标不可以点击, 绑定 .icp 元素
	    // $.iconpicker.batch('.icp', 'destroy');

	    // 点击下拉按钮显示图标
	    $('.btn-group>button').one("click",function(){
	        console.log(1);
	        $('.icp-dd').iconpicker({
	            //title: 'Dropdown with picker',
	            //component:'.btn > i'
	        });
	    }) ;
	});
	
	$(function() {
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#editForm").validate(
				{
					rules : {
						name : {
							required : true,
						},
						type : {
							min : 0,
						},
					},
					messages : {
						name : {
							required : icon + "请输入资源名称",
						},
						type : {
							min : icon + "请选择资源类型",
						},
					},
					submitHandler : function(form) {
						$.ajax({
							url : '${ctx}/sys/resource/update',
							type : 'post',
							data : $("#editForm").serialize(),
							dataType : 'json',
							success : function(response) {
								if (response.code == 0) {
									var index = parent.layer.getFrameIndex(window.name);
										window.parent.layer.msg(response.msg, {icon : 1, time : 1000, offset : '0px'}, function() {
											window.parent.location.reload();
											window.parent.layer.close(index);
										});
								} else {
									window.parent.layer.alert(response.msg, {icon : 5, offset : '0px'});
								}
							}
						})
					}
				});
	});
	</script>
</body>
</html>