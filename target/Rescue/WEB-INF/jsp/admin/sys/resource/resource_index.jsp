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
	<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
	<link href="${ctxstatic}/css/plugins/bootstrap-treeview/bootstrap-treeview.css" rel="stylesheet">
	<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="row row-lg">
					<div class="col-sm-3">
						<div id="data-tree"></div>
					</div>
					<div class="col-sm-9">
						<iframe src="${ctx}/sys/resource/list?parentId=${parentId}"
							frameborder="0" scrolling="no" id="data-resource-list"
							width="100%" height="600px"> </iframe>
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
	<!-- layer -->
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<!-- bootstrap-treeview -->
	<script src="${ctxstatic}/js/plugins/bootstrap-treeview/bootstrap-treeview.js"></script>
	<script>
	var parentid = ${parentId};
    $.ajax({
        url: '${ctx}/sys/resource/tree',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            if (response.code == 0) {
                var objTree =
                    $('#data-tree').treeview({
                        data: new Array(response.data),
                        levels: 3, // 默认打开的层级
                        // 当节点被选中的时候触发的事件
                        onNodeSelected: function (event, node) {
                            //console.log(node);
                            $('#data-resource-list').attr('src', '${ctx}/sys/resource/list?parentId=' + node.id);
                        }
                        //showCheckbox: true,//是否显示选择框
                        //hierarchicalCheck: true, //级联勾选
                        //propagateCheckEvent: true //
                    });

                // 获取所有没有被选择的节点(获取到所有节点)
                // var arr = objTree.treeview('getUnselected');
                // 获取所有节点
                var arr = objTree.treeview('getNodes');
                // 遍历每个节点
                for (var i = 0; i < arr.length; i++) {
                    var node = arr[i];
                    if (node.id == parentid) {
                        // 展开该节点
                        objTree.treeview('expandNode', [node]);
                    }
                }
            } else {
                window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
            }
        }
    });
</script>
</body>
</html>