package cn.wolfcode.crm.query;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.util.StringUtils;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeQueryObject extends QueryObject {
    private String keyWord;
    private Integer deptId;

    public String getKeyWord() {
        return StringUtils.hasLength(keyWord) ? keyWord.trim() : null;
    }
}
