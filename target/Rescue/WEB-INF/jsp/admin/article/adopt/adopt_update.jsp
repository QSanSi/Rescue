<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-领养文章-修改</title>
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
							<input id="deptId" type="hidden" value="${adopt.deptId}" name="deptId">
							<input type="hidden" value="${adopt.adoptId}" name="adoptId">
							<div class="form-group">
								<label class="col-sm-1 control-label">待领养宠物：</label>
								<div class="col-sm-5">
									<select id="petId" class="chosen-select" name="petId" style="width:120px;">
										<option value="-1">请选择宠物</option>
										<c:forEach items="${petlist}" var="pet">
											<option value="${pet.petId}" <c:if test="${adopt.petId==pet.petId}">selected</c:if>>${pet.petname}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标题：</label>
								<div class="col-sm-5">
									<input id="title" name="title" type="text" class="form-control"
										autocomplete="off" value="${adopt.title}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">介绍：</label>
								<div class="col-sm-5">
									<textarea class="form-control" name="introduction" id="introduction">${adopt.introduction}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">标签：</label>
								<div class="col-sm-5">
									<input id="tag" name="tag" type="text" class="form-control"
										autocomplete="off" value="${adopt.tag}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-1 control-label">内容：</label>
								<div class="col-sm-11">
									<textarea class="summernote" name="content" id="summernote">${adopt.content}</textarea>
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
	<!-- Chosen -->
    <script src="${ctxstatic}/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${ctxstatic}/js/custom/Chosen.js"></script>
    <!-- Prettyfile -->
    <script src="${ctxstatic}/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
    <!-- SUMMERNOTE -->
    <script src="${ctxstatic}/js/plugins/summernote/summernote.min.js"></script>
    <script src="${ctxstatic}/js/plugins/summernote/summernote-zh-CN.js"></script>
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 忽略textarea的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(textarea)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				petId : {
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
				petId : {
					min : icon + "请选择待领养宠物"
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
		            url: '${ctx}/admin/adopt/update',
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
                url: "${ctx}/admin/adopt/upload", //图片上传出来的url，返回的是图片上传后的路径，http格式
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
		
		$('.note-image-input').prettyFile();
	});
	</script>
</body>
</html>