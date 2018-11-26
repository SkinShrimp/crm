package cn.wolfcode.crm.util;

import cn.wolfcode.crm.domain.Employee;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

public abstract class UserContext {
    private UserContext() {
    }

    public static Employee getCurrentEmp() {
        Subject subject = SecurityUtils.getSubject();
        return (Employee) subject.getPrincipal();
    }

    public static boolean isAdminOrSaleManager() {
        Subject subject = SecurityUtils.getSubject();
        Employee emp = (Employee) subject.getPrincipal();
        return emp.isAdmin() || subject.hasRole("CLIENT_MGR");
    }
}
