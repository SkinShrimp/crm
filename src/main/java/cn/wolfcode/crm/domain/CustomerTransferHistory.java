package cn.wolfcode.crm.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CustomerTransferHistory extends BaseDomain {
    private Customer customer;//客户信息

    private Employee operator;//移交人员

    private Date operateTime;

    private Employee oldSeller;//旧营销人员

    private Employee newSeller;//新营销人员

    private String reason;

}