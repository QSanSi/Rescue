<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-物资管理</title>
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
			<div class="ibox-content">
				<div class="row row-lg">
					<div class="col-sm-12">
						<div class="fixed-table-toolbar">
							<input id="deptId" type="hidden" value="<shiro:principal property="deptId" />" name="deptId">
							<div class="bars pull-left btn-group">
								<div id="left-toolbar" role="group">
									<button type='button' class='btn btn-primary' id='btn-add'>
										<i class='fa fa-plus'></i> 入库
									</button>
									<shiro:hasAnyRoles name="超级管理员,管理员">
										<button type='button' class='btn btn-info' id='btn-more'>
											<i class='fa fa-plus'></i> 补仓
										</button>
									</shiro:hasAnyRoles>
									<shiro:hasRole name="站点管理员">
										<button type='button' class='btn btn-warning' id='request'>
											<i class='fa fa-bell'></i> 申请
										</button>
									</shiro:hasRole>
								</div>
							</div>
							<shiro:hasRole name="站点管理员">
								<div class="bars pull-left col-sm-1 input-group">
									<input id="count" class="form-control" type="text" style="width:120px;"
											placeholder="输入数量" autocomplete="off"><span
									class="input-group-btn">
									<button type='button' class='btn btn-danger' id='btn-delete'>
										<i class='fa fa-minus-square-o'></i> 出库
										</button></span>
								</div>
							</shiro:hasRole>
							<div class="columns columns-right btn-group pull-right">
								<button class="btn btn-primary" type="button" name="refresh"
									title="刷新" onclick="refreshTable()">
									<i class="glyphicon glyphicon-repeat"></i>
								</button>
							</div>
							<div class="pull-right search col-sm-2 input-group">
								<input id="Name" class="form-control" type="text"
									placeholder="搜索" autocomplete="off"> <span
									class="input-group-btn">
									<button id="btn-search" type="button" class="btn btn-primary">
										搜索</button>
								</span>
							</div>
						</div>
						<table id="data-table" data-mobile-responsive="true"
							style="table-layout: fixed;"></table>
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
	<!-- Bootstrap table -->
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
	<script
		src="${ctxstatic}/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	<!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<script type="text/javascript">
	var list_url = '${ctx}/dept/goods/data';
	// 初始化表格数据
	var dataTable = $('#data-table').bootstrapTable({
		url : list_url, //  请求后台的URL
		method : "get", //  请求方式
		uniqueId : "goodsId", //  每一行的唯一标识，一般为主键列
		cache : false, //  设置为 false 禁用 AJAX 数据缓存， 默认为true
		pagination : true, //  是否显示分页
		sortable : true, 					//是否启用排序
		sidePagination : "server", //  分页方式：client客户端分页，server服务端分页
		pageSize : 10, //  每页的记录行数
		clickToSelect: true, 
		iconSize: 'outline',
		queryParamsType : '',
		queryParams : function(param) {
			return {
				current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少 10
                deptId : $('#deptId').val(),
				name: $("#Name").val(),
				column: this.sortName,
                asc: 'asc' == this.sortOrder
			}
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'name',
			title : '物资名称'
		}, {
			field : 'count',
			title : '剩余数量',
			sortable : true
		}, {
			field : 'dept.deptName',
			title : '物资所属站点'
		}, {
			field : 'price',
			title : '单价',
			sortable : true
		}, {
			field : 'createTime',
			title : '入库时间',
			sortable : true
		}, {
			field : 'updateTime',
			title : '最近补仓时间',
			sortable : true
		}, {
			field : 'status',
			title : '状态',
			align : 'center',
			sortable : true,
			formatter : statusLabel,//表格中增加状态Label
			width : 100
		}, {
			field : 'remark',
			title : '备注'
		}, {
			field : 'operate',
			title : '操作',
			align : 'center',
			clickToSelect : false,
			formatter : addFunctionAlty,//表格中增加按钮
			width : 200
		}]
	});
	
	function statusLabel(value, data, index) {
		var status = value;
		var result = "";
		if (status == 1) {
			color = 'label-primary';
			icon = 'fa fa-battery-4';
		} else if (status == 2) {
			color = 'label-primary';
			icon = 'fa fa-battery-3';
		} else if (status == 3) {
			color = 'label-warning';
			icon = 'fa fa-battery-2';
		} else if (status == 4) {
			color = 'label-warning';
			icon = 'fa fa-battery-1';
		} else if (status == 5) {
			color = 'label-danger';
			icon = 'fa fa-battery-0';
		} else if (status == 0) {
			color = 'label-default';
			icon = 'fa fa-times';
		}
		result += '<span class="label ' + color + '"><i class="' + icon + '"></i></span>';
		return result;
	}
	
	function addFunctionAlty(value, data, index) {
		var id = data.goodsId;
		var result = "";
		result += "<button id='history' class='btn btn-primary' onclick=\"history('"
				+ id
				+ "')\"><i class='fa fa-bars'></i> 历史记录</button>&nbsp;&nbsp;";
		result += "<shiro:hasAnyRoles name='超级管理员,管理员'><button id='update' class='btn btn-info' onclick=\"edit('"
				+ id
				+ "')\"><i class='fa fa-paste'></i> 修改</button></shiro:hasAnyRoles>";
		return result;
	}
	
	// 查询	
	$('#btn-search').bind('click', function () {
			refreshTable();
	});
	
	// 刷新表格
	function refreshTable() {
		dataTable.bootstrapTable('refresh', {
			url : list_url,
			pageSize : 10,
			pageNumber : 1
		});
	}
	// 历史记录
	function history(id) {
		var title = "历史记录";
		var url = "${ctx}/dept/log/logone/" + id;
		layer.open({
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
	// 修改
	function edit(id) {
		var title = "修改信息";
		var url = "${ctx}/dept/goods/edit/" + id;
		layer.open({
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
	// 补仓
	$('#btn-more').click(function() {
		var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
        	var title = "补仓";
    		var url = "${ctx}/dept/goods/more/" + rows[0].goodsId;
    		layer.open({
    			type : 2,
    			title : title,
    			shadeClose : true,
    			shade : 0.8,
    			area : [ '300px', '150px' ],
    			fix : false,
    			maxmin : true,
    			content : url
    		});
          }else {
        	window.parent.layer.msg("仅能选择一行数据!", {icon: 2, time: 1000, offset: 't'})
        }
	});
	// 入库
	$('#btn-add').click(function() {
		var title = "物资入库";
		var url = "${ctx}/dept/goods/add";
		layer.open({
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
	// 申请
    $('#request').click(function() {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
        	var title = "申请物资";
    		var url = "${ctx}/dept/goods/request/" + rows[0].goodsId;
    		layer.open({
    			type : 2,
    			title : title,
    			shadeClose : true,
    			shade : 0.8,
    			area : [ '300px', '150px' ],
    			fix : false,
    			maxmin : true,
    			content : url
    		});
        } else {
        	window.parent.layer.msg("仅能选择一行数据!", {icon: 2, time: 1000, offset: 't'})
        }
    });
 	// 出库
    $('#btn-delete').click(function() {
        var rows = $('#data-table').bootstrapTable('getSelections');
        var count = $('#count').val();
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
        	if(!count){
        		window.parent.layer.msg("请输入数量!", {icon: 2, time: 1000, offset: 't'})
        	}else{
        		window.parent.layer.confirm("确认出库数量?", {icon: 3, offset: 't'}, function () {
                    $.ajax({
                        url: '${ctx}/dept/goods/expand/' + rows[0].goodsId + '/' + count,
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
        } else {
        	window.parent.layer.msg("仅能选择一行数据!", {icon: 2, time: 1000, offset: 't'})
        }
    });
	</script>
</body>
</html>