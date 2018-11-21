package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Department;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IDepartmentService;
import cn.wolfcode.crm.util.JsonResult;
import cn.wolfcode.crm.util.RequiredPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    private IDepartmentService departmentService;
    @Autowired
    private Environment environment;

    @RequiredPermission("部门列表查询")
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") QueryObject qo) {
        Environment e = environment;
        model.addAttribute("pageInfo", departmentService.query(qo));
        return "department/list";
    }

    @RequiredPermission("部门删除")
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        departmentService.delete(id);
        return json;
    }
    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            //查询回显数据
            model.addAttribute("department", departmentService.get(id));
        }
        return "employee/input";
    }

    @RequiredPermission("部门保存或删除")
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Department entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            departmentService.update(entry);
        } else {
            departmentService.save(entry);
        }
        return json;
    }
}
