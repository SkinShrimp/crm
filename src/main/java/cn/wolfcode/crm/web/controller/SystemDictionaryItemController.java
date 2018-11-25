package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.SystemDictionaryItem;
import cn.wolfcode.crm.query.SystemDictionaryItemQueryObject;
import cn.wolfcode.crm.service.ISystemDictionaryItemService;
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
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequiresPermissions(value = {"字典明细列表查询", "systemDictionaryItem:list"}, logical = Logical.OR)
    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") SystemDictionaryItemQueryObject qo, Integer flag) {
        qo.setOrderBy("s.sequence DESC");
        //左侧的字典目录栏
        model.addAttribute("systemDictionarys", systemDictionaryService.listAll());

        //共享数据(重要数据流转)
        model.addAttribute("parent", systemDictionaryService.get(qo.getParentId()));
        //查询分页数据
        if (qo.getParentId() != null) {
            model.addAttribute("pageInfo", systemDictionaryItemService.query(qo));
        }
        return "systemDictionaryItem/list";
    }

    @RequiresPermissions(value = {"字典明细删除", "systemDictionaryItem:delete"}, logical = Logical.OR)
    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        systemDictionaryItemService.delete(id);
        return json;
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            //查询回显数据
            model.addAttribute("systemDictionaryItem", systemDictionaryItemService.get(id));
        }
        return "systemDictionaryItem/input";
    }

    @RequiresPermissions(value = {"字典明细保存或删除", "systemDictionaryItem:saveOrUpdate "}, logical = Logical.OR)
    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(SystemDictionaryItem entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            systemDictionaryItemService.update(entry);
        } else {
            systemDictionaryItemService.save(entry);
        }
        return json;
    }
}
