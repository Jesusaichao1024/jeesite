<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>题库资源</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#name").focus();
            $("#inputForm").validate({
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
    <li><a href="${ctx}/oa/testAudit/">题库资源</a></li>
    <li class="active"><a href="${ctx}/oa/testAudit/form?id=${testAudit.id}"><shiro:hasPermission
            name="oa:testAudit:edit">${not empty testAudit.id?'修改':'添加'}题库</shiro:hasPermission><shiro:lacksPermission
            name="oa:testAudit:edit">查看</shiro:lacksPermission></a></li>
</ul>
<form:form id="inputForm" modelAttribute="testAudit" action="${ctx}/oa/testAudit/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="act.taskId"/>
    <form:hidden path="act.taskName"/>
    <form:hidden path="act.taskDefKey"/>
    <form:hidden path="act.procInsId"/>
    <form:hidden path="act.procDefId"/>
    <form:hidden id="flag" path="act.flag"/>
    <sys:message content="${message}"/>
    <fieldset>
        <legend>题目添加</legend>
        <table class="table-form">
            <tr>
                <td class="tit">题目名称</td>
                <td
                    <%--<sys:treeselect id="user" name="user.id" value="${testAudit.user.id}" labelName="user.name" labelValue="${testAudit.user.name}"
                        title="用户" url="/sys/office/treeData?type=3" cssClass="required recipient" cssStyle="width:150px"
                        allowClear="true" notAllowSelectParent="true" smallBtn="false"/>--%>
                        colspan="3">
                    <input id="title" name="title" style="width: 98%" type="text" value maxlength="700"/>
                </td>
                <td class="tit">所属课程</td>
                <td>
                   <%-- <div class="select2-container form-control select2-container-active select2-dropdown-open"
                         id="s2id_eventField" style="width:60%;">
                      &lt;%&ndash;  <a href="javascript:void(0)" onclick="return false;" class="select2-choice" tabindex="-1">
                            <span class="select2-chosen">小学数学一年级上册（人教版）</span>
                            <abbr class="select2-search-choice-close"></abbr>
                            <span class="select2-arrow"><b></b></span>
                        </a>&ndash;%&gt;
                        <input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen1" disabled="">
                    </div>--%>
                    <select id="eventField" name="affcourses" style="width:60%;" class="form-control select2-offscreen" ng-model="eventDefinition.event" ng-change="listenerDetailsChanged()" tabindex="-1">
                        <!--
                        <option title="{{'EVENT_TYPE.ACTIVITY.COMPENSATE.TOOLTIP' | translate}}">小学数学一年级上册</option>
                        <option title="{{'EVENT_TYPE.ACTIVITY.COMPLETED.TOOLTIP' | translate}}">小学数学一年级下册</option>
                        <option title="bla">小学数学二年级上册</option>
                        -->
                        <option>小学数学一年级上册（人教版）</option>
                        <option>小学数学一年级下册（人教版）</option>
                        <option>小学数学二年级上册（人教版）</option>
                        <option>小学数学二年级下册（人教版）</option>
                        <option>小学数学三年级上册（人教版）</option>
                        <option>小学数学三年级下册（人教版）</option>
                        <option>小学数学四年级上册（人教版）</option>
                        <option>小学数学四年级下册（人教版）</option>
                        <option>小学数学五年级上册（人教版）</option>
                        <option>小学数学五年级下册（人教版）</option>
                        <option>小学数学六年级上册（人教版）</option>
                        <option>小学数学六年级下册（人教版）</option>
                        <option>小学语文一年级上册（人教版）</option>
                        <option>小学语文一年级下册（人教版）</option>
                        <option>小学语文二年级上册（人教版）</option>
                        <option>小学语文二年级下册（人教版）</option>
                        <option>小学语文三年级上册（人教版）</option>
                        <option>小学语文三年级下册（人教版）</option>
                        <option>小学语文四年级上册（人教版）</option>
                        <option>小学语文四年级下册（人教版）</option>
                        <option>小学语文五年级上册（人教版）</option>
                        <option>小学语文五年级下册（人教版）</option>
                        <option>小学语文六年级上册（人教版）</option>
                        <option>小学语文六年级下册（人教版）</option>
                        <option>小学英语三年级上册（人教版）</option>
                        <option>小学英语三年级下册（人教版）</option>
                        <option>小学英语四年级上册（人教版）</option>
                        <option>小学英语四年级下册（人教版）</option>
                        <option>小学英语五年级上册（人教版）</option>
                        <option>小学英语五年级下册（人教版）</option>
                        <option>小学英语六年级上册（人教版）</option>
                        <option>小学英语六年级下册（人教版）</option>
                        <option>七年级数学上（人教版）</option>
                        <option>七年级数学下（人教版）</option>
                        <option>八年级数学上（人教版）</option>
                        <option>八年级数学下（人教版）</option>
                        <option>九年级数学上（人教版）</option>
                        <option>九年级数学下（人教版）</option>
                        <option>七年级语文上（人教版）</option>
                        <option>七年级语文下（人教版）</option>
                        <option>八年级语文上（人教版）</option>
                        <option>八年级语文下（人教版）</option>
                        <option>九年级语文上（人教版）</option>
                        <option>九年级语文下（人教版）</option>
                        <option>七年级英语上（人教版）</option>
                        <option>七年级英语下（人教版）</option>
                        <option>八年级英语上（人教版）</option>
                        <option>八年级英语下（人教版）</option>
                        <option>九年级英语（全一册）（人教版）</option>
                        <option>八年级物理上（人教版）</option>
                        <option>八年级物理下（人教版）</option>
                        <option>九年级物理全一册（人教版）</option>
                        <option>九年级化学上（人教版）</option>
                        <option>九年级化学下（人教版）</option>
                        <option>七年级生物上（人教版）</option>
                        <option>七年级生物下（人教版）</option>
                        <option>八年级生物上（人教版）</option>
                        <option>八年级生物下（人教版）</option>
                        <option>七年级历史上（人教版）</option>
                        <option>七年级历史下（人教版）</option>
                        <option>八年级历史上（人教版）</option>
                        <option>八年级历史下（人教版）</option>
                        <option>九年级历史上（人教版）</option>
                        <option>九年级历史下（人教版）</option>
                        <option>七年级地理上（人教版）</option>
                        <option>七年级地理下（人教版）</option>
                        <option>八年级地理上（人教版）</option>
                        <option>八年级地理下（人教版）</option>
                        <option>数学A版必修1 （人教版）</option>
                        <option>数学A版必修2（人教版）</option>
                        <option>数学A版必修3（人教版）</option>
                        <option>数学A版必修4（人教版）</option>
                        <option>数学A版必修5（人教版）</option>
                        <option>数学A版选修1 -1（人教版）</option>
                        <option>数学A版选修1 -2（人教版）</option>
                        <option>数学A版选修2 -1（人教版）</option>
                        <option>数学A版选修2 -2（人教版）</option>
                        <option>数学A版选修2 -3（人教版）</option>
                        <option>数学A版选修3-1（人教版）</option>
                        <option>语文必修1（人教版）</option>
                        <option>语文必修2（人教版）</option>
                        <option>语文必修3（人教版）</option>
                        <option>语文必修4（人教版）</option>
                        <option>语文必修5（人教版）</option>
                        <option>语文必修6（人教版）</option>
                        <option>语文选修中国小说欣赏（人教版）</option>
                        <option>语文选修外国小说欣赏（人教版）</option>
                        <option>语文选修中国古代诗歌散文欣赏（人教版）</option>
                        <option>语文选修外国诗歌散文欣赏（人教版）</option>
                        <option>语文选修中外戏剧名作欣赏（人教版）</option>
                        <option>语文选修中外传记作品选读（人教版）</option>
                        <option>语文选修先秦诸子选读（人教版）</option>
                        <option>语文选修 语言文字应用（人教版）</option>
                        <option>语文选修文章写作与修改（人教版）</option>
                        <option>语文选修影视名作欣赏（人教版）</option>
                        <option>语文选修中国现代诗歌散文欣赏（人教版）</option>
                        <option>语文选修演讲与辩论（人教版）</option>
                        <option>语文选修新闻阅读与实践（人教版）</option>
                        <option>语文选修中国文化经典研读（人教版）</option>
                        <option>语文选修中国民俗文化（人教版）</option>
                        <option>高中英语必修1（人教版）</option>
                        <option>高中英语必修2（人教版）</option>
                        <option>高中英语必修3（人教版）</option>
                        <option>高中英语必修4（人教版）</option>
                        <option>高中英语必修5（人教版）</option>
                        <option>高中英语选修6（人教版）</option>
                        <option>高中英语选修7（人教版）</option>
                        <option>高中英语选修8（人教版）</option>
                        <option>物理必修1（人教版）</option>
                        <option>物理必修2（人教版）</option>
                        <option>物理选修3-1（人教版）</option>
                        <option>物理选修3-2（人教版）</option>
                        <option>物理选修3-3（人教版）</option>
                        <option>物理选修3-4（人教版）</option>
                        <option>物理选修3-5（人教版）</option>
                        <option>化学必修1（人教版）</option>
                        <option>化学必修2（人教版）</option>
                        <option>化学选修1（人教版）</option>
                        <option>化学选修2（人教版）</option>
                        <option>化学选修3（人教版）</option>
                        <option>化学选修4（人教版）</option>
                        <option>化学选修5（人教版）</option>
                        <option>化学选修6（人教版）</option>
                        <option>生物必修1（人教版）</option>
                        <option>生物必修2（人教版）</option>
                        <option>生物必修3（人教版）</option>
                        <option>生物选修1（人教版）</option>
                        <option>生物选修2（人教版）</option>
                        <option>生物选修3（人教版）</option>
                        <option>历史必修1（人教版）</option>
                        <option>历史必修2（人教版）</option>
                        <option>历史必修3（人教版）</option>
                        <option>历史选修1（人教版）</option>
                        <option>历史选修2（人教版）</option>
                        <option>历史选修3（人教版）</option>
                        <option>历史选修4（人教版）</option>
                        <option>历史选修5（人教版）</option>
                        <option>历史选修6（人教版）</option>
                        <option>地理必修1（人教版）</option>
                        <option>地理必修2（人教版）</option>
                        <option>地理必修3（人教版）</option>
                        <option>地理选修1（人教版）</option>
                        <option>地理选修2（人教版）</option>
                        <option>地理选修3（人教版）</option>
                        <option>地理选修4（人教版）</option>
                        <option>地理选修5（人教版）</option>
                        <option>地理选修6（人教版）</option>
                        <option>地理选修7（人教版）</option>





                        <!--
                        <option title="{{'EVENT_TYPE.MEMBERSHIP.CREATED.TOOLTIP' | translate}}">初中物理八年级上册</option>
                        <option title="{{'EVENT_TYPE.MEMBERSHIP.DELETED.TOOLTIP' | translate}}">初中物理八年级下册</option>
                        <option title="{{'EVENT_TYPE.MEMBERSHIPS.DELETED.TOOLTIP' | translate}}">初中物理 九年级全册</option>
                        <option title="{{'EVENT_TYPE.TASK.ASSIGNED.TOOLTIP' | translate}}">初中九年级化学上</option>
                        <option title="{{'EVENT_TYPE.TASK.COMPLETED.TOOLTIP' | translate}}">初中九年级化学下</option>
                        <option>高中数学1必修A</option>
                        <option title="{{'EVENT_TYPE.UNCAUGHT.BPMNERROR.TOOLTIP' | translate}}">高中数学2必修</option>
                        <option title="{{'EVENT_TYPE.VARIABLE.CREATED.TOOLTIP' | translate}}">高中数学3必修A</option>
                        <option title="{{'EVENT_TYPE.VARIABLE.DELETED.TOOLTIP' | translate}}">高中数学4必修A</option>
                        <option title="{{'EVENT_TYPE.VARIABLE.UPDATED.TOOLTIP' | translate}}">高中数学5必修A</option>
                         -->
                    </select>
                </td>
                    <%--<td class="tit">岗位职级</td>
                   <td>
                        <form:input path="post" htmlEscape="false" maxlength="50"/>
                    </td>--%>
            </tr>
            <tr>
                <td class="tit">题目描述</td>
                <td colspan="3">
                        <%-- <form:textarea path="content" class="required" rows="5" maxlength="200" cssStyle="width:500px"/>--%>
                    <input id="questDesc" name="questDesc" style="width: 98%" type="text" value maxlength="500"/>
                </td>
                <td class="tit">图片</td>
                <td>
                    <input id="nameImage" name="aPhoto" maxlength="255" class="input-xlarge" type="hidden" value="">
                    <ol id="nameImagePreview">
                        <li style="list-style:none;padding-top:5px;">无</li>
                    </ol>
                    <a href="javascript:" onclick="aImageFinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:"
                                                                                                   onclick="aImageDelAll();"
                                                                                                   class="btn">清除</a>
                    <script type="text/javascript">
                        function aImageFinderOpen() {//
                            var date = new Date(), year = date.getFullYear(),
                                month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
                            var url = "/static/ckfinder/ckfinder.html?type=images&start=images:/photo/" + year + "/" + month +
                                "/&action=js&func=aImageSelectAction&thumbFunc=aImageThumbSelectAction&cb=aImageCallback&dts=0&sm=0";
                            windowOpen(url, "文件管理", 1000, 700);
                            //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                        }

                        function aImageSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {//
                                url += files[i].getUrl();//
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageThumbSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {
                                url += files[i].getThumbnailUrl();
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageCallback(api) {
                            ckfinderAPI = api;
                        }

                        function aImageDel(obj) {
                            var url = $(obj).prev().attr("url");
                            $("#aImage").val($("#aImage").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
                            aImagePreview();
                        }

                        function aImageDelAll() {
                            $("#aImage").val("");
                            aImagePreview();
                        }

                        function aImagePreview() {
                            var li, urls = $("#aImage").val().split("|");
                            $("#aImagePreview").children().remove();
                            for (var i = 0; i < urls.length; i++) {
                                if (urls[i] != "") {//
                                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:100px;max-height:60px;_height:60px;border:0;padding:3px;\">";//
                                    li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"aImageDel(this);\">×</a></li>";
                                    $("#aImagePreview").append(li);
                                }
                            }
                            if ($("#aImagePreview").text() == "") {
                                $("#aImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                            }
                        }

                        aImagePreview();
                    </script>
                </td>
            </tr>
            <tr>
                <td class="tit">答案选项A</td>
                <td colspan="3">
                    <input id="quesA" name="quesA" style="width:98%;" type="text" value="" maxlength="700">
                </td>
                <td class="tit">图片</td>

                <td>
                    <input id="aImage" name="aPhoto" maxlength="255" class="input-xlarge" type="hidden" value="">
                    <ol id="aImagePreview">
                        <li style="list-style:none;padding-top:5px;">无</li>
                    </ol>
                    <a href="javascript:" onclick="aImageFinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:"
                                                                                                   onclick="aImageDelAll();"
                                                                                                   class="btn">清除</a>
                    <script type="text/javascript">
                        function aImageFinderOpen() {//
                            var date = new Date(), year = date.getFullYear(),
                                month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
                            var url = "/static/ckfinder/ckfinder.html?type=images&start=images:/photo/" + year + "/" + month +
                                "/&action=js&func=aImageSelectAction&thumbFunc=aImageThumbSelectAction&cb=aImageCallback&dts=0&sm=0";
                            windowOpen(url, "文件管理", 1000, 700);
                            //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                        }

                        function aImageSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {//
                                url += files[i].getUrl();//
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageThumbSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {
                                url += files[i].getThumbnailUrl();
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageCallback(api) {
                            ckfinderAPI = api;
                        }

                        function aImageDel(obj) {
                            var url = $(obj).prev().attr("url");
                            $("#aImage").val($("#aImage").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
                            aImagePreview();
                        }

                        function aImageDelAll() {
                            $("#aImage").val("");
                            aImagePreview();
                        }

                        function aImagePreview() {
                            var li, urls = $("#aImage").val().split("|");
                            $("#aImagePreview").children().remove();
                            for (var i = 0; i < urls.length; i++) {
                                if (urls[i] != "") {//
                                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:100px;max-height:60px;_height:60px;border:0;padding:3px;\">";//
                                    li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"aImageDel(this);\">×</a></li>";
                                    $("#aImagePreview").append(li);
                                }
                            }
                            if ($("#aImagePreview").text() == "") {
                                $("#aImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                            }
                        }

                        aImagePreview();
                    </script>
                </td>
            </tr>
            <tr>
                <td class="tit">答案选项B</td>
                <td colspan="3">
                    <input id="quesB" name="quesA" style="width:98%;" type="text" value="" maxlength="700">
                </td>
                <td class="tit">图片</td>

                <td>
                    <input id="bImage" name="aPhoto" maxlength="255" class="input-xlarge" type="hidden" value="">
                    <ol id="bImagePreview">
                        <li style="list-style:none;padding-top:5px;">无</li>
                    </ol>
                    <a href="javascript:" onclick="aImageFinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:"
                                                                                                   onclick="aImageDelAll();"
                                                                                                   class="btn">清除</a>
                    <script type="text/javascript">
                        function aImageFinderOpen() {//
                            var date = new Date(), year = date.getFullYear(),
                                month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
                            var url = "/static/ckfinder/ckfinder.html?type=images&start=images:/photo/" + year + "/" + month +
                                "/&action=js&func=aImageSelectAction&thumbFunc=aImageThumbSelectAction&cb=aImageCallback&dts=0&sm=0";
                            windowOpen(url, "文件管理", 1000, 700);
                            //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                        }

                        function aImageSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {//
                                url += files[i].getUrl();//
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageThumbSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {
                                url += files[i].getThumbnailUrl();
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageCallback(api) {
                            ckfinderAPI = api;
                        }

                        function aImageDel(obj) {
                            var url = $(obj).prev().attr("url");
                            $("#aImage").val($("#aImage").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
                            aImagePreview();
                        }

                        function aImageDelAll() {
                            $("#aImage").val("");
                            aImagePreview();
                        }

                        function aImagePreview() {
                            var li, urls = $("#aImage").val().split("|");
                            $("#aImagePreview").children().remove();
                            for (var i = 0; i < urls.length; i++) {
                                if (urls[i] != "") {//
                                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:100px;max-height:60px;_height:60px;border:0;padding:3px;\">";//
                                    li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"aImageDel(this);\">×</a></li>";
                                    $("#aImagePreview").append(li);
                                }
                            }
                            if ($("#aImagePreview").text() == "") {
                                $("#aImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                            }
                        }

                        aImagePreview();
                    </script>
                </td>
            </tr>
            <tr>
                <td class="tit">答案选项C</td>
                <td colspan="3">
                    <input id="quesC" name="quesA" style="width:98%;" type="text" value="" maxlength="700">
                </td>
                <td class="tit">图片</td>

                <td>
                    <input id="cImage" name="aPhoto" maxlength="255" class="input-xlarge" type="hidden" value="">
                    <ol id="cImagePreview">
                        <li style="list-style:none;padding-top:5px;">无</li>
                    </ol>
                    <a href="javascript:" onclick="aImageFinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:"
                                                                                                   onclick="aImageDelAll();"
                                                                                                   class="btn">清除</a>
                    <script type="text/javascript">
                        function aImageFinderOpen() {//
                            var date = new Date(), year = date.getFullYear(),
                                month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
                            var url = "/static/ckfinder/ckfinder.html?type=images&start=images:/photo/" + year + "/" + month +
                                "/&action=js&func=aImageSelectAction&thumbFunc=aImageThumbSelectAction&cb=aImageCallback&dts=0&sm=0";
                            windowOpen(url, "文件管理", 1000, 700);
                            //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                        }

                        function aImageSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {//
                                url += files[i].getUrl();//
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageThumbSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {
                                url += files[i].getThumbnailUrl();
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageCallback(api) {
                            ckfinderAPI = api;
                        }

                        function aImageDel(obj) {
                            var url = $(obj).prev().attr("url");
                            $("#aImage").val($("#aImage").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
                            aImagePreview();
                        }

                        function aImageDelAll() {
                            $("#aImage").val("");
                            aImagePreview();
                        }

                        function aImagePreview() {
                            var li, urls = $("#aImage").val().split("|");
                            $("#aImagePreview").children().remove();
                            for (var i = 0; i < urls.length; i++) {
                                if (urls[i] != "") {//
                                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:100px;max-height:60px;_height:60px;border:0;padding:3px;\">";//
                                    li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"aImageDel(this);\">×</a></li>";
                                    $("#aImagePreview").append(li);
                                }
                            }
                            if ($("#aImagePreview").text() == "") {
                                $("#aImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                            }
                        }

                        aImagePreview();
                    </script>
                </td>
            </tr>
            <tr>
                <td class="tit">答案选项D</td>
                <td colspan="3">
                    <input id="quesD" name="quesA" style="width:98%;" type="text" value="" maxlength="700">
                </td>
                <td class="tit">图片</td>

                <td>
                    <input id="dImage" name="aPhoto" maxlength="255" class="input-xlarge" type="hidden" value="">
                    <ol id="dImagePreview">
                        <li style="list-style:none;padding-top:5px;">无</li>
                    </ol>
                    <a href="javascript:" onclick="aImageFinderOpen();" class="btn">选择</a>&nbsp;<a href="javascript:"
                                                                                                   onclick="aImageDelAll();"
                                                                                                   class="btn">清除</a>
                    <script type="text/javascript">
                        function aImageFinderOpen() {//
                            var date = new Date(), year = date.getFullYear(),
                                month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
                            var url = "/static/ckfinder/ckfinder.html?type=images&start=images:/photo/" + year + "/" + month +
                                "/&action=js&func=aImageSelectAction&thumbFunc=aImageThumbSelectAction&cb=aImageCallback&dts=0&sm=0";
                            windowOpen(url, "文件管理", 1000, 700);
                            //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
                        }

                        function aImageSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {//
                                url += files[i].getUrl();//
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageThumbSelectAction(fileUrl, data, allFiles) {
                            var url = "", files = ckfinderAPI.getSelectedFiles();
                            for (var i = 0; i < files.length; i++) {
                                url += files[i].getThumbnailUrl();
                                if (i < files.length - 1) url += "|";
                            }//
                            $("#aImage").val(url);//
                            aImagePreview();
                            //top.$.jBox.close();
                        }

                        function aImageCallback(api) {
                            ckfinderAPI = api;
                        }

                        function aImageDel(obj) {
                            var url = $(obj).prev().attr("url");
                            $("#aImage").val($("#aImage").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
                            aImagePreview();
                        }

                        function aImageDelAll() {
                            $("#aImage").val("");
                            aImagePreview();
                        }

                        function aImagePreview() {
                            var li, urls = $("#aImage").val().split("|");
                            $("#aImagePreview").children().remove();
                            for (var i = 0; i < urls.length; i++) {
                                if (urls[i] != "") {//
                                    li = "<li><img src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:100px;max-height:60px;_height:60px;border:0;padding:3px;\">";//
                                    li += "&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"aImageDel(this);\">×</a></li>";
                                    $("#aImagePreview").append(li);
                                }
                            }
                            if ($("#aImagePreview").text() == "") {
                                $("#aImagePreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
                            }
                        }

                        aImagePreview();
                    </script>
                </td>
            </tr>
            <tr>
                <td class="tit">标准答案</td>
                <td colspan="5">
                    <input id="correctanswer" name="correctanswer" style="width:8%;" type="text" value=""
                           maxlength="700">
                </td>
            </tr>


        </table>
    </fieldset>
    <div class="form-actions">
        <shiro:hasPermission name="oa:testAudit:edit">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" onclick="$('#flag').val('yes')"/>&nbsp;
            <%--	<c:if test="${not empty testAudit.id}">
                    <input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
                </c:if>--%>
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
    <c:if test="${not empty testAudit.id}">
        <act:histoicFlow procInsId="${testAudit.act.procInsId}"/>
    </c:if>
</form:form>
</body>
</html>
