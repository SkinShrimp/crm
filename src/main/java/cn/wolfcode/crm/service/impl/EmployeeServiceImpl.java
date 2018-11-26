package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.mapper.EmployeeMapper;
import cn.wolfcode.crm.query.EmployeeQueryObject;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.util.LogicException;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.io.IOException;
import java.io.InputStream;
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

    @Override
    public void batchDeleteById(Long[] ids) {
        employeeMapper.deleteBatchById(ids);
        if (ids != null) {
            for (Long id : ids) {
                deleteEmployeeRoleRelation(id);
            }
        }
    }

    @Override
    public Employee getByName(String principal) {
        return employeeMapper.selectByUsername(principal);
    }

    /**
     * 为保存和更新操作增加密码的加密
     */
    @Override
    public void saveOrUpdate(Employee entry, Long[] roleIds) {
        //为密码加密
        if (entry.getId() != null) {
            Md5Hash md5 = new Md5Hash(entry.getPassword(), entry.getName());
            entry.setPassword(md5.toString());
        }

        //增加role角色
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                insertEmployeeRoleRelation(entry.getId(), roleId);
            }
        }
        employeeMapper.insert(entry);
    }

    @Override
    public Workbook exportExcel(EmployeeQueryObject qo) {
        //查询需要导出的数据
        List<Employee> emps = employeeMapper.selectForList(qo);
        //创建workbook，并返回
        Workbook book = new HSSFWorkbook();
        //创建sheet
        Sheet sheet = book.createSheet("员工信息");
        //创建行(表头行)
        Row row = sheet.createRow(0);
        //创建单元格
        Cell cell = row.createCell(0);
        Cell cell2 = row.createCell(1);
        Cell cell3 = row.createCell(2);
        //设置数据
        cell.setCellValue("账号");
        cell2.setCellValue("邮箱");
        cell3.setCellValue("年龄");
        for (int i = 0; i < emps.size(); i++) {
            Row newRow = sheet.createRow(i + 1);
            newRow.createCell(0).setCellValue(emps.get(i).getName());
            newRow.createCell(1).setCellValue(emps.get(i).getEmail());
            newRow.createCell(2).setCellValue(emps.get(i).getAge());
        }
        return book;
    }

    @Override
    public void importExcel(InputStream inputStream) throws IOException {
        HSSFWorkbook book = new HSSFWorkbook(inputStream);
        HSSFSheet sheet1 = book.getSheet("Sheet1");
        int lastRowNum = sheet1.getLastRowNum();
        for (int i = 0; i < lastRowNum; i++) {
            HSSFRow row = sheet1.getRow(i + 1);
            Employee e = new Employee();
            e.setName(row.getCell(0).getStringCellValue());
            e.setEmail(row.getCell(1).getStringCellValue());
            e.setAge(Double.valueOf(row.getCell(2).getNumericCellValue()).intValue());
            employeeMapper.insert(e);
        }
    }

    @Override
    public List<Employee> ListAllSellers() {
        return employeeMapper.selectEmpByRoleSn(new String[]{"CLIENT_MGR", "SALEMAN"});
    }
}
