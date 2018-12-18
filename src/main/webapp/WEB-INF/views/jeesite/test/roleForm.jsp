<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>单表管理</title>
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
    <li><a href="${ctx}/test/testData/">权限列表</a></li>
    <li class="active"><a href="${ctx}/test/testData/form?id=${testData.id}">权限<shiro:hasPermission name="test:testData:edit">${not empty testData.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="test:testData:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">权限ID：</label>
        <div class="controls">
            <input id="roleId" name="roleId" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限名称：</label>
        <div class="controls">
            <input id="roleName" name="roleName" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限范围：</label>
        <div class="controls">
            <input id="roleArea" name="roleArea" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注信息：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="test:testData:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>