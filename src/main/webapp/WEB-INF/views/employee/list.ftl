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

        $(".btn-export").click(function () {
            //提交高级查询的表单，但是action最开始是/employee/list.do
            //而我们需要访问的/employee/exportExcel.do
            //所以将表单修改为/employee/list.do在提交
            //最后把action的值修改回来
            $("#searchForm").prop("action", "/employee/exportExcel.do");
            $("#searchForm").submit();
            $("#searchForm").prop("action", "/employee/list.do");
        });
        //点击导入按钮弹出模态框
        $(".importBtn").click(function () {
            $("#importModal").modal("show");
        });

        $(".submitBtn").click(function () {
            $("#editForm").submit();
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
                <a href="javascript:;" target="_blank" class="btn btn-warning btn-export">
                    <span class="glyphicon glyphicon-export"></span> 导出
                </a>
                <a role="button" class="btn btn-warning importBtn">
                    <span class="glyphicon glyphicon-import"></span> 导入
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
                        <th>${(employee.password)!}</th>
                        <th>${employee.age}</th>
                        <th>${employee.email}</th>
                        <th>${(employee.admin)?string("true","fasle")}</th>
                        <th>${(employee.department.name)!}</th>
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


<!-- 导入员工 -->
<div class="modal fade" id="importModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">导入员工</h4>
            </div>
            <div class="modal-body">
                <!--填充编辑界面-->
                <form id="editForm" class="form-horizontal" action="/employee/importExcel.do"
                      enctype="multipart/form-data" method="post">
                    <input type="hidden" name="id"/>
                    <div class="form-group" >
                        <label for="name" class="col-lg-4 control-label">上传文件：</label>
                        <div class="col-lg-6">
                            <input type="file" name="xls" accept="application/vnd.ms-excel" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-lg-4 control-label">参考模板：</label>
                        <div class="col-lg-6">
                            <a href="/template/employee.xls" class="btn btn-success btn-block">
                                <span class="glyphicon glyphicon-download"></span> 下载模板
                            </a>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary submitBtn">保存</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>