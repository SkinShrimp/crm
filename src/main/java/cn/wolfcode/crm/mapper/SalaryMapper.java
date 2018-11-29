package cn.wolfcode.crm.mapper;

import cn.wolfcode.crm.domain.Salary;
import cn.wolfcode.crm.query.QueryObject;

import java.util.List;

public interface SalaryMapper {

    int insert(Salary record);

    List<Salary> selectForList(QueryObject qo);

    int updateByPrimaryKey(Salary record);

}