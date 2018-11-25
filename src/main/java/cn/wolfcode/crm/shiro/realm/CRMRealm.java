package cn.wolfcode.crm.shiro.realm;

import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.service.IPermissionService;
import cn.wolfcode.crm.service.IRoleService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Set;

//crm使用的是realm
@Component("realm")//把当前类交给Spring管理id=realm
public class CRMRealm extends AuthorizingRealm {
    @Autowired
    private IEmployeeService employeeService;

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IPermissionService permissionService;

    //注入加密的凭证匹配器
    @Autowired
    @Override
    public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
        super.setCredentialsMatcher(credentialsMatcher);
    }

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
        return new SimpleAuthenticationInfo(employee, employee.getPassword(), ByteSource.Util.bytes(employee.getName()), getName());
    }

    /**
     * 获取真正授权信息
     *
     * @param principals 身份
     * @return 授权信息
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //创建授权对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //拿到当前的用户信息
        Employee emp = (Employee) principals.getPrimaryPrincipal();
        //判断是否是超管，超管的给与admin角色和所有的权限
        if (emp.isAdmin()) {
            info.addRole("admin");
            info.addStringPermission("*:*");
        } else {
            //查询当前用户拥有的所有的角色编码
            Set<String> roles = roleService.getRolesSNByEmployeeId(emp.getId());
            //查询当前用户拥有的所有权限表达式
            Set<String> expressions = permissionService.getExpressionsByEmployeeId(emp.getId());
            info.addRoles(roles);
            info.addStringPermissions(expressions);
        }
        //返回授权信息
        return info;
    }
}