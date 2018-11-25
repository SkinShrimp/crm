package cn.wolfcode.crm.query;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SystemDictionaryItemQueryObject extends QueryObject {
    private Long parentId;
}
