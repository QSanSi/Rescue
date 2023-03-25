<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HeMaozhu-志愿者-注册志愿者</title>
<link href="${ctxstatic}/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="${ctxstatic}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
<link href="${ctxstatic}/css/animate.css" rel="stylesheet">
<link href="${ctxstatic}/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="${ctxstatic}/css/style.css?v=4.1.0" rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" onsubmit="return false" id="Form">
							<div class="text-center"><h1>您还不是志愿者，请注册</h1></div>
							<input id="userId" type="hidden" value="<shiro:principal property="userId" />" name="userId">
							<div class="form-group">
								<label class="col-sm-4 control-label">真实姓名：</label>
								<div class="col-sm-5">
									<input id="realname" name="realname" type="text" class="form-control">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">性别：</label>
								<div class="col-sm-5">
									<select id="gendar" class="chosen-select" name="gendar" style="width:120px;">
										<option value="-1">请选择性别</option>
										<option value="0">男</option>
										<option value="1">女</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="tel" name="tel" type="tel" class="form-control">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">身份证信息：</label>
								<div class="col-sm-5">
									<input id="idcard" type="text" class="form-control"
										name="idcard" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">注册站点：</label>
								<div class="col-sm-5">
									<select id="deptId" class="chosen-select" name="deptId" style="width:120px;">
										<option value="-1">请选择站点</option>
										<c:forEach items="${deptlist}" var="dept">
											<option value="${dept.deptId}">${dept.deptName}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">志愿地区：</label>
								<div class="col-sm-8">
                                	<select id="province" name="province" class="chosen-select" style="width:120px;" onchange="changeCity()">
                                		<option value="-1">-- 省 --</option>
									</select>
									<select id="city" name="city" class="chosen-select" style="width:120px;" onchange="changeDistrict()">
                                		<option value="-1">-- 市 --</option>
									</select>
									<select id="district" name="district" class="chosen-select" style="width:120px;">
                                		<option value="-1">-- 区/县 --</option>
									</select>
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
	<script type="text/javascript">
		$(function(){
			var icon = "<i class='fa fa-times-circle'></i> ";
			// 增加手机号验证规则
			$.validator.addMethod("isMobile",function(value, element) {
				var length = value.length;
				var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
				return this.optional(element) || (length == 11 && mobile.test(value));
				}, icon + "请正确填写您的手机号码");
			
			$.validator.addMethod("isIdCardNo", function(value, element) { 
			    return this.optional(element) || isIdCardNo(value);     
			}, icon + "请正确输入您的身份证号码");
			
			// 忽略select的隐藏
			$.validator.setDefaults({ ignore: ":hidden:not(select)" });
			// 表单提交
			$("#Form").validate({
				rules : {
					realname : {
						required : true
					},
					gendar : {
						min : 0
					},
					tel : {
						required : true,
						minlength : 11,
						isMobile : true,
					},
					idcard : {
						required : true,
						isIdCardNo : true
					},
					deptId : {
						min : 0
					},
					province : {
						min : 0
					},
					city : {
						min : 0
					},
					district : {
						min : 0
					}
				},
				messages : {
					realname : {
						required : icon + "请输入真实姓名"
					},
					gendar : {
						min : icon + "请选择性别"
					},
					tel : {
						required : icon + "请输入手机号",
						minlength : icon + "不能小于11个字符",
						isMobile : icon + "请正确填写手机号码"
					},
					idcard : {
						required : icon + "请输入身份证信息",
					},
					deptId : {
						min : icon + "请选择注册部门"
					},
					province : {
						min : icon + "请选择省"
					},
					city : {
						min : icon + "请选择市"
					},
					district : {
						min : icon + "请选择区/县"
					}
				},
				submitHandler : function(form){
					$.ajax({
			            url: '${ctx}/fore/vol/add',
			            type: 'post',
			            data: $("#Form").serialize(),
			            dataType: 'json',
			            success: function (response) {
			                if (response.code == 0) {
			                	window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'}, function(){
			                		window.parent.closeTab_Active();
			                	});
			                } else {
			                    window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
			                }
			            }
			        })
				}
			});
			
			$.ajax({
			    type : "post",
			    url : "${ctx}/area/province", 
			    async : false,
			    dataType:"json",
			    success : function(data) {
			    	for(var i=0;i<data.length;i++){
			    		var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	                    $("#province").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
			    },
			});
		});
		
		function changeCity(){
	        var pid = $("#province").val();
	        $.ajax({
	        	type : "post",
	            url:"${ctx}/area/city/" + pid,
	            async : false,
	            dataType:"json",
	            success:function(data){
	                //清空城市下拉列表框的内容
	                $("#city").html("<option value='-1'>-- 请选择市 --</option>");
	                $("#district").html("<option value='-1'>-- 请选择区/县 --</option>");
	                //遍历json，json数组中每一个json，都对应一个省的信息，都应该在省的下拉列表框下面添加一个<option>
	                for(var i=0;i<data.length;i++){
	                	var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	                    $("#city").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
	            }
	        });
	    }
		
		function changeDistrict(){
	        var cid = $("#city").val();
	        $.ajax({
	        	type : "post",
	            url:"${ctx}/area/district/" + cid,
	            async : false,
	            dataType:"json",
	            success:function(data){
	                //清空城市下拉列表框的内容
	                $("#district").html("<option value='-1'>-- 请选择区/县 --</option>");
	                //遍历json，json数组中每一个json，都对应一个省的信息，都应该在省的下拉列表框下面添加一个<option>
	                for(var i=0;i<data.length;i++){
	                	var $option = $("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
	                    $("#district").append($option);
	                    $('.chosen-select').trigger('chosen:updated');
	                }
	            }
	        });
	    }
		
		// --身份证号码验证-支持新的带x身份证
		function isIdCardNo(num) {
		    var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4,
		    2, 1);
		    var error;
		    var varArray = new Array();
		    var intValue;
		    var lngProduct = 0;
		    var intCheckDigit;
		    var intStrLen = num.length;
		    var idNumber = num;
		    // initialize
		    if ((intStrLen != 15) && (intStrLen != 18)) {
		        // error = "输入身份证号码长度不对！";
		        // alert(error);
		        // frmAddUser.txtIDCard.focus();
		        return false;
		    }
		    // check and set value
		    for (i = 0; i < intStrLen; i++) {
		        varArray[i] = idNumber.charAt(i);
		        if ((varArray[i] > '9' || varArray[i] < '0') && (i != 17)) {
		            // error = "错误的身份证号码！.";
		            // alert(error);
		            // frmAddUser.txtIDCard.focus();
		            return false;
		        } else if (i < 17) {
		            varArray[i] = varArray[i] * factorArr[i];
		        }
		    }
		    if (intStrLen == 18) {
		        // check date
		        var date8 = idNumber.substring(6, 14);
		        if (isDate8(date8) == false) {
		            // error = "身份证中日期信息不正确！.";
		            // alert(error);
		            return false;
		        }
		        // calculate the sum of the products
		        for (i = 0; i < 17; i++) {
		            lngProduct = lngProduct + varArray[i];
		        }
		        // calculate the check digit
		        intCheckDigit = 12 - lngProduct % 11;
		        switch (intCheckDigit) {
		            case 10:
		                intCheckDigit = 'X';
		                break;
		            case 11:
		                intCheckDigit = 0;
		                break;
		            case 12:
		                intCheckDigit = 1;
		                break;
		        }
		        // check last digit
		        if (varArray[17].toUpperCase() != intCheckDigit) {
		            // error = "身份证效验位错误!...正确为： " + intCheckDigit + ".";
		            // alert(error);
		            return false;
		        }
		    }
		    else { // length is 15
		        // check date
		        var date6 = idNumber.substring(6, 12);
		        if (isDate6(date6) == false) {
		            // alert("身份证日期信息有误！.");
		            return false;
		        }
		    }
		    // alert ("Correct.");
		    return true;
		}
		function isDate6(sDate) {
		    if (!/^[0-9]{6}$/.test(sDate)) {
		        return false;
		    }
		    var year, month, day;
		    year = sDate.substring(0, 4);
		    month = sDate.substring(4, 6);
		    if (year > 2500 || year < 1700)
		        return false
		    if (month > 12 || month < 1)
		        return false
		    return true
		}
		function isDate8(sDate) {
		    if (!/^[0-9]{8}$/.test(sDate)) {
		        return false;
		    }
		    var year, month, day;
		    year = sDate.substring(0, 4);
		    month = sDate.substring(4, 6);
		    day = sDate.substring(6, 8);
		    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
		    if (year > 2500 || year < 1700)
		        return false
		    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
		        iaMonthDays[1] = 29;
		    if (month > 12 || month < 1)
		        return false
		    if (day > iaMonthDays[month - 1] || day < 1)
		        return false
		    return true
		}
	</script>
</body>
</html>