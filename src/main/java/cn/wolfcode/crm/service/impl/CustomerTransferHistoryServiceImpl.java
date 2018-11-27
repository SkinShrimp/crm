package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.CustomerTransferHistory;
import cn.wolfcode.crm.domain.Employee;
import cn.wolfcode.crm.mapper.CustomerTransferHistoryMapper;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.ICustomerTransferHistoryService;
import cn.wolfcode.crm.util.UserContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomerTransferHistoryServiceImpl implements ICustomerTransferHistoryService {

    @Autowired
    private CustomerTransferHistoryMapper customerTransferHistoryMapper;

    @Override
    public void save(CustomerTransferHistory entry) {
        Employee currentEmp = UserContext.getCurrentEmp();
        entry.setOperator(currentEmp);
        entry.setOperateTime(new Date());
        customerTransferHistoryMapper.insert(entry);
    }

    @Override
    public PageInfo<CustomerTransferHistory> query(QueryObject qo) {
        //在这条语句后面执行的sql语句将会加上LIMIT分页语句
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<CustomerTransferHistory> list = customerTransferHistoryMapper.selectForList(qo);
        return new PageInfo<CustomerTransferHistory>(list);
    }
}
