package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Permission;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IPermissionService;
import cn.wolfcode.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/permission")
public class PermissionController {
    @Autowired
    private IPermissionService permissionService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("pageInfo", permissionService.query(qo));
        return "permission/list";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();

        permissionService.delete(id);
        //当权限删除的时候(权限与角色)关系删除
        permissionService.deletePermissonRole(id);
        return json;
    }
    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            model.addAttribute("permission", permissionService.get(id));
        }
        return "permission/input";
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Permission entry) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            permissionService.update(entry);
        } else {
            permissionService.save(entry);
        }
        return json;
    }

    @RequestMapping("/onload")
    @ResponseBody
    public JsonResult permissionOnload(){
        JsonResult json = new JsonResult();
        permissionService.onload();
        return json;
    }
}
