/*根据返回判断是否有提示框*/
function successAlert(data) {
    if (data.success) {
        $.messager.alert("温馨提示", "操作成功,2S后自动关闭");
        setTimeout(function () {
            window.location.reload();
        }, 2000);
    }
}

//将删除按钮转化为ajax删除
function deleteBtn(btnClass) {
    $(btnClass).click(function () {
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
}
function moveSelected(src, target) {
    $("." + target).append($("." + src + " option:selected"));
}

function moveAll(src, target) {
    $("." + target).append($("." + src + " option"));
}

