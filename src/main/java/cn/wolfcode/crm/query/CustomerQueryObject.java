package cn.wolfcode.crm.query;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.util.StringUtils;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerQueryObject extends QueryObject {
    //姓名或者电话
    private String keyWord;
    private Long sellerId;
    private Integer status = -1;

    public String getKeyWord() {
        return StringUtils.hasLength(keyWord) ? keyWord.trim() : null;
    }
}
