package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.Customer;
import cn.wolfcode.crm.query.QueryObject;
import java.util.List;

public interface CustomerMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Customer record);

    Customer selectByPrimaryKey(Long id);

    List<Customer> selectAll();

    int updateByPrimaryKey(Customer record);

    List<Customer> selectForList(QueryObject qo);
}