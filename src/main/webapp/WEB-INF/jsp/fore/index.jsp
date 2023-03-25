<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">

<title>HeMaozhu-用户-主页</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.min.css?v=4.4.0"
	rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg pace-done boxed-layout"
	style="overflow: hidden">
	<div id="wrapper">
		<!--左侧导航开始-->
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="nav-close">
				<i class="fa fa-times-circle"></i>
			</div>
			<div class="sidebar-collapse" id="sidebar-collapse">
				<ul class="nav" id="side-menu">
					<li class="nav-header">
						<div class="dropdown profile-element">
							<span><img alt="image" class="img-circle"
								src="${ctxstatic}/img/img.jpg" style="width:64px;height:64px;"/></span> <a
								data-toggle="dropdown" class="dropdown-toggle" href="#"> <span
								class="clear"> <span class="block m-t-xs"><strong
										class="font-bold"><shiro:principal
												property="username" /><b class="caret"></b></strong></span>
							</span>
							</a>
							<ul class="dropdown-menu animated fadeInRight m-t-xs">
								<li><a class="J_menuItem" href="#">修改头像</a></li>
								<li><a class="J_menuItem" href="#">个人资料</a></li>
								<li><a class="J_menuItem" href=#>修改密码</a></li>
								<li class="divider"></li>
								<li><a href="${ctx}/fore/users/userlogout">安全退出</a></li>
							</ul>
						</div>
						<div class="logo-element">HM</div>
					</li>
					<li>
                        <a class="J_menuItem" href="${ctx}/page/forehome">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">主页</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${ctx}/fore/adopt/list">
                            <i class="fa fa-paw"></i>
                            <span class="nav-label">领养宠物</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${ctx}/fore/cityadopt/list">
                            <i class="fa fa-commenting-o"></i>
                            <span class="nav-label">同城领养</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${ctx}/fore/tips/list">
                            <i class="fa fa-tags"></i>
                            <span class="nav-label">养宠小知识</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="javascript:void(0);">
                            <i class="fa fa-shopping-cart"></i>
                            <span class="nav-label">宠物商城</span>
                        </a>
                    </li>
                    <li>
                        <a class="J_menuItem" href="${ctx}/fore/rescue/list/<shiro:principal property="userId"/>">
                            <i class="fa fa-heart"></i>
                            <span class="nav-label">拯救毛孩子</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-bookmark"></i>
                            <span class="nav-label">我的文章</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a class="J_menuItem" href="${ctx}/fore/cityadopt/mine">同城领养</a>
                            </li>
                            <li>
                                <a class="J_menuItem" href="${ctx}/fore/rescue/mine">拯救毛孩子</a>
                            </li>
                        </ul>
                    </li>
				</ul>
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
				<a href="${ctx}/fore/users/userlogout"
					class="roll-nav roll-right J_tabExit"><i
					class="fa fa fa-sign-out"></i> 退出</a>
			</div>
			<div class="row J_mainContent" id="content-main">
				<iframe class="J_iframe" id="iframe0" name="iframe0" width="100%" height="100%"
					src="${ctx}/page/forehome" frameborder="0" data-id="home.jsp"
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
	<script type="text/javascript">
		function closeTab_Active() {
	         $(".J_menuTab.active",window.top.document).find(".fa.fa-times-circle").click();      
	    }
		
		$('#side-menu').metisMenu();
	</script>
</body>
</html>