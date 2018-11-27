package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.CustomerTraceHistory;
import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.mapper.CustomerTraceHistoryMapper;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.ICustomerTraceHistoryService;
import cn.wolfcode.crm.util.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerTraceHistoryServiceImpl implements ICustomerTraceHistoryService {
    @Autowired
    private CustomerTraceHistoryMapper customerTraceHistoryMapper;

    @Override
    public void save(CustomerTraceHistory entry) {
        Employee currentEmp = UserContext.getCurrentEmp();
        entry.setInputUser(currentEmp);
        entry.setInputTime(new Date());
        customerTraceHistoryMapper.insert(entry);
    }

    @Override
    public void update(CustomerTraceHistory entry) {
        customerTraceHistoryMapper.updateByPrimaryKey(entry);
    }

    @Override
    public PageInfo<CustomerTraceHistory> query(QueryObject qo) {
        //在这条语句后面执行的sql语句将会加上LIMIT分页语句
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<CustomerTraceHistory> list = customerTraceHistoryMapper.selectForList(qo);
        return new PageInfo<CustomerTraceHistory>(list);
    }
}
