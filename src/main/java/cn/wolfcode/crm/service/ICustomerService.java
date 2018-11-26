package cn.wolfcode.crm.service;

import cn.wolfcode.crm.domain.Customer;
import cn.wolfcode.crm.query.QueryObject;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ICustomerService {
    public abstract void save(Customer entry);

    public abstract void delete(Long id);

    public abstract void update(Customer entry);

    public abstract Customer get(Long id);

    public abstract List<Customer> listAll();

    //角色不支持高级查询
    public abstract PageInfo<Customer> query(QueryObject qo);
}
