<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-契约-契约列表</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
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
							<div class="bars pull-left">
								<div id="left-toolbar" role="group">
									<shiro:hasRole name="站点管理员">
										<button type='button' class='btn btn-primary' id='btn-add'>
											<i class='fa fa-plus'></i> 新增
										</button>
									</shiro:hasRole>
									<button type='button' class='btn btn-danger' id='btn-delete'>
										<i class='fa fa-trash'></i> 删除
									</button>
								</div>
							</div>
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
	<script src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
	<script src="${ctxstatic}/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
	<script src="${ctxstatic}/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
	<!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<script type="text/javascript">
	var list_url = '${ctx}/fore/contract/data';
	// 初始化表格数据
	var dataTable = $('#data-table').bootstrapTable({
		url : list_url, //  请求后台的URL
		method : "get", //  请求方式
		uniqueId : "contractId", //  每一行的唯一标识，一般为主键列
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
                master: $("#Name").val(),
                deptId : $('#deptId').val(),
			}
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'dept.deptName',
			title : '领养站点'
		}, {
			field : 'master',
			title : '领养人'
		}, {
			field : 'tel',
			title : '联系方式'
		}, {
			field : 'addr',
			title : '居住地址'
		}, {
			field : 'pet.petname',
			title : '领养宠物',
			formatter : petformatter
		}, {
			field : 'createTime',
			title : '记录时间'
		}, {
			field : 'operate',
			title : '操作',
			align : 'center',
			clickToSelect : false,
			formatter : addFunctionAlty,//表格中增加按钮
			width : 200
		} ]
	});
	
	function petformatter(value, row, index){
		return "<a onclick=\"petinfo('" + row.pet.petId + "')\" title='查看宠物信息'>" + value + "</a>";
	}
	
	function addFunctionAlty(value, data, index) {
		var id = data.contractId;
		var result = "";
		result += "<button id='assign-resource' class='btn btn-primary' onclick=\"info('"
				+ id
				+ "')\"><i class='fa fa-info'></i> 详细信息</button>&nbsp;&nbsp;";
		result += "<button id='update' class='btn btn-info' onclick=\"edit('"
				+ id
				+ "')\"><i class='fa fa-paste'></i> 修改</button>";
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
	
	// 宠物详细信息
	function petinfo(id) {
		var title = "详细信息";
		var url = "${ctx}/fore/pet/info/" + id;
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
	
	// 契约信息
	function info(id) {
		var title = "详细信息";
		var url = "${ctx}/fore/contract/info/" + id;
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
		var deptId = $('#deptId').val()
		var url = "${ctx}/fore/contract/update/" + id + "/" + deptId;
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
	// 新增
	$('#btn-add').click(function() {
		var title = "新增";
		var deptId = $('#deptId').val()
		var url = "${ctx}/fore/contract/add/" + deptId;
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
	// 批量删除
    $('#btn-delete').click(function() {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
            window.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
                $.ajax({
                    url: '${ctx}/fore/contract/delete/' + rows[0].contractId,
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
        } else {
            window.parent.layer.confirm("确认批量删除?", {icon: 3, offset: 't'}, function () {
                var ids = new Array();
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].contractId);
                }
                $.ajax({
                    url: '${ctx}/fore/contract/deletebatch',
                    contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
                    type: 'post',
                    dateType: 'json',
                    data: JSON.stringify(ids),
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
            });
        }
    });
	</script>
</body>
</html>