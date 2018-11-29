<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>叩丁狼</title>
    <#include "../common/header.ftl">
</head>

<script type="text/javascript">
    $(function () {
        //移交模态框
        $(".transferBtn").click(function () {
            var $json = $(this).data("json");
            if ($json) {

                $("#transferForm select[name='newSeller.id']").attr("readOnly", false);
                //重置表单的方法
                window.document.getElementById("transferForm").reset();
                $("#transferForm [name='customer.id']").val($json.id);
                $("#transferForm input[name='customer.name']").val($json.name);
                $("#transferForm [name='oldSeller.id']").val($json.sellerId);
                $("#transferForm [name='oldSeller.name']").val($json.sellerName);
            }
            $("#transferModal").modal("show");
        });
        //绑定表单json
        $("#transferForm").ajaxForm(function (data) {
            successAlert(data);
        });

        //提交表单
        $(".transferSubmit").click(function () {
            $("#transferForm").submit();
        });

        //移交给我模态框
        $(".transferMeBtn").click(function () {
            var $json = $(this).data("json");
            if ($json) {
                $("#transferForm [name='customer.id']").val($json.id);
                $("#transferForm input[name='customer.name']").val($json.name);
                $("#transferForm [name='oldSeller.id']").val($json.sellerId);
                $("#transferForm [name='oldSeller.name']").val($json.sellerName);
                $("#transferForm select[name='newSeller.id']").val(<@shiro.principal property='id'/>);
                $("#transferForm select[name='newSeller.id']").attr("readOnly", true);
            }
            $("#transferModal").modal("show");
        });
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "customer_pool"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">客户池</h1>
                </div>
            </div>

            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/customer/poolList.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <div class="form-group">
                    <label>关键字:</label>
                    <input type="text" class="form-control" name="keyWord"
                           value="${(qo.keyWord)!}" placeholder="请输入姓名/电话">
                </div>
                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span> 查询
                </button>
            </form>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>姓名</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>电话</th>
                    <th>qq</th>
                    <th>职业</th>
                    <th>来源</th>
                    <th>营销人员</th>
                    <th>操作</th>
                </tr>
                </thead>
                <#list pageInfo.list as customer>
                    <tr>
                        <td>${customer_index + 1}</td>
                        <td>${customer.name}</td>
                        <th>${customer.age}</th>
                        <th>${customer.genderName}</th>
                        <th>${customer.tel}</th>
                        <th>${customer.qq}</th>
                        <th>${(customer.job.title)!}</th>
                        <th>${(customer.source.title)!}</th>
                        <th>${(customer.seller.name)!}</th>
                        <td>
                            <a role="button" class="btn btn-warning btn-xs transferMeBtn"
                               data-json='${(customer.jsonString)!}'>
                                <span class="glyphicon glyphicon-leaf"></span> 移交给我
                            </a>
                            <a role="button" class="btn btn-warning btn-xs transferBtn"
                               data-json='${(customer.jsonString)!}'>
                                <span class="glyphicon glyphicon-leaf"></span> 移交
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

<#--移交模态框-->
<div id="transferModal" class="modal fade transferModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">客户移交</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTransferHistory/save.do" method="post" id="transferForm"
                      style="margin: -3px 118px">
                    <input type="hidden" name="id" id="customerTransferId"/>
                    <div class="form-group">
                        <label for="name" class="col-sm-4 control-label">客户姓名：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="customer.name" readonly>
                            <input type="hidden" class="form-control" name="customer.id">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">旧营销人员：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="oldSeller.name" readonly>
                            <input type="hidden" class="form-control" name="oldSeller.id">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">新营销人员：</label>
                        <div class="col-sm-8">
                            <select name="newSeller.id" id="newSeller" class="form-control">
                                <#list sellers as e>
                                    <option value="${e.id}">${e.name}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">移交原因：</label>
                        <div class="col-sm-8">
                            <textarea type="text" class="form-control" id="reason" name="reason" cols="10"></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary transferSubmit">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>