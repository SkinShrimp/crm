package cn.wolfcode.crm.shiro.filter;

import cn.wolfcode.crm.util.JsonResult;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;

@Component("formFilter")//crm专用表单过滤器
public class CRMFormFilter extends FormAuthenticationFilter {
    /**
     * @param token
     * @param subject
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Override
    //登陆成功后调用该方法，只要在该方法中返回JSON即可
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        response.setContentType("text/json;charset=UTF-8");//设置相应类型
        response.getWriter().print(JSON.toJSON(new JsonResult()));
        return false;
    }

    //登陆失败后调用该方法，只要在该方法中返回JSON即可
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        try {
            response.setContentType("text/json;charset=UTF-8");//设置相应类型
            JsonResult json = new JsonResult();
            json.mark("账号或者密码不正确");//设置错误信息
            response.getWriter().print(JSON.toJSON(json));
        } catch (IOException e1) {
            e1.printStackTrace();
        }

        return false;
    }
}
