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
        //按钮回显
        $("#sellerId").val(${(qo.sellerId)!});
        //新增弹出模态框
        $(".btn-input").click(function () {
            //先清空模态框中的数据
            $("#editForm input").val("");
            var $json = $(this).data("json");
            if ($json) {
                $("#id").val($json.id);
                $("#name").val($json.name);
                $("#age").val($json.age);
                $("#gender").val($json.gender);
                $("#tel").val($json.tel);
                $("#qq").val($json.qq);
                console.log($json.jobId);
                $("[name='job.id']").val($json.jobId);
                console.log($("#job.id").get(0));
                $("[name='source.id']").val($json.sourceId);
                $("[name='seller.id']").val($json.sellerId);
            }
            $(".cust-modal").modal("show");
        });

        //提交模态框中的数据
        $(".btn-submit").click(function () {
            //将表单的提交方式修改位ajax异步提交(使用jQuery.ajaxSubmit的方式)
            console.log("=====================");
            $("#editForm").ajaxSubmit(function (data) {
                if (data.success) {
                    $.messager.alert("温馨提示", "操作成功2S之后自动关闭页面!");
                    setTimeout(function () {
                        window.location.reload();
                    }, 2000);
                }
            });
        });

        //显示跟进的模态框
        $(".btn-trace").click(function () {
            var $json = $(this).data("json");
            if ($json) {
                $("#traceForm input[name='customer.name']").val($json.name);
                $("#traceForm [name='customer.id']").val($json.id);
            }
            $(".model-trace").modal("show");
        });
        //跟进日期插件
        $("#traceForm input[name=traceTime]").click(function () {
            WdatePicker({
                readOnly: true,
                maxDate: new Date()
            })
        });
        //绑定表单json
        $("#traceForm").ajaxForm(function (data) {
            if (data.success) {
                $.messager.alert("温馨提示", "操作成功,2S后自动关闭");
                setTimeout(function () {
                    window.location.href = "/customerTraceHistory/list.do";
                }, 2000);
            }
        });

        //提交表单
        $(".traceSubmit").click(function () {
            $("#traceForm").submit();
        });

        //transferModal
        $(".transferBtn").click(function () {
            console.log("------------------");
            var $json = $(this).data("json");
            if ($json) {
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


        //statusModal
        $(".changeStatusBtn").click(function () {
            var $json = $(this).data("json");
            if ($json) {
                $("#statusForm [name=cid]").val($json.id);
                console.log($json);
                $("#statusForm input[name=name]").val($json.name);

            }
            $("#statusModal").modal("show");
        });
        //绑定表单json
        $("#statusForm").ajaxForm(function (data) {
            successAlert(data);
        });

        //提交表单
        $(".statusSubmit").click(function () {
            $("#statusForm").submit();
        });
    });
</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl">
    <div class="row">
        <div class="col-sm-3">
        <#assign currentMenu = "customer_potential"/>
            <#include "../common/menu.ftl">
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">客户管理</h1>
                </div>
            </div>
            <!--高级查询--->
            <form class="form-inline" id="searchForm" action="/customer/list.do" method="post">
                <input type="hidden" name="currentPage" id="currentPage" value="1">
                <div class="form-group">
                    <label>关键字:</label>
                    <input type="text" class="form-control" name="keyWord"
                           value="${(qo.keyWord)!}" placeholder="请输入姓名/电话">
                </div>
                <div class="form-group">
                    <label for="dept">营销人员:</label>
                    <select class="form-control" id="sellerId" name="sellerId">
                        <option value="-1">全部</option>
                        <#if sellers??>
                            <#list sellers as seller>
                              <option value="${seller.id}">${seller.name}</option>
                            </#list>
                        </#if>
                    </select>

                </div>
                <button type="submit" class="btn btn-primary">
                    <span class="glyphicon glyphicon-search"></span> 查询
                </button>
                <a role="button" href="javascript:;" class="btn btn-success btn-input">
                    <span class="glyphicon glyphicon-plus"></span> 添加
                </a>
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
                    <th>状态</th>
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
                        <th>${customer.statusName}</th>
                        <td>
                            <a class="btn btn-info btn-xs btn-input" href="javascript:;"
                               data-json='${(customer.jsonString)!}'>
                                <span class="glyphicon glyphicon-pencil"></span>编辑
                            </a>
                            <a role="button" class="btn btn-primary btn-xs btn-trace"
                               data-json='${(customer.jsonString)!}'>
                                <span class="glyphicon glyphicon-tag"></span> 跟进
                            </a>
                            <a role="button" class="btn btn-success btn-xs changeStatusBtn" data-json='${(customer.jsonString)!}'>
                                <span class="glyphicon glyphicon-plane"></span> 修改状态
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

<#--模态框-->
<div class="modal fade cust-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" action="/customer/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id" id="id">
                    <div class="form-group">
                        <label for="name" class="col-sm-4 control-label">姓名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name"
                                   placeholder="请输入姓名">
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="age" class="col-sm-4 control-label">年龄：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="age" name="age"
                                   placeholder="请输入年龄">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="gender" class="col-sm-4 control-label">性别：</label>
                        <div class="col-sm-6">

                            <select class="form-control" id="gender" name="gender">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="tel" class="col-sm-4 control-label">电话：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="tel" name="tel"
                                   placeholder="请输入电话">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="qq" class="col-sm-4 control-label">QQ：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="qq" name="qq"
                                   placeholder="请输入字QQ">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="job.id" class="col-sm-4 control-label">职业：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="job.id" name="job.id">
                                <if jobs??>
                                    <#list jobs as job>
                                        <option value="${job.id}">${job.title}</option>
                                    </#list>
                                </if>
                            </select>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="source.id" class="col-sm-4 control-label">来源：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="source.id" name="source.id">
                                <if sources??>
                                    <#list sources as source>
                                        <option value="${source.id}">${source.title}</option>
                                    </#list>
                                </if>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="seller.id" class="col-sm-4 control-label">营销人员：</label>
                        <div class="col-sm-6">

                            <select class="form-control" id="seller.id" name="seller.id">
                                <if sellers??>
                                    <#list sellers as seller>
                                        <option value="${seller.id}">${seller.name}</option>
                                    </#list>
                                </if>
                            </select>

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

<#--跟进历史-->
<div class="modal fade model-trace"
" id="traceModal" tabindex="-1" role="dialog" aria-hidden="true">
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
                <input type="hidden" name="customer.id"/>
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

<#--修改状态-->
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">修改客户状态</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customer/updateStatus.do" method="post" id="statusForm">
                    <input type="hidden" name="cid"/>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">客户名称：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" name="name"
                                   readonly placeholder="请输入客户名称"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">客户状态：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="status">
                                <option value="1">潜在客户</option>
                                <option value="2">移入客户池</option>
                                <option value="3">客户流失</option>
                                <option value="4">开发失败</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary statusSubmit">保存</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>