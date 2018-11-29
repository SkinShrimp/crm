package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Salary;
import cn.wolfcode.crm.query.SalaryQueryObject;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.service.ISalaryService;
import cn.wolfcode.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/salary")
public class SalaryController {
    @Autowired
    private ISalaryService salaryService;
    @Autowired
    private IEmployeeService employeeService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") SalaryQueryObject qo) {
//        qo.setOrderBy("s.sequence DESC");
        //左侧的字典目录栏
        model.addAttribute("emps", employeeService.listAll());

        //共享数据(重要数据流转)
        model.addAttribute("emp", employeeService.get(qo.getEmpId()));
        //查询分页数据
        if (qo.getEmpId() > 0) {
            model.addAttribute("pageInfo", salaryService.query(qo));
        }
        return "salary/list";
    }


    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Salary entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            salaryService.update(entry);
        } else {
            salaryService.save(entry);
        }
        return json;
    }
}
