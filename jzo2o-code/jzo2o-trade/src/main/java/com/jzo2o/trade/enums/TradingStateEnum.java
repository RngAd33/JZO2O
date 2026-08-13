package com.jzo2o.trade.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 交易单状态枚举
 *
 * @author zzj
 * @version 1.0
 */
@Getter
@AllArgsConstructor
public enum TradingStateEnum {

    DFK(1, "待付款"),
    FKZ(2, "正在支付"),
    FKSB(3, "付款失败"),
    YJS(4, "已付款"),
    QXDD(5, "取消订单"),
    MD(6, "免单"),
    GZ(7, "挂账");

    @EnumValue
    @JsonValue
    private final Integer code;
    private final String value;

}