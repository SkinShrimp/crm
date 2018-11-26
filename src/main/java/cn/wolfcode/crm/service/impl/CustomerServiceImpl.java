package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Customer;
import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.mapper.CustomerMapper;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.ICustomerService;
import cn.wolfcode.crm.util.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerServiceImpl implements ICustomerService {
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public void save(Customer entry) {
        //设置录入人，录入时间
        Employee currentEmp = UserContext.getCurrentEmp();
        entry.setInputUser(currentEmp);
        entry.setInputTime(new Date());
        customerMapper.insert(entry);
    }

    @Override
    public void delete(Long id) {
        customerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Customer entry) {
        customerMapper.updateByPrimaryKey(entry);
    }

    @Override
    public Customer get(Long id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Customer> listAll() {
        return customerMapper.selectAll();
    }

    @Override
    public PageInfo<Customer> query(QueryObject qo) {
        //在这行代码下面的第一个SQL会拼接分页的片段
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Customer> list = customerMapper.selectForList(qo);
        return new PageInfo<Customer>(list);
    }
}
