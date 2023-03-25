<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-拯救毛孩子-文章列表</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight blog">
    	<input id="userId" type="hidden" value="<shiro:principal property="userId" />" name="userId">
        <div class="row" id="page">
			<div class="col-lg-4" id="adoptlist">
				<div class="fixed-table-toolbar">
					<div class="pull-right search col-sm-3 input-group">
						<input id="Name" class="form-control" type="text" placeholder="搜索"
							autocomplete="off"> <span class="input-group-btn">
							<button id="btn-search" type="button" class="btn btn-primary">
								搜索</button>
						</span>
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
    <script type="text/javascript">
    	$(function(){
       		var page = 1;
       		load(page);
    	});
    
	    $('#btn-search').bind('click', function () {
			load(1);
		});
	    
    	function load(page){
    		var userId = $('#userId').val();
    		$.ajax({
	            url: '${ctx}/fore/rescue/minedata/' + userId,
	            type: 'get',
	            data: {
	            	current: page, 	 // 当前页 1
	            	size: 5,      // 一页显示多少 10
	                title: $('#Name').val()
	            },
	            dataType: 'json',
	            success : function(data){
	            	$('.ibox').remove();
	            	var rows = new Array();
	            	rows = data.rows;
	            	var current = data.current;
	            	var maxpage = data.maxpage;
	            	var lastpage = current - 1;
	            	if(lastpage < 1)
	            		lastpage = 1;
	            	var nextpage = current + 1;
	            	if(nextpage > maxpage)
	            		nextpage = maxpage;
	            	var blogList = '';
	            	var pagnation = '';
	            	if (rows.length > 0) {
	                    for (var i = 0; i < rows.length; i++) {
	                    	blogList += "<div class='ibox'><div class='ibox-content'><a href='javascript:void(0);' onclick=\"openTabPage('${ctx}/admin/rescue/update/"
	                    	+ rows[i].rescueId + "', '" + rows[i].title + "')\" class='btn-link'><h2>"
	                    	+ rows[i].title + "</h2></a><div class='small m-b-xs'><strong>" 
	                    	+ rows[i].user.username + "</strong><span class='text-muted'> <i class='fa fa-clock-o'></i> "
	                    	+ rows[i].createTime + "</span></div><p>"
	                    	+ rows[i].introduction + "</p><div class='row'><div class='col-sm-6'><h5>标签：</h5><button class='btn btn-primary btn-xs' type='button'>"
	                    	+ rows[i].tag + "</button></div><div class='col-sm-6'><div class='small text-right'><h5>操作：</h5>"
	                    	+ verify(rows[i].verify) + "" + status(rows[i].rescueId, rows[i].status) + "</div></div></div></div></div>";
	                    }
	                }else{
	                	blogList += "<div class='ibox'><div class='ibox-content m-b-sm border-bottom'><div class='text-center p-lg'>"
	                	+ "<h2>没有找到符合条件的记录或该城市无我司分部，无法提供救助服务！QAQ</h2><span>您可以尝试重新搜索关键词</span></div></div></div>";
	                }
	            	$('#adoptlist').append(blogList);
	            	if(maxpage > 1){
	            		pagnation += "<div class='ibox'><p class='text-muted text-center'><a onclick=\"load('"
	    		            + 1 + "')\" href='javascript:void(0);'>首页</a> | <a onclick=\"load('"
	    	            	+ lastpage + "')\" href='javascript:void(0);'>上一页</a> | 第"
	    	            	+ current + "页&nbsp;&nbsp;&nbsp;&nbsp;总共"
	    	            	+ maxpage + "页 | <a onclick=\"load('"
	    	            	+ nextpage + "')\" href='javascript:void(0);'>下一页</a> | <a onclick=\"load('"
	    	            	+ maxpage + "')\" href='javascript:void(0);'>尾页</a></p></div>"
	    	            $('#page').append(pagnation);
	            	}
	            }
	        })
    	}
    	
    	function status(id, value) {
    		var status = value;
    		var result = "";
    		if (status == 0) {
    			color = 'btn-danger';
    			str = '待救助';
    		} else if (status == 1) {
    			color = 'btn-success';
    			str = '救助中';
    		} else if (status == 2) {
    			color = 'btn-primary';
    			str = '已救助';
    		}
    		result += "<div class='btn-group'><button data-toggle='dropdown' class='btn "
    		+ color + " btn-xs dropdown-toggle'>"
    		+ str + "<span class='caret'></span></button><ul class='dropdown-menu'><li><a href='javascript:void(0);' onclick=\"del('"
			+ id + "')\">删除</a></li></ul></div>";
    		return result;
    	}
    	
    	function verify(value) {
			var status = value;
			var result = "";
			if (status == 0) {
				color = 'btn-danger';
				str = '审核中';
				result += '<button class="btn '+ color + ' btn-xs" type="button">' + str + '</button>';
				return result;
			}else {
				return result;
			}
		}
    	
    	// 删除
		function del(id) {
			window.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
				$.ajax({
                    url: '${ctx}/admin/rescue/delete/' + id,
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
    	
    	function openTabPage(url, title) {
    		var wpd = $(window.parent.document);
    		var mainContent = wpd.find('.J_mainContent');
    		var thisIframe = mainContent.find("iframe[data-id='"+ url +"']");
    		var pageTabs = wpd.find('.J_menuTabs .page-tabs-content ')
    		pageTabs.find(".J_menuTab.active").removeClass("active");
    		mainContent.find("iframe").css("display", "none");
    		if(thisIframe.length > 0){	// 选项卡已打开
    			thisIframe.css("display", "inline");
    			pageTabs.find(".J_menuTab[data-id='"+ url +"']").addClass("active");
    		}else{
    			var menuItem = wpd.find("a.J_menuItem[href='"+ url +"']");
    			var dataIndex = title == undefined ? menuItem.attr("data-index") : '9999';
    			var _title = title == undefined ? menuItem.find('.nav-label').text() : title;
    			var iframe = '<iframe class="J_iframe" name="iframe'+ dataIndex +'" width="100%" height="100%" src="' + url + '" frameborder="0" data-id="' + url
    	                + '" seamless="" style="display: inline;"></iframe>';
    	        pageTabs.append(
    	                ' <a href="javascript:;" class="J_menuTab active" data-id="'+url+'">' + _title + ' <i class="fa fa-times-circle"></i></a>');
    	        mainContent.append(iframe);
    			//显示loading提示
    			var loading = top.layer.load();
    			mainContent.find('iframe:visible').load(function () {
    			    //iframe加载完成后隐藏loading提示
    			    top.layer.close(loading);
    			});
    		}
    	}
    </script>
</body>
</html>