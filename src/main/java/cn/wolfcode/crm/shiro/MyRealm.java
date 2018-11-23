package cn.wolfcode.crm.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class MyRealm extends AuthorizingRealm {
    /**
     * 授权(用户授权)
     *
     * @param principalCollection
     * @return
     */
    @Override
    //该方法拿到授权信息
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    /**
     * 认证(用户登陆认证)
     *
     * @param authenticationToken
     * @return 真实的认证信息
     * @throws AuthenticationException
     */
    //拿到认证的真实信息(该方法只做用户名是否存在的处理,存在则返回正式的认证信息，不存在返回null，至于密码是否存在不管)
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //模拟数据库中的用户名和密码
        String username = "admin";
        String password = "123";
        //拿到token中的的用户名和密码
        String principal = (String) authenticationToken.getPrincipal();
        if (username.equals(principal)) {
            //输入了存在的账户，返回该账户的真实信息
            return new SimpleAuthenticationInfo(principal, password, getName());
        }
        return null;//输入的账户不存在
    }
}
