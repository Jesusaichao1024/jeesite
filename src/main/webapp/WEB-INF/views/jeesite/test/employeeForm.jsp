<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>员工管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
                },
                messages: {
                    loginName: {remote: "用户登录名已存在"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
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
    <li><a href="${ctx}/test/testDataEmp/list">员工信息列表</a></li>
    <li class="active"><a href="${ctx}/test/testDataEmp/form?id=${user.id}">员工<shiro:hasPermission
            name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="sys:user:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="testData" action="${ctx}/user/userCode/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <%--<div class="control-group">
        <label class="control-label">头像:</label>
        <div class="controls">
            <form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
            <sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
        </div>
    </div>--%>
    <%--<div class="control-group">
        <label class="control-label">归属公司:</label>
        <div class="controls">
            <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
                title="公司" url="/sys/office/treeData?type=1" cssClass="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">归属部门:</label>
        <div class="controls">
            <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
                title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
        </div>
        //红色星号
         <span class="help-inline"><font color="red">*</font> </span>
    </div>--%>
    <div class="control-group">
        <label class="control-label">员工姓名：</label>
        <div class="controls">
            <input id="username" name="username" class="input-xlarge required" type="text" value="" maxlength="100">

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属部门:</label>
        <div class="controls">
            <input id="area" name="area" class="input-xlarge required" type="text" value="" maxlength="100">

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所在分组：</label>
        <div class="controls">
            <input id="group" name="group" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限：</label>
        <div class="controls">
            <input id="authority" name="authority" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">联系方式：</label>
        <div class="controls">
            <input id="link" name="link" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">账号：</label>
        <div class="controls">
            <input id="account" name="account" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">密码：</label>
        <div class="controls">
            <input id="pwd" name="pwd" class="input-xlarge required digits" type="text" value="" maxlength="10">
        </div>
    </div>
    <div class="control-group">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label>创建日期：</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="100"
                                   class="input-small Wdate"
                                   value="${paramMap.beginDate}"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </div>

    <%--	<div class="control-group">
            <label class="control-label">用户类型:</label>
            <div class="controls">
                <form:select path="userType" class="input-xlarge">
                    <form:option value="" label="请选择"/>
                    <form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                </form:select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">用户角色:</label>
            <div class="controls">
                <form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>--%>
    <%--	<div class="control-group">
            <label class="control-label">备注:</label>
            <div class="controls">
                <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
            </div>
        </div>
        <c:if test="${not empty user.id}">
            <div class="control-group">
                <label class="control-label">创建时间:</label>
                <div class="controls">
                    <label class="lbl"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">最后登陆:</label>
                <div class="controls">
                    <label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
                </div>
            </div>
        </c:if>--%>
    <div class="form-actions">
        <shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                         value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>