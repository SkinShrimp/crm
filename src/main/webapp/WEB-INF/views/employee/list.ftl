<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        //将删除按钮转化为ajax删除
        $(".btn-delete").click(function () {
            $.messager.model = {
                ok: {text: "确定"},
                cancel: {text: "取消"}
            };
            var url = $(this).data("url");
            $.messager.confirm("温馨提示", "亲!您确定要删除当前数据么?", function () {
                //发送ajax请求
                $.get(url, function (data) {
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
            </form>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
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
                            <a href="javascript:;" data-url="/employee/delete.do?id=${employee.id}" class="btn btn-danger btn-xs btn-delete">
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