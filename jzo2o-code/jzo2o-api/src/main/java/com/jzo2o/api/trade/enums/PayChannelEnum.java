package com.jzo2o.api.trade.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 支付渠道枚举
 *
 * @author zzj
 * @version 1.0
 */
@Getter
@AllArgsConstructor
public enum PayChannelEnum {

    ALI_PAY( "支付宝"),
    WECHAT_PAY( "微信支付");

    private final String value;

    /**
     * 根据 value 获取枚举
     *
     * @param value
     * @return
     */
    public static PayChannelEnum getByValue(String value) {
        for (PayChannelEnum payChannelEnum : PayChannelEnum.values()) {
            if (payChannelEnum.getValue().equals(value)) {
                return payChannelEnum;
            }
        }
        throw new IllegalArgumentException("Invalid PayChannelEnum value: " + value);
    }

}