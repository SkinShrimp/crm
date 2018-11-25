package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.Permission;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Set;

public interface IPermissionService {
    public abstract void save(Permission entry);

    public abstract void delete(Long id);

    public abstract void update(Permission entry);

    public abstract Permission get(Long id);

    public abstract List<Permission> listAll();

    public abstract PageInfo<Permission> query(QueryObject qo);

    public abstract void onload();

    public abstract void deletePermissonRole(Long permissonId);

    public abstract Set<String> getExpressionsByEmployeeId(Long employeeId);
}
