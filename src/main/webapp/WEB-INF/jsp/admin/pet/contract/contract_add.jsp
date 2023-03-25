<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
<title>HeMaozhu-契约协议-新增</title>
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
						<form class="form-horizontal m-t" onsubmit="return false" id="Form" enctype="multipart/form-data">
							<input id="deptId" type="hidden" value="<shiro:principal property="deptId" />" name="deptId">
							<div class="form-group">
								<label class="col-sm-4 control-label">领养人：</label>
								<div class="col-sm-5">
									<input id="master" name="master" type="text" class="form-control"
										autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">年龄：</label>
								<div class="col-sm-5">
									<input id="age" type="text" class="form-control"
										name="age" autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">职业：</label>
								<div class="col-sm-5">
									<input id="career" name="career" type="text" class="form-control"
										autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-5">
									<input id="tel" name="tel" type="tel" class="form-control"
										autocomplete="off">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">居住地址： </label>
								<div class="col-sm-5">
									<textarea id="addr" name="addr" class="form-control"></textarea>
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
								<label class="col-sm-4 control-label">领养宠物：</label>
								<div class="col-sm-5">
									<select id="petId" class="chosen-select" name="petId" style="width:120px;">
										<option value="-1">请选择宠物</option>
										<c:forEach items="${petlist}" var="pet">
											<option value="${pet.petId}">${pet.petname}
											</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
                                <label class="col-sm-4 control-label">契约照片：</label>
                                <div class="col-sm-5">
                                	<input type="file" accept="image/*" class="form-control" id="file1" name="file1">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">协议照片：</label>
                                <div class="col-sm-5">
                                	<input type="file" accept="image/*" class="form-control" id="file2" name="file2">
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
	<script type="text/javascript">
	$(function(){
		var icon = "<i class='fa fa-times-circle'></i> ";
		// 增加手机号验证规则
		$.validator.addMethod("isMobile",function(value, element) {
			var length = value.length;
			var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			return this.optional(element) || (length == 11 && mobile.test(value));
			}, icon + "请正确填写您的手机号码");
		// 身份证号码验证
		$.validator.addMethod("isIdCardNo", function(value, element) { 
		    return this.optional(element) || isIdCardNo(value);     
		}, icon + "请正确输入您的身份证号码");
		// 忽略select的隐藏
		$.validator.setDefaults({ ignore: ":hidden:not(select)" });
		// 表单提交
		$("#Form").validate({
			rules : {
				master : {
					required : true
				},
				age : {
					required : true
				},
				career : {
					required : true
				},
				tel : {
					required : true,
					minlength : 11,
					isMobile : true,
				},
				addr : {
					required : true
				},
				idcard : {
					required : true,
					isIdCardNo : true
				},
				petId : {
					min : 0
				}
			},
			messages : {
				master : {
					required : icon + "请输入领养人姓名"
				},
				age : {
					required : icon + "请输入领养人年龄"
				},
				career : {
					required : icon + "请输入领养人职业"
				},
				tel : {
					required : icon + "请输入手机号",
					minlength : icon + "不能小于11个字符",
					isMobile : icon + "请正确填写手机号码"
				},
				addr : {
					required : icon + "请输入领养人居住地址"
				},
				idcard : {
					required : icon + "请输入身份证信息"
				},
				petId : {
					min : icon + "请选择领养宠物"
				}
			},
			submitHandler : function(form){
				var form = new FormData(document.getElementById("Form"));
				$.ajax({
		            url: '${ctx}/fore/contract/add',
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
		
		$('#file1').prettyFile();
		$('#file2').prettyFile();
	});
	
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