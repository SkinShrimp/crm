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
                $("#parentId").val($json.id);
                $("#parentTitle").val($json.title);
            }
            $(".modal").modal("show");
        });

        //编辑弹出模态框
        $(".editBtn").click(function () {
            //先清空模态框中的数据
            $("#editForm input").val("");
            var $json = $(this).data("json");
            if ($json) {
                $("#id").val($json.id);
                $("#parentId").val($json.parentId);
                $("#parentTitle").val($json.parentTitle);
                $("#title").val($json.title);
                $("#sequence").val($json.sequence);
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

        deleteBtn(".deleteBtn");
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "systemDictionaryItem"/>
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
                            <#list systemDictionarys as systemDictionary>
                                <li data-did="${systemDictionary_index}" id="${systemDictionary.id}">
                                    <a role="button"
                                       href="/systemDictionaryItem/list.do?parentId=${systemDictionary.id}">${systemDictionary.title}</a>
                                </li>
                            </#list>
                        </ul>
                    </li>
                </ul>
            </div>
            <script>
                <#if parent??>
                $("ul li[id=${(parent.id)!}]").addClass("active");
                </#if>
            </script>
        <#if pageInfo?? && pageInfo.list??>
            <div class="col-sm-8">
                <form class="form-inline" id="searchForm" action="/systemDictionaryItem/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <input type="hidden" name="parentId" value="${(parent.getId())!}">
                </form>
                <a role="button" class="btn btn-success inputBtn" data-json='${parent.jsonString}'>
                    <span class="glyphicon glyphicon-plus btn-add"></span> 添加明细
                </a>
                <table class="table table-striped table-hover">
                    <tbody>
                    <tr>
                        <th>编号</th>
                        <th>明细标题</th>
                        <th>明细序列</th>
                        <th>操作</th>
                    </tr>
                    <#list pageInfo.list as systemDictionaryItem>
                    <tr>
                        <td>${systemDictionaryItem_index + 1}</td>
                        <td>${systemDictionaryItem.title}</td>
                        <td>${systemDictionaryItem.sequence}</td>
                        <td>
                            <a role="button" class="btn btn-info btn-xs editBtn"
                               data-json='${systemDictionaryItem.jsonString}'>
                                <span class="glyphicon glyphicon-pencil"></span> 编辑
                            </a>
                            <a role="button" data-url="/systemDictionaryItem/delete.do?id=${systemDictionaryItem.id}"
                               class="btn btn-danger btn-xs deleteBtn">
                                <span class="glyphicon glyphicon-trash"></span> 删除
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

                <form class="form-horizontal" action="/systemDictionaryItem/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id" id="id">
                    <input type="hidden" name="parent.id" id="parentId">
                    <div class="form-group">
                        <label for="parentTitle" class="col-sm-4 control-label">字典目录：</label>
                        // disabled="disabled"不会在提交这里的表单 readonly提交表单
                        <div class="col-sm-6">
                            <input disabled="disabled" type="text" class="form-control" id="parentTitle" name="parentTitle"
                                   placeholder="请输入字典目录">
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="title" class="col-sm-4 control-label">明细标题：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="title" name="title"
                                   placeholder="请输入明细标题">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sequence" class="col-sm-4 control-label">明细序列：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sequence" name="sequence"
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