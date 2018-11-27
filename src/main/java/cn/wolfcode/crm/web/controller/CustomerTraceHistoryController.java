package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.CustomerTraceHistory;
import cn.wolfcode.crm.query.CustomerTraceHistoryQueryObject;
import cn.wolfcode.crm.service.ICustomerTraceHistoryService;
import cn.wolfcode.crm.service.ISystemDictionaryItemService;
import cn.wolfcode.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/customerTraceHistory")
public class CustomerTraceHistoryController {
    @Autowired
    private ICustomerTraceHistoryService customerTraceHistoryService;
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") CustomerTraceHistoryQueryObject qo) {
        model.addAttribute("pageInfo", customerTraceHistoryService.query(qo));

        //更进--交流方式--数据字典
        model.addAttribute("traceTypes", systemDictionaryItemService.listTypes());
        return "customerTraceHistory/list";
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
        }

        return "customerTraceHistory/input";
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(CustomerTraceHistory entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            customerTraceHistoryService.update(entry);
        } else {
            customerTraceHistoryService.save(entry);
        }
        return json;
    }
}
