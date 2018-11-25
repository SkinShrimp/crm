package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.JsonUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Setter
@Getter
public class SystemDictionaryItem extends BaseDomain {
    private SystemDictionary parent;//目录明细相关的目录结构幸喜

    private String title;

    private Integer sequence;

    //将对象转换成JSON字符串格式
    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("title", title);
        map.put("sequence", sequence);
        map.put("parentId", parent.getId());
        map.put("parentTitle", parent.getTitle());
        return JsonUtil.toJsonString(map);
    }

}