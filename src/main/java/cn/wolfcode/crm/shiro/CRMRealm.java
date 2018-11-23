package cn.wolfcode.crm.shiro;

import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.service.IEmployeeService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//crm使用的是realm
@Component("realm")//把当前类交给Spring管理id=realm
public class CRMRealm extends AuthorizingRealm {
    @Autowired
    private IEmployeeService employeeService;

    /**
     * 获取真实的认证信息
     *
     * @param token
     * @return 真实的认证信息
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //1、拿到token中的用户名
        String principal = (String) token.getPrincipal();

        //2、更具用户名查询用户对象
        Employee employee = employeeService.getByName(principal);
        //3、返回的用户为null，没有账号
        if (employee == null) {
            return null;
        }
        //4、返回真实的认证信息
        //注意：这里使用的员工对象最为身份存入认证信息中
        return new SimpleAuthenticationInfo(employee, employee.getPassword(), getName());
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Employee currentUser = (Employee) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        List<String> roles = new ArrayList<String>();
        roles.addAll(Arrays.asList("HR MGR", "ORDER MGR"));
        authorizationInfo.addRoles(roles);
        List<String> perms = new ArrayList<String>();
        perms.addAll(Arrays.asList("employee:view", "employee:delete"));
        authorizationInfo.addStringPermissions(perms);
        return authorizationInfo;
    }
}