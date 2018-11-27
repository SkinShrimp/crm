package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.CustomerTraceHistory;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerTraceHistoryService {
    public abstract void save(CustomerTraceHistory entry);

    public abstract void update(CustomerTraceHistory entry);

    //角色不支持高级查询
    public abstract PageInfo<CustomerTraceHistory> query(QueryObject qo);
}
