package cn.wolfcode.crm.query;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SalaryQueryObject extends QueryObject {
    private Long empId = -1L;

}
