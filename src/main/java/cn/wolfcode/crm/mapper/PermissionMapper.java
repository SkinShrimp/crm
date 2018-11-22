package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.Permission;
import cn.wolfcode.crm.query.QueryObject;

import java.util.List;

public interface PermissionMapper {
    public abstract int deleteByPrimaryKey(Long id);

    public abstract int insert(Permission record);

    public abstract Permission selectByPrimaryKey(Long id);

    public abstract List<Permission> selectAll();

    public abstract int updateByPrimaryKey(Permission record);

    public abstract List<Permission> selectForList(QueryObject qo);

    public abstract List<String> selectAllExpression();

    public abstract void deletePermissonRole(Long permissonId);
}