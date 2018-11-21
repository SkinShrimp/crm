package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Role;
import cn.wolfcode.crm.mapper.RoleMapper;
import cn.wolfcode.crm.query.PageResult;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public void save(Role entry) {
        roleMapper.insert(entry);
    }

    @Override
    public void delete(Long id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Role entry) {
        roleMapper.updateByPrimaryKey(entry);
    }

    @Override
    public Role get(Long id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Role> listAll() {
        return roleMapper.selectAll();
    }

    @Override
    public void deleteRolePermission(Long roleId) {
        roleMapper.deleteRolePermission(roleId);
    }

    @Override
    public void insertRolePermission(Long permissionId, Long roleId) {
        roleMapper.insertRolePermission(permissionId, roleId);
    }

    @Override
    public void deleteRoleEmployee(Long roleId) {
        roleMapper.deleteRoleEmployee(roleId);
    }

    @Override
    public PageInfo<Role> query(QueryObject qo) {
        //在这行代码下面的第一个SQL会拼接分页的片段
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Role> list = roleMapper.selectForList(qo);
        return new PageInfo<>(list);
    }
}
