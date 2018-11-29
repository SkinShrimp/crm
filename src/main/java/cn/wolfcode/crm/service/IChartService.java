package cn.wolfcode.crm.service;

import cn.wolfcode.crm.query.QueryObject;

import java.util.List;
import java.util.Map;

public interface IChartService {
    List<Map<String, Object>> queryCustomerChart(QueryObject qo);
}
