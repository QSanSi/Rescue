<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-管理系统-物资记录</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link
	href="${ctxstatic}/css/plugins/bootstrap-table/bootstrap-table.min.css"
	rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
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
							<input id="goodsId" type="hidden" value="${goodsId}" name="goodsId">
							<div class="bars pull-left btn-group">
								<div id="left-toolbar" role="group">
									<shiro:hasAnyRoles name="超级管理员,管理员">
										<button type='button' class='btn btn-primary' id='btn-add'>
											<i class='fa fa-thumbs-o-up'></i> 审核
										</button>
										<button type='button' class='btn btn-danger' id='btn-delete'>
											<i class='fa fa-times'></i> 驳回
										</button>
									</shiro:hasAnyRoles>
								</div>
							</div>
                            <div class="bars pull-left input-daterange input-group" id="datepicker">
                               	<input id="pd" type="text" class="input-sm form-control" name="pastday" value="${pastday}" onchange="refreshTable()"/>
                               	<span class="input-group-addon">到</span>
                               	<input id="d" type="text" class="input-sm form-control" name="today" value="${today}" onchange="refreshTable()"/>
                            </div>
							<div class="columns columns-right btn-group pull-right">
								<button class="btn btn-primary" type="button" name="refresh"
									title="刷新" onclick="refreshTable()">
									<i class="glyphicon glyphicon-repeat"></i>
								</button>
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
	<!-- Data picker -->
    <script src="${ctxstatic}/js/plugins/datapicker/bootstrap-datepicker.js"></script>
	<script type="text/javascript">
	var list_url = '${ctx}/dept/log/data';
	// 初始化表格数据
	var dataTable = $('#data-table').bootstrapTable({
		url : list_url, //  请求后台的URL
		method : "get", //  请求方式
		uniqueId : "id", //  每一行的唯一标识，一般为主键列
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
                goodsId : $('#goodsId').val(),
                pd : $('#pd').val(),
				d: $('#d').val(),
				column: this.sortName,
                asc: 'asc' == this.sortOrder
			}
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'deptGoods.name',
			title : '物资名称'
		}, {
			field : 'dept.deptName',
			title : '所属部门',
		}, {
			field : 'count',
			title : '请求数量/变化数量'
		}, {
			field : 'restcount',
			title : '原库存',
		}, {
			field : 'requestTime',
			title : '请求时间',
			sortable : true
		}, {
			field : 'updateTime',
			title : '变化时间',
			sortable : true
		}, {
			field : 'confirmTime',
			title : '收货时间',
			sortable : true
		}, {
			field : 'status',
			title : '状态',
			align : 'center',
			sortable : true,
			formatter : statusLabel,//表格中增加状态Label
			width : 100
		}, {
			field : 'operate',
			title : '操作',
			align : 'center',
			clickToSelect : false,
			formatter : addFunctionAlty,//表格中增加按钮
			width : 150
		}]
	});
	
	function statusLabel(value, data, index) {
		var status = value;
		var result = "";
		if (status == 0) {
			color = 'label-danger';
			str = '驳回';
		} else if (status == 1) {
			color = 'label-primary';
			str = '已完成';
		} else if (status == 2) {
			color = 'label-info';
			str = '发货中';
		} else if (status == 3){
			color = 'label-success';
			str = '未审核';
		}
		result += '<span class="label '+ color + '">' + str + '</span>';
		return result;
	}
	function addFunctionAlty(value, data, index) {
		var id = data.id;
		var sta = data.status;
		if(sta == 2){
			var result = "";
			result += "<shiro:hasRole name='站点管理员'><button id='check' class='btn btn-primary btn-xs' onclick=\"check('"
					+ id
					+ "')\"><i class='fa fa-check'></i> 确认收货</button></shiro:hasRole>";
			return result;
		}else
			return null;
	}
	// 刷新表格
	function refreshTable() {
		dataTable.bootstrapTable('refresh', {
			url : list_url,
			pageSize : 10,
			pageNumber : 1
		});
	}
	// 确认
	function check(id) {
		window.parent.layer.confirm("确认收货?", {icon: 3, offset: 't'}, function () {
			$.ajax({
                url: '${ctx}/dept/log/check/' + id,
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
	// 审核
    $('#btn-add').click(function() {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
        	if(rows[0].status != 3){
        		window.parent.layer.msg("已审核，请勿重复操作！", {icon: 2, time: 1000, offset: 't'})
        	}else{
        		window.parent.layer.confirm("确认通过?", {icon: 3, offset: 't'}, function () {
                    $.ajax({
                        url: '${ctx}/dept/log/accept/' + rows[0].id,
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
        	var ids = new Array();//要删除的用户的id的集合
        	var b = true;
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].id);
                if(rows[i].status != 3){
            		window.parent.layer.msg("存在已审核数据项，请勿重复操作！", {icon: 2, time: 1000, offset: 't'})
            		b = false;
            	}
            }
            if(b){
                window.parent.layer.confirm("确认通过全部所选项?", {icon: 3, offset: 't'}, function () {
                    $.ajax({
                        url: '${ctx}/dept/log/acceptbatch',
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
        }
    });
 	// 驳回
    $('#btn-delete').click(function() {
        var rows = $('#data-table').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
        	if(rows[0].status != 3){
        		window.parent.layer.msg("已审核，请勿重复操作！", {icon: 2, time: 1000, offset: 't'})
        	}else{
	            window.parent.layer.confirm("确认驳回?", {icon: 3, offset: 't'}, function () {
	                $.ajax({
	                    url: '${ctx}/dept/log/ban/' + rows[0].id,
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
        	var ids = new Array();//要删除的用户的id的集合
        	var b = true;
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].id);
                if(rows[i].status != 3){
            		window.parent.layer.msg("存在已审核数据项，请勿重复操作！", {icon: 2, time: 1000, offset: 't'})
            		b = false;
            	}
            }
            if(b){
	            window.parent.layer.confirm("确认驳回全部所选项?", {icon: 3, offset: 't'}, function () {
	                var ids = new Array();//要删除的用户的id的集合
	                for (var i = 0; i < rows.length; i++) {
	                    ids.push(rows[i].id);
	                }
	                $.ajax({
	                    url: '${ctx}/dept/log/banbatch',
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
        }
    });
 
    $('#datepicker').datepicker({
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
	</script>
</body>
</html>