<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <#include "../common/header.ftl" />
</head>
<script type="text/javascript">
    $(function () {
        $("#editForm").validate({
            rules: {
                name: {
                    required: true,
                    rangelength: [3, 10]
                },
                password: {
                    required: true,
                    rangelength: [1, 10]
                },
                repassword: {
                    required: true,
                    minlength: 3,
                    equalTo: "#password"
                },
                email: {
                    required: true,
                    email: true
                },
                age: {
                    required: true,
                    digits: true,
                    range: [16, 65]
                },
            },
            messages: {
                name: {
                    required: "名称不能为空",
                    rangelength: "名称长度为1-3个字符"
                },
                password: {
                    required: "密码不能为空",
                    rangelength: "密码长度范围为1-10"
                },
                repassword: {
                    required: "密码不能为空",
                    equalTo: "密码不一致"
                },
                email: {
                    required: "邮箱不能为空",
                    email: "邮箱格式不正确"
                },
                age: {
                    required: "年龄不能为空",
                    digits: "年龄必须为整数",
                    range: "年龄范围16-75"
                },
            }
        });
        //当选中管理员角色的按钮的时候，隐藏下面的角色选择框
        var $detach;
        $("#admin").click(function () {
            if ($(this).prop("checked")) {
                $detach = $("#role").detach();
            } else {
                $(this).closest("div").after($detach);
            }
        });

        //解决右边角色菜单中已有角色，在左侧不出现
        var selfRoles = $.map($(".selfRoles option"), function (value) {//多个jQuery对象转成Array
            return $(value).attr("value");
        });
        $.each($(".allRoles option"), function (index, value) {
            if ($.inArray($(value).val(), selfRoles) != -1) {
                $(value).remove();
            }
        });
        //初始化到编辑页面的时候，超级管理员为true的话应该隐藏，角色菜单
        if ($("#admin").prop("checked")) {
            $detach = $("#role").detach();
        }

        //解决右边因为不能默认不能全部选中，出现的表单提交不了的问题
        $("#btn_submit").click(function () {
            $(".selfRoles option").prop("selected", true);
            $("#editForm").submit();
        });


    })
    ;

</script>
<body>

<div class="container " style="margin-top: 20px">
    <#include "../common/top.ftl" />
    <div class="row">
        <div class="col-sm-3">
            <#assign currentMenu = "employee"/>
            <#include "../common/menu.ftl" >
        </div>
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="page-head-line">员工编辑</h1>
                </div>
            </div>
            <div class="row col-sm-10">
                <form class="form-horizontal" action="/employee/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="${(employee.id)!}" name="id">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">用户名：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" value="${(employee.name)!}"
                                   placeholder="请输入用户名">
                        </div>
                    </div>
                    <#if !employee?? >
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码：</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="password" name="password"
                                   value="${(employee.password)!}" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="repassword" class="col-sm-2 control-label">验证密码：</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" name="repassword" id="repassword"
                                   placeholder="再输入一遍密码">
                        </div>
                    </div>
                    </#if>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">Email：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="email" name="email" value="${(employee.email)!}"
                                   placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">年龄：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="age" name="age" value="${(employee.age)!}"
                                   placeholder="请输入年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept" class="col-sm-2 control-label">部门：</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="dept" name="department.id">
                                  <#list departments as dept>
                                      <option value="${dept.id}">${dept.name}</option>
                                  </#list>
                            </select>
                            <script>
                                $("#dept option[value='${(employee.department.id)!}']").prop("selected", true);
                            </script>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="admin" class="col-sm-2 control-label">超级管理员：</label>
                        <label class="checkbox-inline" style="margin-left: 15px;">
                            <input type="checkbox" id="admin" name="admin">
                            <script>
                                <#if employee?? && employee.admin >
                                    $("[name=admin]").prop("checked", true);
                                </#if>
                            </script>
                        </label>
                    </div>
                    <div class="form-group" id="role">
                        <div>
                            <label for="role" class="control-label" style="margin-left: 60px">角色：</label>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-4 col-sm-offset-1">
                                <select multiple class="form-control allRoles" size="15">
                                    <#if roles??>
                                        <#list roles as role>
                                                <option value="${role.id}">${role.name}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>

                            <div class="col-sm-2" style="margin-top: 60px;" align="center">
                                <div>
                                    <a type="button" class="btn btn-info  " style="margin-top: 10px"
                                       onclick="moveSelected('allRoles', 'selfRoles')">&nbsp;&gt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveSelected('selfRoles', 'allRoles')">&nbsp;&lt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('allRoles', 'selfRoles')">&gt;&gt;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('selfRoles', 'allRoles')">&lt;&lt;</a>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <select multiple class="form-control selfRoles" size="15" name="roleIds">
                                    <#if employee?? && employee.list??>
                                        <#list employee.list as role>
                                            <option value="${role.id}">${role.name}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-6">
                            <button id="btn_submit" class="btn btn-default">保存</button>
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>