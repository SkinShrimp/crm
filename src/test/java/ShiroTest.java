import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.junit.Test;

import java.util.Arrays;

public class ShiroTest {
    @Test
    public void loginTest() {
        //1、创建基于ini文件的安全管理工厂
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //2、从工厂中拿到安全管理器对象
        SecurityManager manager = factory.getInstance();
        //3、设置安全管理器运行环境
        SecurityUtils.setSecurityManager(manager);
        //4、在当前环境中拿到一个主体对象
        Subject subject = SecurityUtils.getSubject();//相当于当前用户，默认没有任何认证信息
        //5、床架token，其中包含了账号密码  账号错误异常：org.apache.shiro.authc.UnknownAccountException
        //密码错误异常:org.apache.shiro.authc.IncorrectCredentialsException
        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");
        System.out.println(subject.isAuthenticated());
        //6、执行登陆认证
        subject.login(token);
        //7、查看当前用户当前状态，如：认证状态
        System.out.println(subject.isAuthenticated());
    }

    @Test
    public void loginTest2() {
        //1、创建基于ini文件的安全管理工厂
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //2、从工厂中拿到安全管理器对象
        SecurityManager manager = factory.getInstance();
        //3、设置安全管理器运行环境
        SecurityUtils.setSecurityManager(manager);
        //4、在当前环境中拿到一个主体对象
        Subject subject = SecurityUtils.getSubject();//相当于当前用户，默认没有任何认证信息
        //5、床架token，其中包含了账号密码  账号错误异常：org.apache.shiro.authc.UnknownAccountException
        //密码错误异常:org.apache.shiro.authc.IncorrectCredentialsException
        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");
        System.out.println(subject.isAuthenticated());
        //6、执行登陆认证
        subject.login(token);
        //7、查看当前用户当前状态，如：认证状态
        System.out.println(subject.isAuthenticated());
    }

    @Test
    public void rolesTest() {
        //1、创建基于ini文件的安全管理工厂
        IniSecurityManagerFactory factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //2、从工厂中拿到安全管理器对象
        SecurityManager manager = factory.getInstance();
        //3、设置安全管理器运行环境
        SecurityUtils.setSecurityManager(manager);
        //4、在当前环境中拿到一个主体对象
        Subject subject = SecurityUtils.getSubject();//相当于当前用户，默认没有任何认证信息
        //5、床架token，其中包含了账号密码  账号错误异常：org.apache.shiro.authc.UnknownAccountException
        //密码错误异常:org.apache.shiro.authc.IncorrectCredentialsException
        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");
//        System.out.println(subject.isAuthenticated());//false
        //6、执行登陆认证
        subject.login(token);
        System.out.println(subject.hasRole("roles"));
        System.out.println(subject.hasRole("roles1"));
        System.out.println(Arrays.toString(subject.hasRoles(Arrays.asList("roles", "roles1"))));
        System.out.println(subject.isPermitted("employee:list"));
        System.out.println(Arrays.toString(subject.isPermitted("employee:delete", "employee:list")));
        //7、查看当前用户当前状态，如：认证状态
//        System.out.println(subject.isAuthenticated());//ture
    }
}
