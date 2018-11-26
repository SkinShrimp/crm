package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Customer;
import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.query.CustomerQueryObject;
import cn.wolfcode.crm.service.ICustomerService;
import cn.wolfcode.crm.service.IEmployeeService;
import cn.wolfcode.crm.service.ISystemDictionaryItemService;
import cn.wolfcode.crm.util.JsonResult;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IEmployeeService employeeService;
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @RequiresPermissions(value = {"客户列表查询", "customer:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomerQueryObject qo) {
        //根据用户的信息进行查询
        //如果是超管或者营销经理，查询所有
        Subject subject = SecurityUtils.getSubject();
        Employee emp = (Employee) subject.getPrincipal();
        if (!emp.isAdmin() && !subject.hasRole("CLIENT_MGR")) {
            qo.setSellerId(emp.getId());
        }

        model.addAttribute("pageInfo", customerService.query(qo));

        //营销人员列表(高级查询)
        model.addAttribute("sellers", employeeService.ListAllSellers());

        //数据共享编辑模态框用
        //查询职业字典
        model.addAttribute("jobs", systemDictionaryItemService.listJobs());
        //查询用户来源字典
        model.addAttribute("sources", systemDictionaryItemService.listSources());

        return "customer/potentialList";
    }

    @RequiresPermissions(value = {"客户删除", "customer:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        customerService.delete(id);
        return json;
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            //查询回显数据
            model.addAttribute("customer", customerService.get(id));
        }
        return "customer/input";
    }

    @RequiresPermissions(value = {"客户保存或删除", "customer:saveOrUpdate "}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Customer entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            customerService.update(entry);
        } else {
            customerService.save(entry);
        }
        return json;
    }
}
