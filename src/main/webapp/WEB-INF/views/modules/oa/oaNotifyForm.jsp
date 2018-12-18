<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oa/oaNotify/">资源列表</a></li>
		<li class="active"><a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}"><shiro:hasPermission name="oa:oaNotify:edit">${oaNotify.status eq '1' ? '查看' : not empty oaNotify.id ? '修改' : ''}</shiro:hasPermission>上传资源<shiro:lacksPermission name="oa:oaNotify:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序号：</label>
			<div class="controls">
				<input id="sortNum" name="sortNum" class="input-xlarge required" type="text" value="0" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">作者：</label>
			<div class="controls">
				<input id="authority" name="authority" class="input-xlarge required" type="text" value="" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">版本号：</label>
			<div class="controls">
				<input id="version" name="version" class="input-xlarge required" type="text" value="" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资源包名：</label>
			<div class="controls">
				<input id="rspackname" name="rspackname" class="input-xlarge required" type="text" value="" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资源类型：</label>
			<div class="controls">
				<input id="rspacksort" name="rspacksort" class="input-xlarge required" type="text" value="" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">科目：</label>
			<div class="controls">
				<input id="subject" name="subject" class="input-xlarge required" type="text" value="" maxlength="200">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<textarea id="content" name="content" maxlength="2000" class="input-xxlarge required" rows="6"></textarea>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<input id="files" name="files" maxlength="255" class="input-xlarge" type="hidden" value="">
				<ol id="filesPreview"><li style="list-style:none;padding-top:5px;">无</li></ol><a href="javascript:" onclick="filesFinderOpen();" class="btn">添加</a>&nbsp;<a href="javascript:" onclick="filesDelAll();" class="btn">清除</a>
				<script type="text/javascript">
                    function filesFinderOpen(){//
                        var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
                        var url = "/static/ckfinder/ckfinder.html?type=files&start=files:/oa/notify/"+year+"/"+month+
                            "/&action=js&func=filesSelectAction&thumbFunc=filesThumbSelectAction&cb=filesCallback&dts=0&sm=1";
                        windowOpen(url,"文件管理",1000,700);
                        //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                    }
                    function filesSelectAction(fileUrl, data, allFiles){
                        var url="", files=ckfinderAPI.getSelectedFiles();
                        for(var i=0; i<files.length; i++){//
                            url += files[i].getUrl();//
                            if (i<files.length-1) url+="|";
                        }//
                        $("#files").val($("#files").val()+($("#files").val(url)==""?url:"|"+url));//
                        filesPreview();
                        //top.$.jBox.close();
                    }
                    function filesThumbSelectAction(fileUrl, data, allFiles){
                        var url="", files=ckfinderAPI.getSelectedFiles();
                        for(var i=0; i<files.length; i++){
                            url += files[i].getThumbnailUrl();
                            if (i<files.length-1) url+="|";
                        }//
                        $("#files").val($("#files").val()+($("#files").val(url)==""?url:"|"+url));//
                        filesPreview();
                        //top.$.jBox.close();
                    }
                    function filesCallback(api){
                        ckfinderAPI = api;
                    }
                    function filesDel(obj){
                        var url = $(obj).prev().attr("url");
                        $("#files").val($("#files").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
                        filesPreview();
                    }
                    function filesDelAll(){
                        $("#files").val("");
                        filesPreview();
                    }
                    function filesPreview(){
                        var li, urls = $("#files").val().split("|");
                        $("#filesPreview").children().remove();
                        for (var i=0; i<urls.length; i++){
                            if (urls[i]!=""){//
                                li = "<li><a href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//
                                li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"filesDel(this);\">×</a></li>";
                                $("#filesPreview").append(li);
                            }
                        }
                        if ($("#filesPreview").text() == ""){
                            $("#filesPreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                        }
                    }
                    filesPreview();
				</script>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<span><input id="status1" name="status" class="required" type="radio" value="0"><label for="status1">草稿</label></span><span><input id="status2" name="status" class="required" type="radio" value="1"><label for="status2">发布</label></span>
				<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
			</div>
		</div>
	<%--	<c:if test="${oaNotify.status ne '1'}">
			<div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">接受人：</label>
				<div class="controls">
	                <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</c:if>
		<c:if test="${oaNotify.status eq '1'}">
			<div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" readonly="true" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">接受人：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>接受人</th>
								<th>接受部门</th>
								<th>阅读状态</th>
								<th>阅读时间</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
							<tr>
								<td>
									${oaNotifyRecord.user.name}
								</td>
								<td>
									${oaNotifyRecord.user.office.name}
								</td>
								<td>
									${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
								</td>
								<td>
									<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp; 总共：${oaNotify.readNum + oaNotify.unReadNum}
				</div>
			</div>
		</c:if>--%>
		<div class="form-actions">
			<c:if test="${oaNotify.status ne '1'}">
				<shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>