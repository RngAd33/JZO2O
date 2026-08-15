package com.jzo2o.orders.manager.strategy.impl;

import cn.hutool.core.bean.BeanUtil;
import com.jzo2o.common.expcetions.ForbiddenOperationException;
import com.jzo2o.orders.base.enums.OrderStatusEnum;
import com.jzo2o.orders.base.mapper.OrdersCanceledMapper;
import com.jzo2o.orders.base.model.domain.OrdersCanceled;
import com.jzo2o.orders.base.model.dto.OrderUpdateStatusDTO;
import com.jzo2o.orders.base.service.IOrdersCommonService;
import com.jzo2o.orders.manager.model.dto.OrderCancelDTO;
import com.jzo2o.orders.manager.strategy.OrderCancelStrategy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;

/**
 * 普通用户取消未支付订单
 */
@Service("1:NO_PAY")
public class CommonUserNoPayOrderCancelStrategy implements OrderCancelStrategy {

    @Resource
    private IOrdersCommonService ordersCommonService;

    @Resource
    private OrdersCanceledMapper ordersCanceledMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancel(OrderCancelDTO orderCancelDTO) {
        // 更新订单状态
        OrderUpdateStatusDTO orderUpdateStatusDTO = OrderUpdateStatusDTO.builder()
                .id(orderCancelDTO.getId())
                .originStatus(OrderStatusEnum.NO_PAY.getStatus())
                .targetStatus(OrderStatusEnum.CANCELED.getStatus())
                .build();
        int i = ordersCommonService.updateStatus(orderUpdateStatusDTO);
        if (i <= 0){
            throw new ForbiddenOperationException("订单取消失败");
        }
        // 保存取消记录
        OrdersCanceled ordersCanceled = BeanUtil.copyProperties(orderCancelDTO, OrdersCanceled.class);
        ordersCanceled.setCancelTime(LocalDateTime.now());
        ordersCanceledMapper.insert(ordersCanceled);
    }

}