/*根据返回判断是否有提示框*/
function successAlert(data) {
    if(data.success){
        $.messager.alert("温馨提示", "操作成功,2S后自动关闭");
        setTimeout(function () {
            window.location.reload();
        }, 2000);
    }
}

