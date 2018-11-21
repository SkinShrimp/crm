package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.Department;
import cn.wolfcode.crm.query.QueryObject;

import java.util.List;

public interface DepartmentMapper {
    public abstract void insert(Department entry);

    public abstract void deleteByPrimaryKey(Long id);

    public abstract void updateByPrimaryKey(Department entry);

    public abstract Department selectByPrimaryKey(Long id);

    public abstract List<Department> selectAll();

    public abstract List<Department> selectForList(QueryObject qo);
}
