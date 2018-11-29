package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.JsonUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Employee extends BaseDomain {
    private String name;

    private String password;

    private String email;

    private Integer age;

    private boolean admin;

    private Department department;

    private List<Role> list;

    //将对象转换成JSON字符串格式
    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        return JsonUtil.toJsonString(map);
    }

}