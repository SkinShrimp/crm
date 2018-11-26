package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.JsonUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Setter
@Getter
public class Customer extends BaseDomain {
    //潜在用户
    public static final Integer STATUS_POTENTIAL = 1;
    //用户池
    public static final Integer STATUS_POOLED = 2;
    //流失
    public static final Integer STATUS_FLOW = 3;
    //开发失败
    public static final Integer STATUS_FAILURE = 4;
    private String name;

    //0:女 1:男
    public String getGenderName() {
        return this.getGender() == 0 ? "女" : "男";
    }

    private Integer age;

    private Integer gender;

    private String tel;

    private String qq;

    private SystemDictionaryItem job;//用户从事的职业

    private SystemDictionaryItem source;//用户来源 电话||传销

    private Employee seller;//销售人员

    private Employee inputUser;//录入人

    private Date inputTime;

    //用户状态： 1、潜在用户 2、客户池 3、流失 4、开发失败
    //使用英文常量，见名知意
    private Integer status = STATUS_POTENTIAL;

    public String getStatusName() {
        switch (this.status) {
            case 1:
                return "潜在用户";
            case 2:
                return "客户池";
            case 3:
                return "流失";
            case 4:
                return "开发失败";
            default:
                return "未知";
        }

    }

    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("name", name);
        map.put("age", age);
        map.put("gender", gender);
        map.put("tel", tel);
        map.put("qq", qq);
        map.put("jobId", job.getId());
        map.put("sourceId", source.getId());
        if (seller != null) {
            map.put("sellerId", seller.getId());
        }
        return JsonUtil.toJsonString(map);
    }

}