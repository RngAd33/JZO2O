package com.jzo2o.orders.base.service.impl;

import cn.hutool.core.util.ObjUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jzo2o.orders.base.mapper.OrdersMapper;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.base.model.dto.OrderUpdateStatusDTO;
import com.jzo2o.orders.base.service.IOrdersCommonService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 订单表 服务实现类
 * </p>
 *
 * @author itcast
 * @since 2023-08-02
 */
@Service
public class OrdersCommonServiceImpl extends ServiceImpl<OrdersMapper, Orders> implements IOrdersCommonService {
    @Override
    public Integer updateStatus(OrderUpdateStatusDTO orderUpdateStatusReqDTO) {
        LambdaUpdateWrapper<Orders> updateWrapper = Wrappers.<Orders>lambdaUpdate()
                .eq(Orders::getId, orderUpdateStatusReqDTO.getId())
                .gt(Orders::getUserId, 0)
                .eq(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getOriginStatus()), Orders::getOrdersStatus,orderUpdateStatusReqDTO.getOriginStatus())
                .set(Orders::getOrdersStatus, orderUpdateStatusReqDTO.getTargetStatus())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getPayStatus()), Orders::getPayStatus,orderUpdateStatusReqDTO.getPayStatus())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getPayTime()), Orders::getPayTime,orderUpdateStatusReqDTO.getPayTime())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getEvaluationTime()), Orders::getEvaluationTime,orderUpdateStatusReqDTO.getEvaluationTime())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getTradingOrderNo()), Orders::getTradingOrderNo,orderUpdateStatusReqDTO.getTradingOrderNo())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getTransactionId()), Orders::getTransactionId,orderUpdateStatusReqDTO.getTransactionId())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getTradingChannel()), Orders::getTradingChannel,orderUpdateStatusReqDTO.getTradingChannel())
                .set(ObjUtil.isNotNull(orderUpdateStatusReqDTO.getRefundStatus()), Orders::getRefundStatus,orderUpdateStatusReqDTO.getRefundStatus());
        boolean update = super.update(updateWrapper);
        return update ? 1 : 0;
    }
}
