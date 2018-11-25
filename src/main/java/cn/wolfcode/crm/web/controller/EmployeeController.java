package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.query.EmployeeQueryObject;
import cn.wolfcode.crm.service.IDepartmentService;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.service.IRoleService;
import cn.wolfcode.crm.util.JsonResult;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private IDepartmentService departmentService;
    @Autowired
    private IRoleService roleService;

    /**
     * 查看员工列表
     *
     * @param model
     * @param qo
     * @return
     */
    @RequiresPermissions(value = {"员工查询", "employee:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") EmployeeQueryObject qo) {
        model.addAttribute("pageInfo", employeeService.query(qo));
        //查询所有的部门信息用于高级查询
        model.addAttribute("departments", departmentService.listAll());
        return "employee/list";
    }

    @RequiresPermissions(value = {"员工删除", "employee:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        employeeService.delete(id);

        //员工删除的时候，应该删除（员工与角色）关联表中的关联信息
        employeeService.deleteEmployeeRoleRelation(id);
        return json;
    }


    @RequestMapping("/batchDelete")
    @ResponseBody
    public JsonResult batchDelete(Long[] ids) {
        JsonResult json = new JsonResult();
        employeeService.batchDeleteById(ids);
        return json;
    }

    @RequiresPermissions(value = {"员工的编辑", "employee:input"}, logical = Logical.OR)
    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            //查询回显数据
            model.addAttribute("employee", employeeService.get(id));
            //回显该用户所拥有的角色
        }
        //将角色加载出来
        model.addAttribute("roles", roleService.listAll());

        //将部门表查出，用于selected标签选择
        model.addAttribute("departments", departmentService.listAll());
        return "employee/input";
    }

    @RequiresPermissions(value = {"员工修改和新增", "employee:saveOrUpdate"}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    public String saveOrUpdate(Employee entry, Long[] roleIds) {
        if (entry.getId() != null) {
            //修改role角色
            //先删除原来的 员工<=>角色 关系
            employeeService.deleteEmployeeRoleRelation(entry.getId());

            employeeService.update(entry, roleIds);

        } else {
            employeeService.saveOrUpdate(entry, roleIds);
        }
        return "redirect:/employee/list.do";
    }

    @RequestMapping("/exportExcel")
    public void exportExcel(EmployeeQueryObject qo, HttpServletResponse response) {
        //设置下载文件的名称
        response.setHeader("Content-Disposition", "attachment;filename=employee.xls");
        Workbook book = employeeService.exportExcel(qo);
        try {
            book.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/importExcel")
    public String importExcel(MultipartFile xls) {
        //设置下载文件的名称
        try {
            employeeService.importExcel(xls.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/employee/list.do";
    }
}
