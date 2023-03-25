<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-拯救毛孩子-修改</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/summernote/summernote.min.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form" enctype="multipart/form-data">
							<input type="hidden" value="${rescue.rescueId}" name="rescueId">
                            <div class="form-group">
								<label class="col-sm-1 control-label">城市：</label>
								<div class="col-sm-5">
	                                <select id="province" name="province" class="chosen-select" style="width:120px;" onchange="changeCity()">
	                                	<option value="-1">-- 省 --</option>
									</select>
									<select id="city" name="city" class="chosen-select" style="width:120px;">
	                                	<option value="-1">-- 市 --</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标题：</label>
								<div class="col-sm-5">
									<input id="title" name="title" type="text" class="form-control"
										autocomplete="off" value="${rescue.title}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">介绍：</label>
								<div class="col-sm-5">
									<textarea class="form-control" name="introduction" id="introduction">${rescue.introduction}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标签：</label>
								<div class="col-sm-5">
									<input id="tag" name="tag" type="text" class="form-control"
										autocomplete="off" value="${rescue.tag}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">内容：</label>
								<div class="col-sm-11">
									<textarea class="summernote" name="content" id="summernote">${rescue.content}</textarea>
								</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="text-center">
									<button class="btn btn-primary" type="submit">提交</button>
									<button class="btn btn-white" type="reset">重置</button>
								</div>
							</div>
						</form>
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
	<!-- jQuery Validation plugin javascript-->
	<script src="${ctxstatic}/js/plugins/validate/jquery.validate.min.js"></script>
	<script src="${ctxstatic}/js/plugins/validate/messages_zh.min.js"></script>
	<script src="${ctxstatic}/js/demo/form-validate-demo.js"></script>
    <!-- SUMMERNOTE -->
    <script src="${ctxstatic}/js/plugins/summernote/summernote.min.js"></script>
    <script src="${ctxstatic}/js/plugins/summernote/summernote-zh-CN.js"></script>
    <!-- Prettyfile -->
    <script src="${ctxstatic}/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
    <!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
    <!-- 高德地图 -->
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=b397b4572463d988ca93365e798b5d61&plugin=AMap.CitySearch"></script>
	<script type="text/javascript">
		$(function(){
			$('#summernote').summernote({
	            lang: 'zh-CN',
	            height: 300,
	            toolbar: [
	                ['style', ['bold', 'italic', 'underline', 'clear']],
	                ['fontname', ['fontname']],
	                ['fontsize', ['fontsize']],
	                ['color', ['color']],
	                ['para', ['ul', 'ol', 'paragraph']],
	                ['table', ['table']],
	                ['insert', ['link', 'picture']],
	                ['height', ['height']]
	              ],
	            callbacks: {
	            	onImageUpload: function(files, editor, $editable) {
	    				for(i=0;i<files.length;i++){
	    					uploadImg(files[i], editor, $editable);
	    				}
	    		    }
	            }
	     	});
			
	        // Firefox和Chrome早期版本中带有前缀
		    var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;
		    // 选择目标节点
		    var target = document.querySelector('.note-editable'); 
		    // 创建观察者对象
		    var observer = new MutationObserver(function(mutations) { //观察对象的回调函数
				mutations.forEach(function(mutation) { //forEach：遍历所有MutationRecord 
					if(mutation.removedNodes[0]!=null) {
						if(mutation.removedNodes[0].tagName ==  "IMG") {
		              		var src = mutation.removedNodes[0].src;
		              		deleteImg(src);
		            	}
		        	}
		      	});  
		    });
		    // 配置观察选项:
		    var config = { attributes: true, childList: true, characterData: true ,subtree:true};
		    // 传入目标节点和观察选项
		    observer.observe(target, config);
			
			var icon = "<i class='fa fa-times-circle'></i> ";
			// 忽略select的隐藏
			$.validator.setDefaults({ ignore: ":hidden:not(select)" });
			// 忽略textarea的隐藏
			$.validator.setDefaults({ ignore: ":hidden:not(textarea)" });
			// 表单提交
			$("#Form").validate({
				rules : {
					province : {
						min : 0
					},
					city : {
						min : 0
					},
					title : {
						required : true
					},
					content : {
						required : true
					}
				},
				messages : {
					province : {
						min : icon + "请选择省"
					},
					city : {
						min : icon + "请选择市"
					},
					title : {
						required : icon + "请输入标题"
					},
					content : {
						required : icon + "内容为空"
					}
				},
				submitHandler : function(form){
					var form = new FormData(document.getElementById("Form"));
					$.ajax({
			            url: '${ctx}/admin/rescue/update',
			            type: 'post',
			            data: form,
			            processData: false,
			            contentType: false,
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
	
			$('.note-image-input').prettyFile();
			
			//实例化城市查询类
	        var citysearch = new AMap.CitySearch();
	        var provinceinfo = "";
			var cityinfo = "";
	        //自动获取用户IP，返回当前城市
	        citysearch.getLocalCity(function(status, result) {
	            provinceinfo = result.province; 
	        	cityinfo = result.city;
	        	$.ajax({
	    		    type : "post",
	    		    url : "${ctx}/area/province", 
	    		    async : false,
	    		    dataType:"json",
	    		    success : function(data) {
	    		    	for(var i=0;i<data.length;i++){
	    		    		if(data[i].name == provinceinfo) {
	    		    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
	    		    		}else {
	    		    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	    		    		}
	                        $("#province").append($option);
	                        $('.chosen-select').trigger('chosen:updated');
	                    }
	    		    },
	    		});
	    		
	    		var pid = $('#province').val();
	    		$.ajax({
	            	type : "post",
	                url:"${ctx}/area/city/" + pid,
	                async : false,
	                dataType:"json",
	                success:function(data){
	                    for(var i=0;i<data.length;i++){
	                    	if(data[i].name == cityinfo) {
	    		    			var $option = $("<option selected='selected' value='"+data[i].id+"'>"+data[i].name+"</option>");
	    		    		}else {
	    		    			var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	    		    		}
	                        $("#city").append($option);
	                        $('.chosen-select').trigger('chosen:updated');
	                    }
	                }
	            });
	        });
		});
	
		function uploadImg(file, editor, $editable){
    		var filename = false;
       		try{
                filename = file['name'];
            } catch(e){
                filename = false;
            }
			var url = "${ctx}";
            if(!filename){$(".note-alarm").remove();}
            //以上防止在图片在编辑器内拖拽引发第二次上传导致的提示错误
            data = new FormData();
            data.append("file", file);
            $.ajax({
                data: data,
                type: "POST",
                url: "${ctx}/fore/rescue/upload", //图片上传出来的url，返回的是图片上传后的路径，http格式
                contentType: false,
                cache: false,
                processData: false,
                success: function (response) {
					if (response.code == 0) {
						url += response.url;
						$('#summernote').summernote('insertImage', url, filename);
						$("img").addClass("img-responsive");
					} else {
						window.parent.layer.alert(response.msg, {icon : 5, offset : '0px'});
					}
				}
			});
		}
	
		function changeCity(){
			var pid = $('#province').val();
	        $.ajax({
	        	type : "post",
	            url:"${ctx}/area/city/" + pid,
	            async : false,
	            dataType:"json",
	            success:function(data){
	                //清空城市下拉列表框的内容
	                $("#city").html("<option value='-1'>-- 市 --</option>");
	                //遍历json，json数组中每一个json，都对应一个省的信息，都应该在省的下拉列表框下面添加一个<option>
	                for(var i=0;i<data.length;i++){
	                	var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	                    $("#city").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
	            }
	        });
	    }
	</script>
</body>
</html>