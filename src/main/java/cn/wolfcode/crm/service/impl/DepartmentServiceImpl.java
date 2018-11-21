package cn.wolfcode.crm.service.impl;

import cn.wolfcode.crm.mapper.DepartmentMapper;
import cn.wolfcode.crm.query.PageResult;
import cn.wolfcode.crm.query.QueryObject;
import cn.wolfcode.crm.service.IDepartmentService;
import cn.wolfcode.crm.domain.Department;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class DepartmentServiceImpl implements IDepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public void save(Department entry) {
        departmentMapper.insert(entry);
    }

    @Override
    public void delete(Long id) {
        departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Department entry) {
        departmentMapper.updateByPrimaryKey(entry);
    }

    @Override
    public Department get(Long id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Department> listAll() {
        return departmentMapper.selectAll();
    }

    @Override
    public PageInfo<Department> query(QueryObject qo) {
        //在这行代码下面的第一个SQL会拼接分页的片段
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Department> list = departmentMapper.selectForList(qo);
        return new PageInfo<Department>(list);
    }
}


