<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
    <script src="/js/plugins/My97DatePicker/WdatePicker.js"></script>
</head>

<script type="text/javascript">
    $(function () {
        $("input[name=beginDate]").click(function () {
            WdatePicker({
                readOnly: true,
                maxDate: new Date()
            })
        });
        $("input[name=endDate]").click(function () {
            WdatePicker({
                readOnly: true,
                maxDate: new Date(),
                minDate: $("input[name=beginDate]").val()
            });
        });

        //回显下拉框
        $("select[name=groupType]").val("${(qo.groupType)!}");

        //弹出柱状图报表模态框
        $(".barBtn").click(function () {
            //使用form.serialize()传递表单中的数据
            $("#barModel").removeData("bs.modal") .modal({
                remote:"/chart/chartByBar.do?" + $("#searchForm").serialize()
            });
        });
        //弹出饼状图报表模态框
        $(".pieBtn").click(function () {
            //使用form.serialize()传递表单中的数据
            $("#barModel").removeData("bs.modal") .modal({
                remote:"/chart/chartByPie.do?" + $("#searchForm").serialize()
            });
        });
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "department"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">潜在客户报表管理</h1>
                </div>
            </div>

            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/chart/list.do" method="post">
                <div class="form-group">
                    <label>销售员:</label>
                    <input type="text" class="form-control" name="keyWord" style="width: 150px"
                           value="${(qo.keyWord)!}" placeholder="请输入销售员姓名">
                </div>
                <div class="form-group">
                    <label>时间:</label>
                    <input type="text" class="form-control" name="beginDate" style="width: 150px"
                           value="${(qo.beginDate?string("yyyy-MM-dd"))!}"
                           placeholder="请输入开始时间"> ~
                    <input type="text" class="form-control" name="endDate" style="width: 150px"
                           value="${(qo.endDate?string("yyyy-MM-dd"))!}"
                           placeholder="请输入结束时间">
                </div>
                <div class="form-group">
                    <label>分组类型:</label>
                    <select class="form-control" name="groupType">
                        <option value="emp.name">销售员</option>
                        <option value="DATE_FORMAT(cust.input_time, '%Y')">年份</option>
                        <option value="DATE_FORMAT(cust.input_time, '%Y-%m')">月份</option>
                        <option value="DATE_FORMAT(cust.input_time, '%Y-%m-%d')">日期</option>
                    </select>
                    <script>
                        $("#searchForm select[name='groupType']").val("emp.name");
                    </script>
                </div>
                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span> 查询
                </button>
                <a role="button" class="btn btn-success barBtn">
                    <span class="glyphicon glyphicon-film"></span> 柱状图
                </a>
                <a role="button" class="btn btn-success pieBtn">
                    <span class="glyphicon glyphicon-film"></span> 饼状图
                </a>
            </form>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>分组类型</th>
                    <th>新增客户数</th>
                </tr>
                </thead>
                <#list charts as entity>
                    <tr>
                        <td>${entity_index + 1}</td>
                        <td>${entity.groupByType}</td>
                        <th>${entity.totalNumber}</th>
                    </tr>
                </#list>
            </table>
        </div>
    </div>
</div>

<#--报表模态框-->
<div class="modal fade" id="barModel">
    <div class="modal-dialog">
        <div class="modal-content">
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>