<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-物资补仓</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="row">
		<div class="col-sm-6">
			<div class="ibox-content">
				<form class="form-horizontal m-t" onsubmit="return false" id="Form">
					<input type="hidden" value="${goods.goodsId}" name="goodsId">
					<div class="form-group">
						<label class="col-sm-2 control-label">数量：</label>
						<div class="col-sm-4 input-group">
							<input id="count" type="text" class="form-control" name="count"
								autocomplete="off"> <span class="input-group-btn">
								<button class="btn btn-primary" type="submit">提交</button>
								<button class="btn btn-white" type="reset">重置</button>
							</span>
						</div>
					</div>
				</form>
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
		// 表单提交
		$("#Form").validate({
			rules : {
				count : {
					required : true
				}
			},
			messages : {
				count : {
					required : icon + "请输入数量"
				}
			},
			submitHandler : function(form){
				$.ajax({
		            url: '${ctx}/dept/goods/more',
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