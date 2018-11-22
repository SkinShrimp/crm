<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        jQuery.ajaxSettings.traditional = true;
        deleteBtn(".btn-delete");

        //批量选择
        $("#batchCheck").click(function () {
            $("input[name=subCheck]").prop("checked", this.checked);
        });
        //批量删除
        $(".batchDelete").click(function () {
            var size = $("input[name=subCheck]:checked").size();
            if (size == 0) {
                $.messager.alert("温馨提示", "请您选择删除的数据！")
                return;
            }
            var idsArr = $.map($("input[name=subCheck]:checked"), function (value) {
                return $(value).val();
            });
            $.messager.confirm("温馨提示", "您确定要批量删除这些数据么?", function () {
                $.get("/employee/batchDelete.do", {ids: idsArr}, function (data) {
                    successAlert(data);
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
        <#assign currentMenu = "employee"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">员工管理</h1>
                </div>
            </div>
            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/employee/list.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <div class="form-group">
                    <label for="keyword">关键字:</label>
                    <input type="text" class="form-control" id="keyword" name="keyWord" value="${(qo.keyWord)!}"
                           placeholder="请输入姓名/邮箱">
                </div>
                <div class="form-group">
                    <label for="dept">部门:</label>
                    <select class="form-control" id="dept" name="deptId">
                        <option value="-1">全部</option>
                        <#list (departments)! as dept>
                            <option value="${(dept.id)!}">${(dept.name)!}</option>
                        </#list>
                    </select>
                    <script>
                        $("#dept option[value='${(qo.deptId)!}']").prop("selected", true);
                    </script>
                </div>
                <input type="submit" id="btn_query" class="btn btn-default" value="查询">
                <a href="/employee/input.do" class="btn btn-success">添加</a>
                <a role="button" class="btn btn-danger batchDelete">
                    <span class="glyphicon glyphicon-trash"></span> 批量删除
                </a>
            </form>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" name="check" id="batchCheck"></th>
                    <th>序号</th>
                    <th>姓名</th>
                    <th>密码</th>
                    <th>年龄</th>
                    <th>邮箱</th>
                    <th>管理员</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <#list pageInfo.list as employee>
                    <tr>
                        <td><input type="checkbox" name="subCheck" value="${employee.id}"></td>
                        <td>${employee_index + 1}</td>
                        <td>${employee.name}</td>
                        <th>${employee.password}</th>
                        <th>${employee.age}</th>
                        <th>${employee.email}</th>
                        <th>${(employee.admin)?string("true","fasle")}</th>
                        <th>${employee.department.name}</th>
                        <td>
                            <a class="btn btn-info btn-xs" href="/employee/input.do?id=${employee.id}">
                                <span class="glyphicon glyphicon-pencil"></span>编辑
                            </a>
                            <a href="javascript:;" data-url="/employee/delete.do?id=${employee.id}"
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