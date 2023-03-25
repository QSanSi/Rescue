<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-分配资源</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link
	href="${ctxstatic}/css/plugins/bootstrap-table/bootstrap-table.min.css"
	rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/bootstrap-treeview/bootstrap-treeview.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row x_title">
			<div class="col-md-6">
				<h3>选择资源</h3>
			</div>
		</div>
		<div class="ibox-content">
			<div class="form-group">
				<input type="hidden" value="${roleId}" id="roleId">
			</div>
			<div id="data-tree"></div>
			<div class="hr-line-dashed"></div>
			<div class="text-center">
				<button class="btn btn-primary" type="submit" id="btn-save">保存</button>
				<!-- <button class="btn btn-info" type="button" id="expandAll">全部展开</button>
				<button class="btn btn-info" type="button" id="collapseAll">全部收起</button> -->
			</div>
		</div>
	</div>
	<!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- 自定义js -->
	<script src="${ctxstatic}/js/content.js?v=1.0.0"></script>
	<!-- bootstrap-treeview -->
	<script src="${ctxstatic}/js/plugins/bootstrap-treeview/bootstrap-treeview.js"></script>
	<script>
		// 获取树菜单的数据
		$.ajax({
			url : '${ctx}/sys/role/assign/resourceTree/${roleId}',
			type : 'get',
			dataType : 'json',
			success : function(response) {
				$('#data-tree').treeview({
					//data: new Array(response.data),
					data : response.data.nodes,
					levels : 2,
					showCheckbox : true, //启用复选按钮
					hierarchicalCheck : true,  //级联勾选
				});
			}
		});

		$('#btn-save').bind('click', function() {
			// 角色id
			var roleId = $('#roleId').val();
			//node-checked
			//node-checked-partial
			var roleResourceList = [];
			$('.node-checked,.node-checked-partial').each(function() {
				var roleResource = {
					roleId : roleId,
					resourceId : $(this).attr('id')
				};
				//将对象放入到数组中
				roleResourceList.push(roleResource);
			});
			console.log(roleResourceList);

			$.ajax({
				url : '${ctx}/sys/role/assign/resource/' + roleId,
				contentType : "application/json; charset=UTF-8",//发送给服务器的是json数据
				type : 'post',
				data : JSON.stringify(roleResourceList),
				dataType : 'json',
				success : function(response) {
					if (response.code == 0) {
						window.parent.layer.msg(response.msg, {
							icon : 1,
							time : 1000,
							offset : '0px'
						}, function() {
							window.parent.location.reload();
							window.parent.layer.close(index);
						});
					} else {
						window.parent.parent.layer.alert(response.msg, {
							icon : 5,
							offset : 't'
						});
					}
				}
			});
		});
	</script>
</body>
</html>