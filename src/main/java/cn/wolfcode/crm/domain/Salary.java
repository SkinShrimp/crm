package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.JsonUtil;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class Salary extends BaseDomain {

    private BigDecimal money;

    private Integer year;

    private Integer month;

    private Employee emp;//员工信息

    //将对象转换成JSON字符串格式
    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("money", money);
        map.put("year", year);
        if (emp != null) {
            map.put("empName", emp.getName());
            map.put("empId", emp.getId());
        }
        map.put("month", month);
        return JsonUtil.toJsonString(map);
    }

}