package cn.wolfcode.crm.domain;

import cn.wolfcode.crm.util.DateUtil;
import cn.wolfcode.crm.util.JsonUtil;
import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Setter
@Getter
public class CustomerTraceHistory extends BaseDomain {
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date traceTime;//跟进时间

    private String traceDetails;//跟进记录

    private SystemDictionaryItem traceType;//交流方式(字典明细对象)

    //0:优 1:中 2：差
    private Integer traceResult;//跟进结果

    public String getTraceResultFlag() {
        switch (this.traceResult) {
            case 1:
                return "优";
            case 2:
                return "中";
            case 3:
                return "差";
            default:
                return "未知";
        }
    }

    private String remark;//备注

    private Customer customer;//客户Id(客户对象)

    private Employee inputUser;//跟进用户Id(用户id)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date inputTime;//插入时间

    public String getJsonString() {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("customer", customer.getName());
        map.put("traceTime", DateUtil.formatDate(traceTime));
        map.put("traceDetails", traceDetails);
        map.put("traceResult", traceResult);
        map.put("traceType", traceType.getId());
        map.put("remark", remark);
        return JsonUtil.toJsonString(map);
    }
}