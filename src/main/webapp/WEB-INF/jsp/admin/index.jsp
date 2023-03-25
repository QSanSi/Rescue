<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<title>HeMaozhu-管理系统-主页</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.min.css?v=4.4.0"
	rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg"
	style="overflow: hidden">
	<div id="wrapper">
		<!--左侧导航开始-->
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="nav-close">
				<i class="fa fa-times-circle"></i>
			</div>
			<div class="sidebar-collapse" id="sidebar-collapse">
				<ul class="nav">
					<li class="nav-header">
						<div class="dropdown profile-element">
							<span><img alt="image" class="img-circle"
								src="${ctxstatic}/img/catdog64.jpg" /></span> <a
								data-toggle="dropdown" class="dropdown-toggle" href="#"> <span
								class="clear"> <span class="block m-t-xs"><strong
										class="font-bold"><shiro:principal
												property="username" /><b class="caret"></b></strong></span>
							</span>
							</a>
							<ul class="dropdown-menu animated fadeInRight m-t-xs">
								<li><a class="J_menuItem" href="#">修改密码</a></li>
								<li class="divider"></li>
								<li><a href="${ctx}/account/logout">安全退出</a></li>
							</ul>
						</div>
						<div class="logo-element">HM</div>
					</li>
				</ul>
				<ul class="nav side-menu" id="side-menu"></ul>
			</div>
		</nav>
		<!--左侧导航结束-->

		<!--右侧部分开始-->
		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top" role="navigation"
					style="margin-bottom: 0">
					<div class="navbar-header">
						<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "
							href="#"><i class="fa fa-bars"></i> </a>
					</div>
				</nav>
			</div>
			<div class="row content-tabs">
				<button class="roll-nav roll-left J_tabLeft">
					<i class="fa fa-backward"></i>
				</button>
				<nav class="page-tabs J_menuTabs">
					<div class="page-tabs-content">
						<a href="javascript:;" class="active J_menuTab" data-id="home.jsp">主页</a>
					</div>
				</nav>
				<button class="roll-nav roll-right J_tabRight">
					<i class="fa fa-forward"></i>
				</button>
				<div class="btn-group roll-nav roll-right">
					<button class="dropdown J_tabClose" data-toggle="dropdown">
						关闭操作<span class="caret"></span>

					</button>
					<ul role="menu" class="dropdown-menu dropdown-menu-right">
						<li class="J_tabShowActive"><a>定位当前选项卡</a></li>
						<li class="divider"></li>
						<li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
						<li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
					</ul>
				</div>
				<a href="${ctx}/account/logout"
					class="roll-nav roll-right J_tabExit"><i
					class="fa fa fa-sign-out"></i> 退出</a>
			</div>
			<div class="row J_mainContent" id="content-main">
				<iframe class="J_iframe" id="iframe0" name="iframe0" width="100%" height="100%"
					src="${ctx}/page/home" frameborder="0" data-id="home.jsp"
					seamless></iframe>
			</div>
			<div class="footer">
				<div class="pull-right">
					&copy; 2020-2030 <a href="#" target="_blank">HeMaoZhu</a>
				</div>
			</div>
		</div>
		<!--右侧部分结束-->

	</div>
	<!-- 全局js -->
	<script src="${ctxstatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxstatic}/js/bootstrap.min.js?v=3.3.6"></script>
	<script src="${ctxstatic}/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script src="${ctxstatic}/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	<script src="${ctxstatic}/js/plugins/layer/layer.min.js"></script>
	<script src="${ctxstatic}/js/plugins/art-template/template-web.js"></script>
	<!-- 自定义js -->
	<script src="${ctxstatic}/js/hplus.js?v=4.1.0"></script>
	<script src="${ctxstatic}/js/contabs.js" type="text/javascript"></script>
	<!-- 第三方插件 -->
	<script src="${ctxstatic}/js/plugins/pace/pace.min.js"></script>
	
	<script id="tpl-menu" type="text/html">
    {{each menuList menu}}
    <li>
        <a href="#">
			<i class="{{menu.icon}}"></i>
			<span class="nav-label">{{menu.text}}</span>
			<span class="fa arrow"></span>
		</a>
        <ul class="nav nav-second-level">
            {{each menu.nodes sub_menu}}
            <li>
                <a class="J_menuItem" href="${ctx}/{{sub_menu.url}}">{{sub_menu.text}}</a>
            </li>
            {{/each}}
        </ul>
    </li>
    {{/each}}
	</script>
	<script>
		$.ajax({
			url : '${ctx}/page/menu',
			type : 'get',
			async: false,
			dataType : 'json',
			success : function(response) {
				var html = template('tpl-menu', {
					menuList : response.data
				});
				$('#sidebar-collapse .side-menu').html(html);
				$('#side-menu').metisMenu();
			}
		});
	</script>
</body>
</html>