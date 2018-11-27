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
            console.log("===============");
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
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "customerTransferHistory"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">移交历史管理</h1>
                </div>
            </div>
            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/customerTransferHistory/list.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <div class="form-group">
                    <label>关键字:</label>
                    <input type="text" class="form-control" name="keyWord"
                           value="${(qo.keyWord)!}" placeholder="请输入客户姓名/录入人">
                </div>
                <div class="form-group">
                    <label>时间:</label>
                    <input type="text" class="form-control" name="beginDate"
                           value="${(qo.beginDate?string("yyyy-MM-dd"))!}"
                           placeholder="请输入开始时间"> ~
                    <input type="text" class="form-control" name="endDate"
                           value="${(qo.endDate?string("yyyy-MM-dd"))!}"
                           placeholder="请输入结束时间">
                </div>
                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span> 查询
                </button>
            </form>


            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>客户名称</th>
                    <th>操作时间</th>
                    <th>操作人</th>
                    <th>旧营销人员</th>
                    <th>新营销人员</th>
                    <th>移交原因</th>
                </tr>
                </thead>
                <#list pageInfo.list as customerTransferHistory>
                    <tr>
                        <td>${customerTransferHistory_index + 1}</td>
                        <td>${customerTransferHistory.customer.name}</td>
                        <th>${customerTransferHistory.operateTime?string("yyyy-MM-dd")}</th>
                        <th>${customerTransferHistory.operator.name}</th>
                        <th>${customerTransferHistory.oldSeller.name}</th>
                        <th>${customerTransferHistory.newSeller.name}</th>
                        <th>${customerTransferHistory.reason}</th>
                    </tr>
                </#list>
            </table>
            <div style="text-align: center;">
                <#include "../common/page.ftl">
            </div>
        </div>
    </div>
</div>
</body>
</html>