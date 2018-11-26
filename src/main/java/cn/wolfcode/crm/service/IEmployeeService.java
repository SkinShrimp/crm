package cn.wolfcode.crm.service;


import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.query.EmployeeQueryObject;
import com.github.pagehelper.PageInfo;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public interface IEmployeeService {
    public abstract void save(Employee entry, Long[] roleIds);

    public abstract void delete(Long id);

    public abstract void update(Employee entry, Long[] roleIds);

    public abstract Employee get(Long id);

    public abstract List<Employee> listAll();

    public abstract PageInfo<Employee> query(EmployeeQueryObject qo);

    public abstract void login(String name, String password);

    public abstract void deleteEmployeeRoleRelation(Long emplId);

    public abstract void insertEmployeeRoleRelation(Long emplId, Long roleId);

    public abstract void batchDeleteById(Long[] ids);

    public abstract Employee getByName(String principal);

    public abstract void saveOrUpdate(Employee entry, Long[] roleIds);

    public abstract Workbook exportExcel(EmployeeQueryObject qo);

    public abstract void importExcel(InputStream inputStream) throws IOException;

    public abstract List<Employee> ListAllSellers();
}

