<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-物资修改</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<input id="deptId" type="hidden" value="<shiro:principal property="deptId" />" name="deptId">
							<input type="hidden" value="${goods.goodsId}" name="goodsId">
							<div class="form-group">
								<label class="col-sm-4 control-label">物资名称：</label>
								<div class="col-sm-5">
									<input id="name" name="name" type="text" class="form-control"
										autocomplete="off" value="${goods.name}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">数量：</label>
								<div class="col-sm-5">
									<input id="count" type="text" class="form-control"
										name="count" autocomplete="off" value="${goods.count}">
								</div>
							</div>
							<shiro:hasAnyRoles name="超级管理员,管理员">
								<div class="form-group">
									<label class="col-sm-4 control-label">单价：</label>
									<div class="col-sm-5">
										<input id="price" type="text" class="form-control"
											name="price" autocomplete="off" value="${goods.price}">
									</div>
								</div>
							</shiro:hasAnyRoles>
							<div class="form-group">
								<label class="col-sm-4 control-label">备注： </label>
								<div class="col-sm-5">
									<textarea id="remark" name="remark" class="form-control">${goods.remark}</textarea>
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
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 检查物资名是否已经存在
        $.validator.addMethod("checkname", function(value, element) {
            var ret = false;
            var deptid = $('#deptId').val();
            var name = $('#parentId option:selected').text();
            var goodsid = ${goods.goodsId};
            if(!name){
            	name = value;
            }
            $.ajax({
                dataType:"json",
                type:"post",
                async:false,
                url:"${ctx}/dept/goods/checkname",
                data:{
                    name : name,
                    deptId : deptid,
                    goodsId : goodsid
                },
                success:function(data){
                    ret = data;
                }
            });
            return ret;
        }, icon + "物资名重复");
		
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				name : {
					required : true,
					checkname : true
				},
				count : {
					required : true
				},
				parentId : {
					min : 0,
					checkname : true
				},
				price : {
					required : true
				}
			},
			messages : {
				name : {
					required : icon + "请输入物资名称"
				},
				count : {
					required : icon + "请输入数量"
				},
				parentId : {
					min : icon + "请选择总部仓库对应物资名"
				},
				price : {
					required : icon + "请输入单价"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/dept/goods/edit',
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
	});
	</script>
</body>
</html>