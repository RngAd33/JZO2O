package com.jzo2o.orders.manager.handler;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjUtil;
import com.jzo2o.api.trade.RefundRecordApi;
import com.jzo2o.api.trade.dto.response.ExecutionResultResDTO;
import com.jzo2o.orders.base.enums.OrderRefundStatusEnum;
import com.jzo2o.orders.base.model.domain.Orders;
import com.jzo2o.orders.base.model.domain.OrdersRefund;
import com.jzo2o.orders.manager.service.IOrdersManagerService;
import com.jzo2o.orders.manager.service.IOrdersRefundService;
import com.xxl.job.core.handler.annotation.XxlJob;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 订单处理器
 */
@Component
public class OrdersHandler {

    @Resource
    private IOrdersRefundService ordersRefundService;

    @Resource
    private RefundRecordApi refundRecordApi;

    @Resource
    private IOrdersManagerService ordersManagerService;

    @Resource
    private OrdersHandler owner;

    /**
     * 定时读取退款表中的数据, 然后调用支付服务的退款接口
     */
    @XxlJob(value = "handleRefundOrders")
    public void handleRefundOrders() {
        // 读取退款表中的数据
        List<OrdersRefund> ordersRefundList = ordersRefundService.queryRefundOrderListByCount(100);
        if (CollUtil.isEmpty(ordersRefundList)) return;

        // 遍历查询到的数据
        for (OrdersRefund ordersRefund : ordersRefundList) {
            // - 调用支付服务的退款接口
            ExecutionResultResDTO executionResultResDTO
                    = refundRecordApi.refundTrading(ordersRefund.getTradingOrderNo(), ordersRefund.getRealPayAmount());
            if (ObjUtil.isNotNull(executionResultResDTO)) {
                // - 根据退款接口的返回值做处理
                if (executionResultResDTO.getRefundStatus() != OrderRefundStatusEnum.REFUNDING.getStatus()) {
                    // - 如果返回值不是退款中, 需要做后续处理
                    owner.afterRefund(ordersRefund, executionResultResDTO);
                }
            }
        }
    }

    /**
     * 退款后续处理
     *
     * @param ordersRefund
     * @param executionResultResDTO
     */
    @Transactional(rollbackFor = Exception.class)
    public void afterRefund(OrdersRefund ordersRefund, ExecutionResultResDTO executionResultResDTO) {
        // 更新订单表中退款相关字段(refund_status 退款状态 refund_no 支付服务退款单号 refund_id 第三方支付的退款单号)
        Orders orders = new Orders();
        orders.setId(ordersRefund.getId());
        orders.setRefundNo(executionResultResDTO.getRefundNo());
        orders.setRefundId(executionResultResDTO.getRefundId());
        orders.setRefundStatus(executionResultResDTO.getRefundStatus());

        // 删除退款表中的数据
        if (ordersManagerService.updateById(orders)){
            ordersRefundService.removeById(ordersRefund.getId());
        }
    }
}