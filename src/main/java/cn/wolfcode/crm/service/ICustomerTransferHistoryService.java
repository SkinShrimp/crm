package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.CustomerTransferHistory;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

public interface ICustomerTransferHistoryService {
    public abstract void save(CustomerTransferHistory entry);

    //角色不支持高级查询
    public abstract PageInfo<CustomerTransferHistory> query(QueryObject qo);
}
