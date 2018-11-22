package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.JsonUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Permission extends BaseDomain {
    private String name;

    private String expression;

    //将对象转换成JSON字符串格式
    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("expression", expression);
        return JsonUtil.toJsonString(map);
    }
}