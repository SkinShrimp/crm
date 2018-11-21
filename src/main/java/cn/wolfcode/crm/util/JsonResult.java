package cn.wolfcode.crm.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JsonResult {
    //默认正常登陆
    private String msg;
    private boolean success = true;

    //当登陆名或者密码错误的时候使用该方法封装对象
    public void mark(String msg){
        this.msg = msg;
        this.success = false;
    }
}
