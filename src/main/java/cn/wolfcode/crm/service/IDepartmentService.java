package cn.wolfcode.crm.service;

import cn.wolfcode.crm.query.PageResult;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.domain.Department;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface IDepartmentService {
    public abstract void save(Department entry);

    public abstract void delete(Long id);

    public abstract void update(Department entry);

    public abstract Department get(Long id);

    public abstract List<Department> listAll();

    public abstract PageInfo<Department> query(QueryObject qo);

}
