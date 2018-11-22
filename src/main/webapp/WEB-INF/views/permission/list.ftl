<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        //还原权限列表
        $("#permissionOnload_btn").click(function () {
            //修改提示信息
            $.messager.model = {
                ok: {text: "确定"},
                cancel: {text: "取消"}
            };

            $.messager.confirm("温馨提示!!!", "更新权限时间可能很长确定么?", function () {
                $.get("/permission/onload.do", function (data) {
                    successAlert(data);
                });
            });
        });

        //删除权限按钮
        $(function () {
            $(".btn-delete").click(function () {
                //修改提示信息
                $.messager.model = {
                    ok: {text: "确定"},
                    cancel: {text: "取消"}
                };

                var $url = $(".btn-delete").data("url");
                $.messager.confirm("温馨提示!!!", "确定要删除这条权限么?", function () {
                    $.get($url, function (data) {
                        successAlert(data);
                    });
                });
            });
        });
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "permission"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">权限管理</h1>
                </div>
            </div>

            <form class="form-inline" id="searchForm" action="/permission/list.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <input type="button" id="permissionOnload_btn" class="btn btn-primary" value="还原权限列表"></input>
            </form>
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>权限名称</th>
                    <th>权限表达式</th>
                    <th>操作</th>
                </tr>
                </thead>
                <#list pageInfo.list as entity>
                    <tr>
                        <td>${entity_index + 1}</td>
                        <td>${(entity.name)!}</td>
                        <th>${entity.expression}</th>
                        <td>
                            <a href="javascript:;" data-url="/permission/delete.do?id=${entity.id}"
                               class="btn btn-danger btn-xs btn-delete">
                                <span class="glyphicon glyphicon-trash"></span>删除
                            </a>
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