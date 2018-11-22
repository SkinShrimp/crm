package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.mapper.EmployeeMapper;
import cn.wolfcode.crm.query.EmployeeQueryObject;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.util.LogicException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;

@Service
public class EmployeeServiceImpl implements IEmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public void save(Employee entry, Long[] roleIds) {
        //增加role角色
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                insertEmployeeRoleRelation(entry.getId(), roleId);
            }
        }
        employeeMapper.insert(entry);
    }

    @Override
    public void delete(Long id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Employee entry, Long[] roleIds) {
        //增加role角色
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                insertEmployeeRoleRelation(entry.getId(), roleId);
            }
        }
        employeeMapper.updateByPrimaryKey(entry);
    }

    @Override
    public Employee get(Long id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Employee> listAll() {
        return employeeMapper.selectAll();
    }

    @Override
    public PageInfo<Employee> query(EmployeeQueryObject qo) {
        //在这行代码下面的第一个SQL会拼接分页的片段
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Employee> list = employeeMapper.selectForList(qo);
        return new PageInfo<>(list);
    }

    /**
     * 检验用户登陆
     *
     * @param name
     * @param password
     */
    @Override
    public void login(String name, String password) {
        Employee employee = employeeMapper.login(name, password);
        //用户不存在的情况
        if (employee == null) {
            throw new LogicException("亲,您的账号或者密码错误!!!");
        }

        //将用户信息保存在SESSION中(在service层中，不应该出现HttpSession应该在Controller层出现的变量)
        ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).
                getRequest().getSession().setAttribute("EMP_IN_SESSION", employee);

        //查询当前用户拥有的权限表达式，再共享到Session中
        ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).
                getRequest().getSession().setAttribute("EXPRESSIONS_IN_SESSION", employeeMapper.selectPermissionsByEmployeeId(employee.getId()));

    }

    @Override
    public void deleteEmployeeRoleRelation(Long emplId) {
        employeeMapper.deleteEmployeeRoleRelation(emplId);
    }

    @Override
    public void insertEmployeeRoleRelation(Long emplId, Long roleId) {
        employeeMapper.insertEmployeeRoleRelation(emplId, roleId);
    }
}
