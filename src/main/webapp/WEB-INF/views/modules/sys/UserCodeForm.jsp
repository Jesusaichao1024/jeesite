<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户管理</title>
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
    <li><a href="${ctx}/user/userCode/list">激活码列表</a></li>
    <li class="active"><a href="${ctx}/user/userCode/form?id=${user.id}">激活码<shiro:hasPermission
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
        <label class="control-label">用户名：</label>
        <div class="controls">
            <input id="username" name="username" class="input-xlarge required" type="text" value="" maxlength="100">

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">所属区域:</label>
        <div class="controls">
            <input id="area" name="area" class="input-xlarge required" type="text" value="" maxlength="100">

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">省份：</label>
        <div class="controls">
            <input id="province" name="province" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">市区：</label>
        <div class="controls">
            <input id="city" name="city" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">学校级别：</label>
        <div class="controls">
            <input id="schoolLevel" name="schoolLevel" class="input-xlarge required" type="text" value=""
                   maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">学校名称：</label>
        <div class="controls">
            <input id="schoolName" name="schoolName" class="input-xlarge required" type="text" value=""
                   maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限ID：</label>
        <div class="controls">
            <input id="authorityID" name="authorityID" class="input-xlarge required" type="text" value=""
                   maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限名称：</label>
        <div class="controls">
            <input id="authorityName" name="authorityName" class="input-xlarge required" type="text" value=""
                   maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PICO数量：</label>
        <div class="controls">
            <input id="piconum" name="piconum" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">PAD数量：</label>
        <div class="controls">
            <input id="padnum" name="padnum" class="input-xlarge required" type="text" value="" maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">机器码：</label>
        <div class="controls">
            <input id="machineCode" name="machineCode" class="input-xlarge required" type="text" value=""
                   maxlength="100">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">激活码：</label>
        <div class="controls">
            <input id="activeCode" name="activeCode" class="input-xlarge required" type="text" value=""
                   maxlength="100">
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
        <label>加入日期：</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="100"
                                   class="input-small Wdate"
                                   value="${paramMap.beginDate}"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
    </div>

    <div class="control-group">
        <label class="control-label">备注信息：</label>
        <div class="controls">
            <textarea id="remarks" name="remarks" maxlength="255" class="input-xxlarge " rows="4"></textarea>
        </div>
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