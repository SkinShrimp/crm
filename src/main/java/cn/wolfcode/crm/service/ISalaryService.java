package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.Salary;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ISalaryService {
    public abstract void save(Salary entry);

    public abstract void update(Salary entry);

    public abstract PageInfo<Salary> query(QueryObject qo);

}
