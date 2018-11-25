<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        deleteBtn(".btn-delete");
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "role"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">角色管理</h1>
                </div>
            </div>
            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/role/list.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <a href="/role/input.do" class="btn btn-success">添加</a>
            </form>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>名称</th>
                    <th>简称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <#list pageInfo.list as role>
                    <tr>
                        <td>${role_index + 1}</td>
                        <td>${role.name}</td>
                        <th>${role.sn}</th>
                        <td>
                            <a class="btn btn-info btn-xs" href="/role/input.do?id=${role.id}">
                                <span class="glyphicon glyphicon-pencil"></span>编辑
                            </a>
                            <@shiro.hasPermission name="employee:delete">
                            <a href="javascript:;" data-url="/role/delete.do?id=${role.id}"
                               class="btn btn-danger btn-xs btn-delete">
                                <span class="glyphicon glyphicon-trash"></span>删除
                            </a>
                            </@shiro.hasPermission>
                        </td>
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