<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-资源管理</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link
	href="${ctxstatic}/css/plugins/bootstrap-table/bootstrap-table.min.css"
	rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-title">
				<h4>${parent.name}</h4>
			</div>
			<div class="ibox-content">
				<div class="fixed-table-toolbar">
					<div class="bars pull-left">
						<div id="left-toolbar" role="group">
							<button type='button' class='btn btn-primary' id='btn-add'>
								<i class='fa fa-plus'></i> 添加菜单
							</button>
							<button type='button' class='btn btn-danger' id='btn-delete'>
								<i class='fa fa-trash'></i> 批量删除
							</button>
						</div>
					</div>
				</div>
				<table id="data-table" data-mobile-responsive="true"
					style="table-layout: fixed;"></table>
			</div>
		</div>
	</div>
	<!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
	<!-- 自定义js -->
	<script src="${ctxstatic}/js/content.js?v=1.0.0"></script>
	<!-- Bootstrap table -->
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	<!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<script>
		var list_url = '${ctx}/sys/resource/data';
		var presourceid = ${parent.resourceId};
		// 初始化表格数据
		var dataTable = $('#data-table').bootstrapTable({
			url : list_url, //  请求后台的URL
			method : "get", //  请求方式
			uniqueId : "resourceId", //  每一行的唯一标识，一般为主键列
			cache : false, //  设置为 false 禁用 AJAX 数据缓存， 默认为true
			pagination : true, //  是否显示分页
			sidePagination : "server", //  分页方式：client客户端分页，server服务端分页
			pageSize : 10, //  每页的记录行数
			clickToSelect: true, 
			iconSize: 'outline',
			queryParamsType : '',
			queryParams : function(param) {
				return {
					current: param.pageNumber, // 当前页 1
	                size: param.pageSize,      // 一页显示多少 10
					parentId : presourceid
				}
			},
			columns : [ {
				checkbox : true
			}, {
				field : 'icon',
				title : '图标',
				align : 'center',
				width : '50',
				formatter : function(value, row, index) {
					var icon = '<i class="' + row.icon + '"></i> '
					return icon;
				}
			}, {
				field : 'orderNum',
				title : '排序'
			}, {
				field : 'name',
				title : '资源名称'
			}, {
				field : 'type',
				title : '资源类型',
				formatter : function(value, row, index) {
					if (row.type == 0) {
						return '目录';
					}
					if (row.type == 1) {
						return '菜单';
					}
					if (row.type == 2) {
						return '按钮';
					}
				}
			}, {
				field : 'url',
				title : '资源路径'
			}, {
				field : 'permission',
				title : '权限'
			}, {
				field : 'operate',
				title : '操作',
				align : 'center',
				clickToSelect : false,
				formatter : addFunctionAlty,//表格中增加按钮
				width : 200
			}]
		});
		
		function addFunctionAlty(value, data, index) {
			var id = data.resourceId;
			var result = "";
			result += "<button id='update' class='btn btn-info' onclick=\"edit('"
					+ id
					+ "')\"><i class='fa fa-paste'></i> 修改</button>&nbsp;&nbsp;";
			result += "<button id='delete' class='btn btn-danger' onclick=\"del('"
					+ id
					+ "')\"><i class='fa fa-remove'></i> 删除</button>&nbsp;&nbsp;";
			return result;
		}
		// 新增
		$('#btn-add').click(function() {
			var title = "添加菜单";
			var url = "${ctx}/sys/resource/add/" + presourceid;
			window.parent.layer.open({
				type : 2,
				title : title,
				shadeClose : true,
				shade : 0.8,
				area : [ '80%', '80%' ],
				fix : false,
				maxmin : true,
				content : url
			});
		});
		// 修改
		function edit(id) {
			var title = "修改信息";
			var url = "${ctx}/sys/resource/update/" + id;
			window.parent.layer.open({
				type : 2,
				title : title,
				shadeClose : true,
				shade : 0.8,
				area : [ '80%', '80%' ],
				fix : false,
				maxmin : true,
				content : url
			});
		}
		// 删除
		function del(id) {
			window.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
				$.ajax({
	                url: '${ctx}/sys/resource/delete/' + id,
	                type: 'get',
	                success: function (response) {
	                    if (response.code == 0) {
	                        window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'}, function(){
	                        	window.location.reload();
	                        });
	                    } else {
	                        window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
	                    }
	                }
	            });
	        })
		}
		// 批量删除
		$('#btn-delete').click(function() {
			var rows = $('#data-table').bootstrapTable('getSelections');
			if (rows.length == 0) {
				window.parent.parent.layer.msg("请选择数据行!", {icon : 2, time : 1000, offset : 't'})
			} else if (rows.length == 1) {
				window.parent.parent.layer.confirm("确认删除?", { icon : 3, offset : 't'},function() {
					$.ajax({
						url : '${ctx}/sys/resource/delete/' + rows[0].resourceId,
						type : 'get',
						success : function(response) {
							if (response.code == 0) {
								window.parent.parent.layer.msg(response.msg, {icon : 1, time : 1000, offset : 't'}, function(){
	                            	window.location.reload();
	                            });
							} else {
								window.parent.parent.layer.alert(response.msg, {icon : 5, offset : 't'});
							}
						}
					});
				})
			} else {
				window.parent.parent.layer.confirm("确认批量删除?", {icon : 3, offset : 't'},function() {
					var ids = new Array();
					for (var i = 0; i < rows.length; i++) {
						ids.push(rows[i].resourceId);
					}
					$.ajax({
						url : '${ctx}/sys/resource/deletebatch',
						contentType : "application/json; charset=UTF-8",//发送给服务器的是json数据
						type : 'post',
						dateType : 'json',
						data : JSON.stringify(ids),
						success : function(response) {
							if (response.code == 0) {
								window.parent.parent.layer.msg(response.msg, {icon : 1, time : 1000, offset : 't'}, function(){
	                            	window.location.reload();
	                            });
							} else {
								window.parent.parent.layer.alert(response.msg, {icon : 5, offset : 't'});
							}
						}
					});
				});
			}
		});
	</script>
</body>
</html>