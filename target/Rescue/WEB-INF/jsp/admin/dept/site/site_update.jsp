<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-编辑站点</title>
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
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<input type="hidden" value="${dept.deptId}" name="deptId">
							<div class="form-group">
								<label class="col-sm-4 control-label">站点名称：</label>
								<div class="col-sm-5">
									<input id="deptName" name="deptName" type="text" class="form-control"
										autocomplete="off" value="${dept.deptName}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">站点负责人：</label>
								<div class="col-sm-5">
									<input id="deptManager" type="text" class="form-control"
										name="deptManager" value="${dept.deptManager}" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">负责人电话：</label>
								<div class="col-sm-5">
									<input id="managerTel" type="text" class="form-control"
										name="managerTel" value="${dept.managerTel}" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">站点类型：</label>
								<div class="col-sm-5">
									<select id="type" class="chosen-select" name="type" style="width:120px;">
										<option value="-1">请选择资源类型</option>
										<option value="1"
											<c:if test="${dept.type==1}">selected</c:if>>总部
										</option>
										<option value="2"
											<c:if test="${dept.type==2}">selected</c:if>>分站点
										</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">站点所在地：</label>
								<div class="col-sm-5">
                                	<select id="pareaId" name="pareaId" class="chosen-select" style="width:120px;" onchange="changeCity()">
                                		<option value="-1">-- 请选择省 --</option>
									</select>
									<select id="careaId" name="careaId" class="chosen-select" style="width:120px;" onchange="changeDistrict()">
                                		<option value="-1">-- 请选择市 --</option>
									</select>
									<select id="dareaId" name="dareaId" class="chosen-select" style="width:120px;">
                                		<option value="-1">-- 请选择区/县 --</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">详细地址： </label>
								<div class="col-sm-5">
                                	<textarea id="deptAdd" name="deptAdd" class="form-control">${dept.deptAdd}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">备注： </label>
								<div class="col-sm-5">
									<textarea id="remark" name="remark" class="form-control">${dept.remark}</textarea>
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
	<script type="text/javascript">
	var dpaid = ${dept.pareaId};
	var dcaid = ${dept.careaId};
	var ddaid = ${dept.dareaId};
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 增加手机号验证规则
		$.validator.addMethod("isMobile",function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
			}, icon + "请正确填写手机号码");
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				deptName : {
					required : true
				},
				deptManager : {
					required : true
				},
				managerTel : {
					required : true,
					isMobile : true
				},
				type : {
					min : 0
				},
				pareaId : {
					min : 0
				},
				careaId : {
					min : 0
				},
				dareaId : {
					min : 0
				},
				deptAdd : {
					required : true,
				}
			},
			messages : {
				deptName : {
					required : icon + "请输入站点名称"
				},
				deptManager : {
					required : icon + "请输入负责人"
				},
				managerTel : {
					required : icon + "请输入负责人电话"
				},
				type : {
					min : icon + "请选择站点类型"
				},
				pareaId : {
					min : icon + "请选择省"
				},
				careaId : {
					min : icon + "请选择市"
				},
				dareaId : {
					min : icon + "请选择区/县"
				},
				deptAdd : {
					required : icon + "请输入站点详细地址"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/dept/info/edit',
		            type: 'post',
		            data: $("#Form").serialize(),
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
		
		$.ajax({
		    type : "post",
		    url : "${ctx}/area/province", 
		    async : false,
		    dataType:"json",
		    success : function(data) {
		    	for(var i=0;i<data.length;i++){
		    		if(data[i].id == dpaid) {
		    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}else {
		    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}
                    $("#pareaId").append($option);
                    $('.chosen-select').trigger('chosen:updated');
                }
		    },
		});
		
		$.ajax({
        	type : "post",
            url:"${ctx}/area/city/" + dpaid,
            async : false,
            dataType:"json",
            success:function(data){
                for(var i=0;i<data.length;i++){
                	if(data[i].id == dcaid) {
		    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}else {
		    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}
                    $("#careaId").append($option);
                    $('.chosen-select').trigger('chosen:updated');
                }
            }
        });
		
		$.ajax({
        	type : "post",
            url:"${ctx}/area/district/" + dcaid,
            async : false,
            dataType:"json",
            success:function(data){
                for(var i=0;i<data.length;i++){
                	if(data[i].id == ddaid) {
		    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}else {
		    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
		    		}
                    $("#dareaId").append($option);
                    $('.chosen-select').trigger('chosen:updated');
                }
            }
        });
	});
	
	function changeCity(){
        var pid = $("#pareaId").val();
        $.ajax({
        	type : "post",
            url:"${ctx}/area/city/" + pid,
            async : false,
            dataType:"json",
            success:function(data){
                //清空城市下拉列表框的内容
                $("#careaId").html("<option value='-1'>-- 请选择市 --</option>");
                $("#dareaId").html("<option value='-1'>-- 请选择区/县 --</option>");
                //遍历json，json数组中每一个json，都对应一个省的信息，都应该在省的下拉列表框下面添加一个<option>
                for(var i=0;i<data.length;i++){
                	var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
                    $("#careaId").append($option);
                    $('.chosen-select').trigger('chosen:updated');
                }
            }
        });
    }
	
	function changeDistrict(){
        var cid = $("#careaId").val();
        $.ajax({
        	type : "post",
            url:"${ctx}/area/district/" + cid,
            async : false,
            dataType:"json",
            success:function(data){
                //清空城市下拉列表框的内容
                $("#dareaId").html("<option value='-1'>-- 请选择区/县 --</option>");
                //遍历json，json数组中每一个json，都对应一个省的信息，都应该在省的下拉列表框下面添加一个<option>
                for(var i=0;i<data.length;i++){
                	var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
                    $("#dareaId").append($option);
                    $('.chosen-select').trigger('chosen:updated');
                }
            }
        });
    }
	</script>
</body>
</html>