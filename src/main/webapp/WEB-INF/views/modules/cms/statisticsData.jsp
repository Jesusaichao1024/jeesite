<%--
  Created by IntelliJ IDEA.
  User: hhh
  Date: 2018/12/13
  Time: 13:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>统计数据</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function autoRowSpan(tb, row, col) {
            var lastValue = "", value = "", pos = 1;
            for (var i = row; i < tb.rows.length; i++) {
                value = tb.rows[i].cells[col].innerText;
                if (lastValue == value) {
                    tb.rows[i].deleteCell(col);
                    tb.rows[i - pos].cells[col].rowSpan = tb.rows[i - pos].cells[col].rowSpan + 1;
                    pos++;
                } else {
                    lastValue = value;
                    pos = 1;
                }
            }
        }

        $(document).ready(function () {
            autoRowSpan(contentTable, 0, 0);
            $("td,th").css({"text-align": "center", "vertical-align": "middle"});
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/cms/stats/article"></a></li>
</ul>
<form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/stats/article" method="post"
           class="breadcrumb form-search">
    <div>
            <%--<label>归属栏目：</label><sys:treeselect id="category" name="categoryId" value="${paramMap.id}" labelName="categoryName" labelValue="${paramMap.name}"
                title="栏目" url="/cms/category/treeData" module="article" cssClass="input-small" allowClear="true"/>
            <label>归属机构：</label><sys:treeselect id="office" name="officeId" value="${paramMap.office.id}" labelName="officeName" labelValue="${paramMap.office.name}"
                title="机构" url="/sys/office/treeData" cssClass="input-small" allowClear="true"/>--%>
        <label>起始日期：</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20"
                                   class="input-small Wdate"
                                   value="${paramMap.beginDate}"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
        <label>截止日期：</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20"
                                   class="input-small Wdate"
                                   value="${paramMap.endDate}"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="确认"/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label class="control-label">省份</label>
        <select class="input-mini">
            <option value="默认">默认</option>
        </select>

        <label class="control-label">学校</label>
        <select class="input-mini">
            <option value="默认">默认</option>
        </select>

        &nbsp;&nbsp;&nbsp;&nbsp;
        <label class="control-label">年级</label>
        <select class="input-mini">
            <option value="默认">默认</option>
        </select>
    </div>
</form:form>
<ul class="nav nav-tabs">
    <li>
        <%--课程数量--%>
        <input id="btnCourse" class="btn btn-primary" type="submit" value="课程数量">
    </li>
    <%--焦点信息--%>
    <input id="btnFocus" class="btn btn-primary" type="submit" value="焦点信息">
    </li>
    <li>
        <%--客户端启动次数--%>
        <input id="btnStartCount" class="btn btn-primary" type="submit" value="客户端启动次数">
    </li>
    <li>
        <%--答题正确率--%>
        <input id="btnAnswer" class="btn btn-primary" type="submit" value="答题正确率">
    </li>
</ul>
<%--<div id="container" style="min-width:400px;height:400px">
    <script type="text/javascript">
        var chart = null;
        // 获取 CSV 数据并初始化图表
        $.getJSON('https://data.jianshukeji.com/jsonp?filename=csv/analytics.csv&callback=?', function (csv) {
            chart = Highcharts.chart('container', {
                data: {
                    csv: csv
                },
                title: {
                    text: '铭孜教育日常访问量'
                },
                subtitle: {
                    text: '数据来源: 北京铭孜教育'
                },
                xAxis: {
                    tickInterval: 7 * 24 * 3600 * 1000, // 坐标轴刻度间隔为一星期
                    tickWidth: 0,
                    gridLineWidth: 1,
                    labels: {
                        align: 'left',
                        x: 3,
                        y: -3
                    },
                    // 时间格式化字符
                    // 默认会根据当前的刻度间隔取对应的值，即当刻度间隔为一周时，取 week 值
                    dateTimeLabelFormats: {
                        week: '%Y-%m-%d'
                    }
                },
                yAxis: [{ // 第一个 Y 轴，放置在左边（默认在坐标）
                    title: {
                        text: null
                    },
                    labels: {
                        align: 'left',
                        x: 3,
                        y: 16,
                        format: '{value:.,0f}'
                    },
                    showFirstLabel: false
                }, {    // 第二个坐标轴，放置在右边
                    linkedTo: 0,
                    gridLineWidth: 0,
                    opposite: true,  // 通过此参数设置坐标轴显示在对立面
                    title: {
                        text: null
                    },
                    labels: {
                        align: 'right',
                        x: -3,
                        y: 16,
                        format: '{value:.,0f}'
                    },
                    showFirstLabel: false
                }],
                legend: {
                    align: 'left',
                    verticalAlign: 'top',
                    y: 20,
                    floating: true,
                    borderWidth: 0
                },
                tooltip: {
                    shared: true,
                    crosshairs: true,
                    // 时间格式化字符
                    // 默认会根据当前的数据点间隔取对应的值
                    // 当前图表中数据点间隔为 1天，所以配置 day 值即可
                    dateTimeLabelFormats: {
                        day: '%Y-%m-%d'
                    }
                },
                plotOptions: {
                    series: {
                        cursor: 'pointer',
                        point: {
                            events: {
                                // 数据点点击事件
                                // 其中 e 变量为事件对象，this 为当前数据点对象
                                click: function (e) {
                                    $('.message').html( Highcharts.dateFormat('%Y-%m-%d', this.x) + ':<br/>  访问量：' +this.y );
                                }
                            }
                        },
                        marker: {
                            lineWidth: 1
                        }
                    }
                }
            });
        });
    </script>
</div>--%>

<div class="pagination">${page}</div>
<div id="container" style="min-width:400px;height:400px" data-highcharts-chart="0">
    <div id="highcharts-di55zly-0" dir="ltr" class="highcharts-container "
         style="position: relative; overflow: hidden; width: 885px; height: 400px; text-align: left; line-height: normal; z-index: 0; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); font-family: Dosis, sans-serif;">
        <svg version="1.1" class="highcharts-root " style="font-family:Dosis, sans-serif;font-size:12px;"
             xmlns="http://www.w3.org/2000/svg" width="885" height="400" viewBox="0 0 885 400">
            <desc>Created with Highcharts 6.1.4</desc>
            <defs>
                <clipPath id="highcharts-di55zly-1">
                    <rect x="0" y="0" width="865" height="322" fill="none"></rect>
                </clipPath>
            </defs>
            <rect fill="none" class="highcharts-background" x="0" y="0" width="885" height="400" rx="0" ry="0"></rect>
            <rect fill="none" class="highcharts-plot-background" x="10" y="62" width="865" height="322"></rect>
            <g class="highcharts-grid highcharts-xaxis-grid " data-z-index="1">
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 74.5 62 L 74.5 384" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 272.5 62 L 272.5 384" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 470.5 62 L 470.5 384" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 668.5 62 L 668.5 384" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 866.5 62 L 866.5 384" opacity="1"></path>
            </g>
            <g class="highcharts-grid highcharts-yaxis-grid " data-z-index="1">
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 384.5 L 875 384.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 368.5 L 875 368.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 352.5 L 875 352.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 336.5 L 875 336.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 320.5 L 875 320.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 304.5 L 875 304.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 287.5 L 875 287.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 271.5 L 875 271.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 255.5 L 875 255.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 239.5 L 875 239.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 223.5 L 875 223.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 207.5 L 875 207.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 191.5 L 875 191.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 175.5 L 875 175.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 159.5 L 875 159.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 143.5 L 875 143.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 126.5 L 875 126.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 110.5 L 875 110.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 94.5 L 875 94.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 78.5 L 875 78.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 61.5 L 875 61.5" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 10 384.5 L 875 384.5" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 10 304.5 L 875 304.5" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 10 223.5 L 875 223.5" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 10 143.5 L 875 143.5" opacity="1"></path>
                <path fill="none" stroke="#e6e6e6" stroke-width="1" data-z-index="1" class="highcharts-grid-line"
                      d="M 10 61.5 L 875 61.5" opacity="1"></path>
            </g>
            <g class="highcharts-grid highcharts-yaxis-grid " data-z-index="1">
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 384.5 L 875 384.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 368.5 L 875 368.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 352.5 L 875 352.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 336.5 L 875 336.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 320.5 L 875 320.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 304.5 L 875 304.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 287.5 L 875 287.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 271.5 L 875 271.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 255.5 L 875 255.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 239.5 L 875 239.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 223.5 L 875 223.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 207.5 L 875 207.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 191.5 L 875 191.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 175.5 L 875 175.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 159.5 L 875 159.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 143.5 L 875 143.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 126.5 L 875 126.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 110.5 L 875 110.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 94.5 L 875 94.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 78.5 L 875 78.5" opacity="1"></path>
                <path fill="none" stroke="#f2f2f2" stroke-width="1" class="highcharts-minor-grid-line"
                      d="M 10 61.5 L 875 61.5" opacity="1"></path>
                <path fill="none" data-z-index="1" class="highcharts-grid-line" d="M 10 384.5 L 875 384.5"
                      opacity="1"></path>
                <path fill="none" data-z-index="1" class="highcharts-grid-line" d="M 10 304.5 L 875 304.5"
                      opacity="1"></path>
                <path fill="none" data-z-index="1" class="highcharts-grid-line" d="M 10 223.5 L 875 223.5"
                      opacity="1"></path>
                <path fill="none" data-z-index="1" class="highcharts-grid-line" d="M 10 143.5 L 875 143.5"
                      opacity="1"></path>
                <path fill="none" data-z-index="1" class="highcharts-grid-line" d="M 10 62.5 L 875 62.5"
                      opacity="1"></path>
            </g>
            <rect fill="none" class="highcharts-plot-border" data-z-index="1" x="10" y="62" width="865"
                  height="322"></rect>
            <g class="highcharts-axis highcharts-xaxis " data-z-index="2">
                <path fill="none" class="highcharts-axis-line" stroke="#ccd6eb" stroke-width="1" data-z-index="7"
                      d="M 10 384.5 L 875 384.5"></path>
            </g>
            <g class="highcharts-axis highcharts-yaxis " data-z-index="2">
                <path fill="none" class="highcharts-axis-line" data-z-index="7" d="M 10 62 L 10 384"></path>
            </g>
            <g class="highcharts-axis highcharts-yaxis " data-z-index="2">
                <path fill="none" class="highcharts-axis-line" data-z-index="7" d="M 875 62 L 875 384"></path>
            </g>
            <path fill="none" class="highcharts-crosshair highcharts-crosshair-thin undefined" data-z-index="2"
                  stroke="#cccccc" stroke-width="1" style="pointer-events:none;" visibility="visible"
                  d="M 866.5 62 L 866.5 384"></path>
            <g class="highcharts-series-group" data-z-index="3">
                <g data-z-index="0.1"
                   class="highcharts-series highcharts-series-0 highcharts-line-series highcharts-color-0 "
                   transform="translate(10,62) scale(1 1)" clip-path="url(#highcharts-di55zly-1)">
                    <path fill="none"
                          d="M 8.4803921568627 230.3749 L 36.748366013072 235.01170000000002 L 65.016339869281 71.2586 L 93.28431372549 61.00290000000001 L 121.5522875817 57.525300000000016 L 149.82026143791 56.5754 L 178.08823529412 84.73429999999999 L 206.35620915033 228.0082 L 234.62418300654 232.7738 L 262.89215686275 71.48400000000001 L 291.16013071895 17.06600000000003 L 319.42810457516 48.783000000000015 L 347.69607843137 38.96199999999999 L 375.96405228758 40.072900000000004 L 404.23202614379 215.72390000000001 L 432.5 222.8562 L 460.76797385621 42.61669999999998 L 489.03594771242 37.67399999999998 L 517.30392156863 49.57190000000003 L 545.57189542484 64.9796 L 573.83986928105 128.3492 L 602.10784313725 228.0565 L 630.37581699346 244.73610000000002 L 658.64379084967 112.1043 L 686.91176470588 48.68639999999999 L 715.17973856209 46.69 L 743.4477124183 69.2139 L 771.71568627451 90.51420000000002 L 799.98366013072 227.1871 L 828.25163398693 212.8581 L 856.51960784314 63.30520000000001"
                          class="highcharts-graph" data-z-index="1" stroke="#7cb5ec" stroke-width="2"
                          stroke-linejoin="round" stroke-linecap="round"></path>
                    <path fill="none"
                          d="M -1.5196078431372992 230.3749 L 8.4803921568627 230.3749 L 36.748366013072 235.01170000000002 L 65.016339869281 71.2586 L 93.28431372549 61.00290000000001 L 121.5522875817 57.525300000000016 L 149.82026143791 56.5754 L 178.08823529412 84.73429999999999 L 206.35620915033 228.0082 L 234.62418300654 232.7738 L 262.89215686275 71.48400000000001 L 291.16013071895 17.06600000000003 L 319.42810457516 48.783000000000015 L 347.69607843137 38.96199999999999 L 375.96405228758 40.072900000000004 L 404.23202614379 215.72390000000001 L 432.5 222.8562 L 460.76797385621 42.61669999999998 L 489.03594771242 37.67399999999998 L 517.30392156863 49.57190000000003 L 545.57189542484 64.9796 L 573.83986928105 128.3492 L 602.10784313725 228.0565 L 630.37581699346 244.73610000000002 L 658.64379084967 112.1043 L 686.91176470588 48.68639999999999 L 715.17973856209 46.69 L 743.4477124183 69.2139 L 771.71568627451 90.51420000000002 L 799.98366013072 227.1871 L 828.25163398693 212.8581 L 856.51960784314 63.30520000000001 L 866.51960784314 63.30520000000001"
                          stroke-linejoin="round" stroke="rgba(192,192,192,0.0001)" stroke-width="22"
                          visibility="visible" data-z-index="2" class="highcharts-tracker-line"
                          style="cursor:pointer;"></path>
                </g>
                <g data-z-index="0.1"
                   class="highcharts-markers highcharts-series-0 highcharts-line-series highcharts-color-0 highcharts-tracker "
                   transform="translate(10,62) scale(1 1)" style="cursor:pointer;">
                    <path fill="#7cb5ec" visibility="visible"
                          d="M 866 63.30520000000001 A 10 10 0 1 1 865.9999950000005 63.29520000166667 Z"
                          class="highcharts-halo highcharts-color-0" data-z-index="-1" fill-opacity="0.25"></path>
                    <path fill="#7cb5ec" d="M 12 230.3749 A 4 4 0 1 1 11.999998000000167 230.37090000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 40 235.01170000000002 A 4 4 0 1 1 39.99999800000017 235.0077000006667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 69 71.2586 A 4 4 0 1 1 68.99999800000016 71.25460000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 97 61.00290000000001 A 4 4 0 1 1 96.99999800000016 60.99890000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 125 57.525300000000016 A 4 4 0 1 1 124.99999800000016 57.52130000066668 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 153 56.5754 A 4 4 0 1 1 152.99999800000018 56.571400000666664 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 182 84.73429999999999 A 4 4 0 1 1 181.99999800000018 84.73030000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 210 228.0082 A 4 4 0 1 1 209.99999800000018 228.00420000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 238 232.7738 A 4 4 0 1 1 237.99999800000018 232.76980000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 266 71.48400000000001 A 4 4 0 1 1 265.9999980000002 71.48000000066668 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 295 17.06600000000003 A 4 4 0 1 1 294.9999980000002 17.062000000666696 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 323 48.783000000000015 A 4 4 0 1 1 322.9999980000002 48.77900000066668 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 351 38.96199999999999 A 4 4 0 1 1 350.9999980000002 38.95800000066665 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 379 40.072900000000004 A 4 4 0 1 1 378.9999980000002 40.068900000666666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 408 215.72390000000001 A 4 4 0 1 1 407.9999980000002 215.71990000066668 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 436 222.8562 A 4 4 0 1 1 435.9999980000002 222.85220000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 464 42.61669999999998 A 4 4 0 1 1 463.9999980000002 42.61270000066664 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 493 37.67399999999998 A 4 4 0 1 1 492.9999980000002 37.67000000066664 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 521 49.57190000000003 A 4 4 0 1 1 520.9999980000001 49.56790000066669 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 549 64.9796 A 4 4 0 1 1 548.9999980000001 64.97560000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 577 128.3492 A 4 4 0 1 1 576.9999980000001 128.34520000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 606 228.0565 A 4 4 0 1 1 605.9999980000001 228.05250000066667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 634 244.73610000000002 A 4 4 0 1 1 633.9999980000001 244.7321000006667 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 662 112.1043 A 4 4 0 1 1 661.9999980000001 112.10030000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 690 48.68639999999999 A 4 4 0 1 1 689.9999980000001 48.682400000666654 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 719 46.69 A 4 4 0 1 1 718.9999980000001 46.68600000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 747 69.2139 A 4 4 0 1 1 746.9999980000001 69.20990000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 775 90.51420000000002 A 4 4 0 1 1 774.9999980000001 90.51020000066669 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 803 227.1871 A 4 4 0 1 1 802.9999980000001 227.18310000066666 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 832 212.8581 A 4 4 0 1 1 831.9999980000001 212.85410000066668 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-0 "></path>
                    <path fill="#7cb5ec" d="M 862 63.30520000000001 A 6 6 0 1 1 861.9999970000002 63.29920000100001 Z"
                          stroke="#ffffff" stroke-width="2"
                          class="highcharts-point highcharts-color-0 highcharts-point-hover"></path>
                </g>
                <g data-z-index="0.1"
                   class="highcharts-series highcharts-series-1 highcharts-line-series highcharts-color-1 highcharts-series-hover"
                   transform="translate(10,62) scale(1 1)" clip-path="url(#highcharts-di55zly-1)">
                    <path fill="none"
                          d="M 8.4803921568627 252.0294 L 36.748366013072 255.79680000000002 L 65.016339869281 139.1684 L 93.28431372549 130.7964 L 121.5522875817 129.3474 L 149.82026143791 127.4154 L 178.08823529412 146.2524 L 206.35620915033 249.4373 L 234.62418300654 254.3478 L 262.89215686275 136.4797 L 291.16013071895 89.6609 L 319.42810457516 119.15610000000001 L 347.69607843137 111.1866 L 375.96405228758 108.93260000000001 L 404.23202614379 238.0707 L 432.5 244.6234 L 460.76797385621 118.5121 L 489.03594771242 116.43520000000001 L 517.30392156863 122.53710000000001 L 545.57189542484 133.8554 L 573.83986928105 178.85490000000001 L 602.10784313725 249.3407 L 630.37581699346 263.0579 L 658.64379084967 169.0017 L 686.91176470588 118.07740000000001 L 715.17973856209 118.57650000000001 L 743.4477124183 138.5566 L 771.71568627451 152.467 L 799.98366013072 249.2119 L 828.25163398693 239.7451 L 856.51960784314 135.2561"
                          class="highcharts-graph" data-z-index="1" stroke="#f7a35c" stroke-width="3"
                          stroke-linejoin="round" stroke-linecap="round"></path>
                    <path fill="none"
                          d="M -1.5196078431372992 252.0294 L 8.4803921568627 252.0294 L 36.748366013072 255.79680000000002 L 65.016339869281 139.1684 L 93.28431372549 130.7964 L 121.5522875817 129.3474 L 149.82026143791 127.4154 L 178.08823529412 146.2524 L 206.35620915033 249.4373 L 234.62418300654 254.3478 L 262.89215686275 136.4797 L 291.16013071895 89.6609 L 319.42810457516 119.15610000000001 L 347.69607843137 111.1866 L 375.96405228758 108.93260000000001 L 404.23202614379 238.0707 L 432.5 244.6234 L 460.76797385621 118.5121 L 489.03594771242 116.43520000000001 L 517.30392156863 122.53710000000001 L 545.57189542484 133.8554 L 573.83986928105 178.85490000000001 L 602.10784313725 249.3407 L 630.37581699346 263.0579 L 658.64379084967 169.0017 L 686.91176470588 118.07740000000001 L 715.17973856209 118.57650000000001 L 743.4477124183 138.5566 L 771.71568627451 152.467 L 799.98366013072 249.2119 L 828.25163398693 239.7451 L 856.51960784314 135.2561 L 866.51960784314 135.2561"
                          stroke-linejoin="round" stroke="rgba(192,192,192,0.0001)" stroke-width="22"
                          visibility="visible" data-z-index="2" class="highcharts-tracker-line"
                          style="cursor:pointer;"></path>
                </g>
                <g data-z-index="0.1"
                   class="highcharts-markers highcharts-series-1 highcharts-line-series highcharts-color-1 highcharts-tracker highcharts-series-hover"
                   transform="translate(10,62) scale(1 1)" style="cursor:pointer;">
                    <path fill="#f7a35c" visibility="visible"
                          d="M 866 135.2561 A 10 10 0 1 1 865.9999950000005 135.24610000166666 Z"
                          class="highcharts-halo highcharts-color-1" data-z-index="-1" fill-opacity="0.25"></path>
                    <path fill="#f7a35c" d="M 8 248.0294 L 12 252.0294 8 256.0294 4 252.0294 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 36 251.79680000000002 L 40 255.79680000000002 36 259.7968 32 255.79680000000002 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 65 135.1684 L 69 139.1684 65 143.1684 61 139.1684 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 93 126.7964 L 97 130.7964 93 134.7964 89 130.7964 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 121 125.3474 L 125 129.3474 121 133.3474 117 129.3474 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 149 123.4154 L 153 127.4154 149 131.4154 145 127.4154 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 178 142.2524 L 182 146.2524 178 150.2524 174 146.2524 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 206 245.4373 L 210 249.4373 206 253.4373 202 249.4373 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 234 250.3478 L 238 254.3478 234 258.3478 230 254.3478 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 262 132.4797 L 266 136.4797 262 140.4797 258 136.4797 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 291 85.6609 L 295 89.6609 291 93.6609 287 89.6609 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 319 115.15610000000001 L 323 119.15610000000001 319 123.15610000000001 315 119.15610000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 347 107.1866 L 351 111.1866 347 115.1866 343 111.1866 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 375 104.93260000000001 L 379 108.93260000000001 375 112.93260000000001 371 108.93260000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 404 234.0707 L 408 238.0707 404 242.0707 400 238.0707 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 432 240.6234 L 436 244.6234 432 248.6234 428 244.6234 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 460 114.5121 L 464 118.5121 460 122.5121 456 118.5121 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 489 112.43520000000001 L 493 116.43520000000001 489 120.43520000000001 485 116.43520000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 517 118.53710000000001 L 521 122.53710000000001 517 126.53710000000001 513 122.53710000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 545 129.8554 L 549 133.8554 545 137.8554 541 133.8554 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 573 174.85490000000001 L 577 178.85490000000001 573 182.85490000000001 569 178.85490000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 602 245.3407 L 606 249.3407 602 253.3407 598 249.3407 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 630 259.0579 L 634 263.0579 630 267.0579 626 263.0579 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 658 165.0017 L 662 169.0017 658 173.0017 654 169.0017 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 686 114.07740000000001 L 690 118.07740000000001 686 122.07740000000001 682 118.07740000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c"
                          d="M 715 114.57650000000001 L 719 118.57650000000001 715 122.57650000000001 711 118.57650000000001 Z"
                          stroke="#ffffff" stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 743 134.5566 L 747 138.5566 743 142.5566 739 138.5566 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 771 148.467 L 775 152.467 771 156.467 767 152.467 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 799 245.2119 L 803 249.2119 799 253.2119 795 249.2119 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 828 235.7451 L 832 239.7451 828 243.7451 824 239.7451 Z" stroke="#ffffff"
                          stroke-width="1" class="highcharts-point highcharts-color-1 "></path>
                    <path fill="#f7a35c" d="M 856 129.2561 L 862 135.2561 856 141.2561 850 135.2561 Z" stroke="#ffffff"
                          stroke-width="2" class="highcharts-point highcharts-color-1 highcharts-point-hover"></path>
                </g>
            </g>
            <g class="highcharts-exporting-group" data-z-index="3">
                <g class="highcharts-button highcharts-contextbutton" stroke-linecap="round"
                   transform="translate(851,10)"><title>图表导出菜单</title>
                    <rect fill="#ffffff" class=" highcharts-button-box" x="0.5" y="0.5" width="24" height="22" rx="2"
                          ry="2" stroke="none" stroke-width="1"></rect>
                    <path fill="#666666" d="M 6 6.5 L 20 6.5 M 6 11.5 L 20 11.5 M 6 16.5 L 20 16.5"
                          class="highcharts-button-symbol" data-z-index="1" stroke="#666666" stroke-width="3"></path>
                    <text x="0" data-z-index="1" style="font-weight:normal;color:#333333;cursor:pointer;fill:#333333;"
                          y="12"></text>
                </g>
            </g>
            <g class="highcharts-label" opacity="1" data-z-index="3" transform="translate(787,106)">
                <path fill="none" class="highcharts-label-box" d="M 0 0" stroke="#7cb5ec" stroke-width="1"></path>
                <text x="0" data-z-index="1" style="font-weight:bold;color:#7cb5ec;fill:#7cb5ec;" y="12">访问量（PV）</text>
            </g>
            <g class="highcharts-label" opacity="1" data-z-index="3" transform="translate(716,314)">
                <path fill="none" class="highcharts-label-box" d="M 0 0" stroke="#f7a35c" stroke-width="1"></path>
                <text x="0" data-z-index="1" style="font-weight:bold;color:#f7a35c;fill:#f7a35c;" y="12">访问用户（UV）</text>
            </g>
            <text x="443" text-anchor="middle" class="highcharts-title" data-z-index="4"
                  style="color:#333333;font-size:16px;font-weight:bold;text-transform:uppercase;fill:#333333;" y="22">
                <tspan>课程数量</tspan>
            </text>
            <text x="443" text-anchor="middle" class="highcharts-subtitle" data-z-index="4"
                  style="color:#666666;fill:#666666;" y="45">
                <tspan>数据来源: 北京超凡视幻网络科技有限公司</tspan>
            </text>
            <g class="highcharts-legend" data-z-index="7" transform="translate(10,30)">
                <rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="260" height="28"
                      visibility="visible"></rect>
                <g data-z-index="1">
                    <g>
                        <g class="highcharts-legend-item highcharts-line-series highcharts-color-0 highcharts-series-0"
                           data-z-index="1" transform="translate(8,3)">
                            <path fill="none" d="M 0 12 L 16 12" class="highcharts-graph" stroke="#7cb5ec"
                                  stroke-width="2"></path>
                            <path fill="#7cb5ec" d="M 12 12 A 4 4 0 1 1 11.999998000000167 11.996000000666664 Z"
                                  class="highcharts-point" stroke="#ffffff" stroke-width="1"></path>
                            <text x="21"
                                  style="color:#333333;font-size:13px;font-weight:bold;cursor:pointer;fill:#333333;"
                                  text-anchor="start" data-z-index="2" y="16">
                                <tspan>访问量（PV）</tspan>
                            </text>
                        </g>
                        <g class="highcharts-legend-item highcharts-line-series highcharts-color-1 highcharts-series-1"
                           data-z-index="1" transform="translate(132.828125,3)">
                            <path fill="none" d="M 0 12 L 16 12" class="highcharts-graph" stroke="#f7a35c"
                                  stroke-width="2"></path>
                            <path fill="#f7a35c" d="M 8 8 L 12 12 8 16 4 12 Z" class="highcharts-point" stroke="#ffffff"
                                  stroke-width="1"></path>
                            <text x="21" y="16"
                                  style="color:#333333;font-size:13px;font-weight:bold;cursor:pointer;fill:#333333;"
                                  text-anchor="start" data-z-index="2">
                                <tspan>访问用户（UV）</tspan>
                            </text>
                        </g>
                    </g>
                </g>
            </g>
            <g class="highcharts-axis-labels highcharts-xaxis-labels " data-z-index="7">
                <text x="78.016339869281" style="color:#666666;cursor:default;font-size:12px;fill:#666666;"
                      text-anchor="start" transform="translate(0,0)" y="381" opacity="1">2013-03-11
                </text>
                <text x="275.89215686275" style="color:#666666;cursor:default;font-size:12px;fill:#666666;"
                      text-anchor="start" transform="translate(0,0)" y="381" opacity="1">2013-03-18
                </text>
                <text x="473.76797385621" style="color:#666666;cursor:default;font-size:12px;fill:#666666;"
                      text-anchor="start" transform="translate(0,0)" y="381" opacity="1">2013-03-25
                </text>
                <text x="671.64379084967" style="color:#666666;cursor:default;font-size:12px;fill:#666666;"
                      text-anchor="start" transform="translate(0,0)" y="381" opacity="1">2013-04-01
                </text>
                <text x="869.51960784314" style="color:#666666;cursor:default;font-size:12px;fill:#666666;"
                      text-anchor="start" transform="translate(0,0)" y="381" opacity="1">
                    <tspan></tspan>
                    <title>2013-04-08</title></text>
            </g>
            <g class="highcharts-axis-labels highcharts-yaxis-labels " data-z-index="7">
                <text x="0" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="start"
                      transform="translate(0,0)" y="-9999">0
                </text>
                <text x="13" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="start"
                      transform="translate(0,0)" y="320" opacity="1">5,000
                </text>
                <text x="13" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="start"
                      transform="translate(0,0)" y="239" opacity="1">10,000
                </text>
                <text x="13" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="start"
                      transform="translate(0,0)" y="159" opacity="1">15,000
                </text>
                <text x="13" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="start"
                      transform="translate(0,0)" y="78" opacity="1">20,000
                </text>
            </g>
            <g class="highcharts-axis-labels highcharts-yaxis-labels " data-z-index="7">
                <text x="0" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="end"
                      transform="translate(0,0)" y="-9999">0
                </text>
                <text x="872" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="end"
                      transform="translate(0,0)" y="320" opacity="1">5,000
                </text>
                <text x="872" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="end"
                      transform="translate(0,0)" y="239" opacity="1">10,000
                </text>
                <text x="872" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="end"
                      transform="translate(0,0)" y="159" opacity="1">15,000
                </text>
                <text x="872" style="color:#666666;cursor:default;font-size:12px;fill:#666666;" text-anchor="end"
                      transform="translate(0,0)" y="78" opacity="1">20,000
                </text>
            </g>
            <g class="highcharts-label highcharts-tooltip highcharts-color-0"
               style="pointer-events:none;white-space:nowrap;" data-z-index="8" transform="translate(687,223)"
               opacity="1" visibility="visible">
                <path fill="rgba(219,219,216,0.8)" class="highcharts-label-box highcharts-tooltip-box"
                      d="M 3 0 L 161 0 C 164 0 164 0 164 3 L 164 57 C 164 60 164 60 161 60 L 3 60 C 0 60 0 60 0 57 L 0 3 C 0 0 0 0 3 0"></path>
                <text x="8" data-z-index="1" style="font-size:12px;color:#333333;cursor:default;fill:#333333;" y="20">
                    <tspan style="font-size: 10px">2013-04-08</tspan>
                    <tspan style="fill:#7cb5ec" x="8" dy="15">●</tspan>
                    <tspan dx="0"> 访问量（PV）:</tspan>
                    <tspan style="font-weight:bold" dx="0">16,068</tspan>
                    <tspan style="fill:#f7a35c" x="8" dy="15">●</tspan>
                    <tspan dx="0"> 访问用户（UV）:</tspan>
                    <tspan style="font-weight:bold" dx="0">11,599</tspan>
                </text>
            </g>
        </svg>
    </div>
</div>

</body>
</html>
