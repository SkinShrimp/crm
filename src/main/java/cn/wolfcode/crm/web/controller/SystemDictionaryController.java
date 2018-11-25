package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.SystemDictionary;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.ISystemDictionaryService;
import cn.wolfcode.crm.util.JsonResult;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequiresPermissions(value = {"字典项列表查询", "systemDictionary:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("pageInfo", systemDictionaryService.query(qo));
        return "systemDictionary/list";
    }

    @RequiresPermissions(value = {"字典项删除", "SystemDictionary:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        systemDictionaryService.delete(id);
        return json;
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            //查询回显数据
            model.addAttribute("systemDictionary", systemDictionaryService.get(id));
        }
        return "systemDictionary/input";
    }

    @RequiresPermissions(value = {"字典项保存或删除", "systemDictionary:saveOrUpdate "}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(SystemDictionary entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            systemDictionaryService.update(entry);
        } else {
            systemDictionaryService.save(entry);
        }
        return json;
    }
}
