package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Customer;
import cn.wolfcode.crm.domain.CustomerTransferHistory;
import cn.wolfcode.crm.query.CustomerTransferHistoryQueryObject;
import cn.wolfcode.crm.service.ICustomerService;
import cn.wolfcode.crm.service.ICustomerTransferHistoryService;
import cn.wolfcode.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customerTransferHistory")
public class CustomerTransferHistoryController {
    @Autowired
    private ICustomerTransferHistoryService customerTransferHistoryService;
    @Autowired
    private ICustomerService customerService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomerTransferHistoryQueryObject qo) {
        model.addAttribute("pageInfo", customerTransferHistoryService.query(qo));
        return "customerTransferHistory/list";
    }


    @RequestMapping("/save")
    @ResponseBody
    public JsonResult save(CustomerTransferHistory entry) {
        JsonResult json = new JsonResult();
        //保存移交信息
        customerTransferHistoryService.save(entry);

        //移交后客户的营销人员发生改变
        customerService.updateSellerAndStatusById(entry.getCustomer(), entry.getNewSeller());
        return json;
    }
}
