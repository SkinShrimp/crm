<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        //新增弹出模态框
        $(".inputBtn").click(function () {
            //先清空模态框中的数据
            $("#editForm input").val("");
            var $json = $(this).data("json");
            if ($json) {
                $("input[name='emp.id']").val($json.id);
                $("select[name='emp.name']").val($json.id);
            }
            $(".modal").modal("show");
        });

        //编辑弹出模态框
        $(".editBtn").click(function () {
            //先清空模态框中的数据
            $("#editForm input").val("");
            var $json = $(this).data("json");
            if ($json) {
                $("input[name='emp.id']").val($json.id);
                $("#id").val($json.id);
                $("#year").val($json.year);
                $("#month").val($json.month);
                $("select[name='emp.name']").val($json.empId);
                $("#money").val($json.money);
            }
            $(".modal").modal("show");
        });

        //提交模态框中的数据
        $(".btn-submit").click(function () {
            //将表单的提交方式修改位ajax异步提交(使用jQuery.ajaxSubmit的方式)
            $("#editForm").ajaxSubmit(function (data) {
                if (data.success) {
                    $.messager.alert("温馨提示", "操作成功2S之后自动关闭页面!");
                    setTimeout(function () {
                        window.location.reload();
                    }, 2000);
                }
            });
        });

    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "salary"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">字典明细管理</h1>
                </div>
            </div>

            <div class="col-sm-4">
                <ul id="menu" class="list-group">
                    <li class="list-group-item">
                        <a role="button">
                            <span>字典目录</span>
                        </a>
                        <ul class="in">
                            <#list emps as emp>
                                <li data-did="${emp_index}" id="${emp.id}">
                                    <a role="button"
                                       href="/salary/list.do?empId=${emp.id}">${emp.name}</a>
                                </li>
                            </#list>
                        </ul>
                    </li>
                </ul>
            </div>
            <script>
                <#if emp??>
                $("ul li[id=${(emp.id)!}]").addClass("active");
                </#if>
            </script>
        <#if pageInfo?? && pageInfo.list??>
            <div class="col-sm-8">
                <form class="form-inline" id="searchForm" action="/salary/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <input type="hidden" name="empId" value="${(emp.getId())!}">
                </form>
                <a role="button" class="btn btn-success inputBtn" data-json='${(emp.jsonString)!}'>
                    <span class="glyphicon glyphicon-plus btn-add"></span> 添加明细
                </a>
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <th>编号</th>
                        <th>年份</th>
                        <th>月份</th>
                        <th>员工</th>
                        <th>工资</th>
                        <th>操作</th>
                        `
                    </tr>
                    <#list pageInfo.list as emp>
                    <tr>
                        <td>${emp_index + 1}</td>
                        <td>${emp.year}</td>
                        <td>${emp.month}</td>
                        <td>${emp.emp.name}</td>
                        <td>${emp.money}</td>
                        <td>
                            <a role="button" class="btn btn-info btn-xs editBtn"
                               data-json='${emp.jsonString}'>
                                <span class="glyphicon glyphicon-pencil"></span> 编辑
                            </a>
                        </td>
                    </tr>
                    </#list>
                    </tbody>
                </table>
                <div style="text-align: center;">
                    <#include "../common/page.ftl">
                </div>
            </div>
        </#if>

        </div>
    </div>
</div>

<#--模态框-->
<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" action="/salary/saveOrUpdate.do" method="post"
                      id="editForm">
                    <input type="hidden" name="id" id="id">
                    <input type="hidden" name="emp.id" id="emp.id">
                    <div class="form-group">
                        <label for="year" class="col-sm-4 control-label">年份：</label>
                    <#--
                           disabled="disabled"不会在提交这里的表单 readonly提交表单
                    -->
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="year"
                                   name="year"
                                   placeholder="请输入字典年份">
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="month" class="col-sm-4 control-label">月份：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="month" name="month"
                                   placeholder="请输入明细标题">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sequence" class="col-sm-4 control-label">员工：</label>
                        <div class="col-sm-6">
                            <select name="emp.name" class="form-control">
                                 <#list emps as emp>
                                     <option value="${emp.id}">${emp.name}</option>
                                 </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="money" class="col-sm-4 control-label">工资：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="money" name="money"
                                   placeholder="请输入明细序列">
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary btn-submit">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>