<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        $("#pagination").twbsPagination({
            totalPages: ${pageInfo.pages},//总页数
            startPage: ${qo.currentPage},//当前页
            visiblePages: ${qo.pageSize},
            first: '首页',
            prev: '上一页',
            next: '下一页',
            last: '末页',
            onPageClick: function (event, page) {
                $("#currentPage").val(page);//修改表单中的页面参数
                $("#searchForm").submit();
            }
        });

        //新增弹出模态框
        $(".btn-input").click(function () {
            //先清空模态框中的数据
            $("#editForm input").val("");
            var $json = $(this).data("json");
            if ($json) {
                $("#id").val($json.id);
                $("#name").val($json.name);
                $("#sn").val($json.sn);
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

        //将删除按钮转化为ajax删除
        $(".btn-delete").click(function () {
            $.messager.model = {
              ok:{text:"确定"},
              cancel:{text:"取消"}
            };
            var url = $(this).data("url");
            $.messager.confirm("温馨提示", "亲!您确定要删除当前数据么?", function () {
                //发送ajax请求
                $.get(url, function (data) {
                    if (data.success) {
                        $.messager.alert("温馨提示", "操作成功2S之后自动关闭页面!");
                        setTimeout(function () {
                            window.location.reload();
                        }, 2000);
                    }
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
                <a href="javascript:;" class="btn btn-success btn-input">添加</a>
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
                            <a class="btn btn-info btn-xs btn-input" href="javascript:;"
                               data-json='${role.jsonString}'>
                                <span class="glyphicon glyphicon-pencil"></span>编辑
                            </a>
                            <a href="javascript:;" data-url="/role/delete.do?id=${role.id}"
                               class="btn btn-danger btn-xs btn-delete">
                                <span class="glyphicon glyphicon-trash"></span>删除
                            </a>
                        </td>
                    </tr>
                </#list>
            </table>
            <div style="text-align: center;">
                <ul id="pagination" class="pagination"></ul>
            </div>
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

                <form class="form-horizontal" action="/role/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id" id="id">
                    <div class="form-group">
                        <label for="name" class="col-sm-4 control-label">角色名称：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="请输入角色名称">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">简称：</label>
                        <div class="col-sm-6">
                            <input type="sn" class="form-control" id="sn" name="sn"
                                   placeholder="请输入简称">
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