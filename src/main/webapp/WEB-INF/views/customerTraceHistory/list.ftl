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
            WdatePicker({
                readOnly: true,
                maxDate: new Date()
            })
        });
        $("input[name=endDate]").click(function () {
            console.log("-------------");
            WdatePicker({
                readOnly: true,
                maxDate: new Date(),
                minDate: $("input[name=beginDate]").val()
            });
        });
        //新增弹出模态框
        $(".btn-input").click(function () {
            var $json = $(this).data("json");
            if ($json) {
                $("input[name='id']").val($json.id);
                $("input[name='customer.name']").val($json.customer);
                $("input[name='traceTime']").val($json.traceTime);
                $("input[name='traceDetails']").val($json.traceDetails);
                $("[name='traceType.id']").val($json.traceType);
                $("[name='traceResult']").val($json.traceResult);
                $("textarea[name='remark']").val($json.remark);
            }
            $(".model-trace").modal("show");
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

        //绑定表单json
        $("#traceForm").ajaxForm(function (data) {
            successAlert(data);
        });

        //提交表单
        $(".traceSubmit").click(function () {
            $("#traceForm").submit();
        });

        $("input[name=traceTime]").click(function () {
            WdatePicker({
                readOnly: true,
                maxDate: new Date()
            })
        });
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "customerTraceHistory"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">跟进历史管理</h1>
                </div>
            </div>
            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/customerTraceHistory/list.do" method="post">
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
                    <th>客户姓名</th>
                    <th>跟进时间</th>
                    <th>跟进记录</th>
                    <th>跟进方式</th>
                    <th>跟进结果</th>
                    <th>录入人</th>
                    <th>操作</th>
                </tr>
                </thead>
                <#list pageInfo.list as customerTraceHistory>
                    <tr>
                        <td>${customerTraceHistory_index + 1}</td>
                        <td>${customerTraceHistory.customer.name}</td>
                        <th>${customerTraceHistory.traceTime?string("yyyy-MM-dd")}</th>
                        <th>${customerTraceHistory.traceDetails}</th>
                        <th>${customerTraceHistory.traceType.title}</th>
                        <th>${customerTraceHistory.traceResultFlag}</th>
                        <th>${customerTraceHistory.inputUser.name}</th>
                        <td>
                            <a class="btn btn-info btn-xs btn-input" href="javascript:;"
                               data-json='${(customerTraceHistory.jsonString)!}'>
                                <span class="glyphicon glyphicon-pencil btn-edit"></span>编辑
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


<#--跟进历史-->
<div class="modal fade model-trace" id="traceModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">跟进</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTraceHistory/saveOrUpdate.do" method="post"
                      id="traceForm">
                <#--新增,新增跟进历史没有ID,客户应该要有ID,不然就不知道当前是哪个客户的跟进历史-->
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">客户姓名：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" readonly name="customer.name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">跟进时间：</label>
                        <div class="col-lg-6 ">
                            <input type="text" class="form-control " name="traceTime"
                                   placeholder="请输入跟进时间">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">跟进记录：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" name="traceDetails"
                                   placeholder="请输入跟进记录"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">交流方式：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="traceType.id">
                                <#list traceTypes as traceType>
                                    <option value="${traceType.id}">${traceType.title}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">跟进结果：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="traceResult">
                                <option value="1">优</option>
                                <option value="2">中</option>
                                <option value="3">差</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">备注：</label>
                        <div class="col-lg-6">
                            <textarea type="text" class="form-control" name="remark"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary traceSubmit">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>