package cn.wolfcode.crm.web.controller;

import cn.wolfcode.crm.domain.Role;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IPermissionService;
import cn.wolfcode.crm.service.IRoleService;
import cn.wolfcode.crm.util.JsonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IPermissionService permissionService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") QueryObject qo) {
        model.addAttribute("pageInfo", roleService.query(qo));
        return "role/list";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult json = new JsonResult();
        roleService.delete(id);

        //当角色删除的时候删除(角色与权限)的关系
        roleService.deleteRolePermission(id);
        //当角色删除的时候删除(角色与员工)的关系
        roleService.deleteRoleEmployee(id);
        return json;
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        if (id != null) {
            model.addAttribute("role", roleService.get(id));
        }

        //在类表中回显permission权限
        model.addAttribute("permissions", permissionService.listAll());
        return "role/input";
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(Role entry, Long[] permissionIds) {
        JsonResult json = new JsonResult();
        if (entry.getId() != null) {
            //删除原来角色对应的权限
            roleService.deleteRolePermission(entry.getId());

            roleService.update(entry, permissionIds);
        } else {
            roleService.save(entry, permissionIds);
        }
        return json;
    }
}
