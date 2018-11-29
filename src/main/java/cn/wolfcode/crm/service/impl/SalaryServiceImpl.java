package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.domain.Salary;
import cn.wolfcode.crm.mapper.SalaryMapper;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.ISalaryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalaryServiceImpl implements ISalaryService {

    @Autowired
    private SalaryMapper salaryMapper;

    @Override
    public void save(Salary entry) {
        salaryMapper.insert(entry);
    }

    @Override
    public void update(Salary entry) {
        salaryMapper.updateByPrimaryKey(entry);

    }

    @Override
    public PageInfo<Salary> query(QueryObject qo) {
        //在这行代码下面的第一个SQL会拼接分页的片段
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Salary> list = salaryMapper.selectForList(qo);
        return new PageInfo<Salary>(list);
    }
}
